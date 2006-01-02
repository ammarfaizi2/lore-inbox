Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWABSh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWABSh7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 13:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWABSh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 13:37:58 -0500
Received: from exo3753.pck.nerim.net ([213.41.240.142]:41915 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S1750933AbWABSh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 13:37:58 -0500
Date: Mon, 2 Jan 2006 19:37:40 +0100
From: Willy Tarreau <wtarreau@exosec.fr>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Grant Coady <grant_lkml@dodo.com.au>
Subject: [ANNOUNCE] Linux 2.4.32-hf32.1
Message-ID: <20060102183740.GB5332@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

first I wish you a Happy New Year !

I spent the day updating the 2.4-hf branch (in fact, mostly the scripts
themselves), because there have been several important fixes since last
release (2005/11/04). I counted 7 security fixes, 3 major fixes and 6
minor fixes. This update will bring you to the same level as 2.4.33-pre1.
Please check the changelog appended to this mail for more details.

As I previously stated it, the numbering scheme has changed so that all
versions now share the same -hf suffix. For instance, this new version
is numbered '-hf32.1', which means that the fixes are up-to-date with
the first hotfix for mainline 2.4.32. Eventhough the name is ugly, it
will then become obvious for anyone that 2.4.29-hf32.1 is late when
2.4.33-hf is out. As a side effect, I will only announce the lastest
release, as everyone can understand that older ones are available too.

As nearly two months have elapsed since last -hf (2.4.31-hf8), a lot
of things have been merged. In fact, I had even made a 2.4.31-hf9 which
was never released due to a lack of time. So you'll find references to
it in the changelog but it will not be available for download as it is
already obsolete (except upon request, but I doubt anyone will be
interested). I intend to be able to release more often as I found how
to make my scripts benefit from git to grab the patches that I consider
useful.

I've built the kernel for i686 with all modules enabled to ensure
everything was OK, but did not boot it. I've not built incremental
diffs, but I can make them upon request if anyone needs them. Right
now, patches for kernels 2.4.29 to 2.4.32, both split up and as a
whole patch, with and without extraversion are provided.

As usual, I'm sure that Grant will be glad to do a full rebuild for all
of his machines and post the results online (Thanks Grant ;-)).

 URLs of interest :

    hotfixes home : http://linux.exosec.net/kernel/2.4-hf/
     last version : http://linux.exosec.net/kernel/2.4-hf/LATEST/LATEST/
         RSS feed : http://linux.exosec.net/kernel/hf.xml
    build results : http://bugsplatter.mine.nu/test/linux-2.4/ (Grant's site)


If anything's wrong, please bug me.

Happy kernel hacking for 2006,
Willy

