Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbTH2QLK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbTH2QLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:11:10 -0400
Received: from tmi.comex.ru ([217.10.33.92]:18325 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261236AbTH2QLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:11:07 -0400
X-Comment-To: Alex Tomas
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] extents support for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
To: linux-kernel@vger.kernel.org
Organization: HOME
Date: Fri, 29 Aug 2003 20:16:31 +0400
In-Reply-To: <m3r834phqi.fsf@bzzz.home.net> (Alex Tomas's message of "Fri,
 29 Aug 2003 20:10:29 +0400")
Message-ID: <m3lltcphgg.fsf@bzzz.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <m33cfm19ar.fsf@bzzz.home.net> <3F4E4605.6040706@wmich.edu>
	<m3vfshrola.fsf@bzzz.home.net> <3F4F7129.1050506@wmich.edu>
	<m3vfsgpj8b.fsf@bzzz.home.net> <3F4F76A5.6020000@wmich.edu>
	<m3r834phqi.fsf@bzzz.home.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I forgot the most important thing - I need vmstat output for all runs
to anylize performing

>>>>> Alex Tomas (AT) writes:

 AT> quite interesting result. could you help me to investigate that?
 AT> it would be great to go through following steps:
 AT> 1) create fresh ext3 fs
 AT> 2) mount it w/o extents option
 AT> 3) run dbench 16 for few times (say, 4)
 AT>    make sure it performs on that filesystem (cd <mntpoint>; dbench -c ... 16)
 AT> 4) unmount fs
 AT> 5) recreate that fs
 AT> 6) mount it with extents option
 AT>    'EXT3-fs: file extents enabled' should be printed in logs
 AT> 7) run dbench 16 for few times
 AT> 8) unmount that fs and take a look in logs, you should see stats info about
 AT>    extents usage


