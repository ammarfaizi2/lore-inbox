Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271698AbTHHQmV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 12:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271699AbTHHQmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 12:42:20 -0400
Received: from pop016pub.verizon.net ([206.46.170.173]:25294 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP id S271698AbTHHQmS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 12:42:18 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Timothy Miller <miller@techsource.com>, Jasper Spaans <jasper@vs19.net>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
Date: Fri, 8 Aug 2003 12:42:14 -0400
User-Agent: KMail/1.5.1
References: <20030807180032.GA16957@spaans.vs19.net> <Pine.LNX.4.53.0308081127160.502@chaos> <shsekzwi20h.fsf@charged.uio.no>
In-Reply-To: <shsekzwi20h.fsf@charged.uio.no>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308081242.14646.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop016.verizon.net from [151.205.10.101] at Fri, 8 Aug 2003 11:42:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 August 2003 11:48, Trond Myklebust wrote:
>    >> >>>It changes all occurrences of 'flavour' to 'flavor' in the
>    >> >>>complete tree; I've just comiled all affected files (that
>    >> >>>is, the config resulting from make allyesconfig minus
>    >> >>>already broken stuff) succesfully on i386.
>    >> >>
>    >> >>Arrrgh! You can't be serious!
>    >> >
>    >> > Yes, I am bloody serious; this patch might look purely
>    >> > cosmetic at first sight.. yet, there's a technical reason
>    >> > for at least one part of it. Grep and see the horror:
>    >> >
>    >> > $ egrep -ni 'flavou?r' fs/nfs/inode.c [snip] 1357:
>    >> > rpc_authflavor_t authflavour; [snip]
>
>Anybody who screws with that spelling is setting himself up for the
>red hot poker treatment...

That and toothpicks under the fingernails comes to mind.

>The flavor/flavour thing reflects the fact that the code has been
>written and modified by different people with different
>backgrounds. Some people have been unfortunate enough to be of the
> US persuasion, others have grown up with the British spelling.
>
>Now leave it alone and go do something useful with your lives...
>
>Trond

What about the scenario where both spellings are used in  a header 
someplace that winds up being a systemwide reference?  I don't know 
that it has been, but such a 'correction' has the potential to take 
us back to square one and 1993.  I have had recurring daytime 
nightmares of such possibilities since this subject came up the first 
time a week or so ago.

Methinks the proponent here should find another, more productive 
outlet for his frustrations.  This particular dog won't hunt.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

