Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbULaNSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbULaNSR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 08:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbULaNSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 08:18:17 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:43670 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S262034AbULaNSF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 08:18:05 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-ac1
Date: Fri, 31 Dec 2004 08:18:03 -0500
User-Agent: KMail/1.7
Cc: Jan Dittmer <jdittmer@ppp0.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <1104103881.16545.2.camel@localhost.localdomain> <200412310705.52976.gene.heskett@verizon.net> <41D5485A.4060709@ppp0.net>
In-Reply-To: <41D5485A.4060709@ppp0.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412310818.03720.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.52.185] at Fri, 31 Dec 2004 07:18:04 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 December 2004 07:38, Jan Dittmer wrote:
[...]
Thanks, now if I can remember that..

>Try
>
>$ ./parsemce -e 0xba -b 2 -s d40040000000017a -a 0
>Status: (ba) Error IP valid
>Restart IP invalid.
>parsebank(2): d40040000000017a @ 0
>        External tag parity error
>        Correctable ECC error
>        Address in addr register valid
>        Error enabled in control register
>        Error overflow
>        Memory heirarchy error
>        Request: Generic error
>        Transaction type : Generic
>        Memory/IO : I/O
>
>See [1] for a possible explanation. I hope the link works. It's a
> message from DaveJ about the same error:
>"Looks like the L2 cache ECC checking spotted something going wrong,
>and fixed it up. This can happen in cases where there is inadequate
>cooling, power, or overclocking (or in rare circumstances, flaky
> CPUs)"
>
>Jan

Is 132F too hot for an XP-2800?  Based on my experience with an 
XP1400, which ran for several years well above 165F, I'd think not. 
And its running at about 2150 mhz.  My previous XP1400 ran, and is 
running at 1400 mhz in a new board, ran near 170F in the old board, 
but now in a Mach Speed board with a 233mhz fsb, its only running at 
34C.  There is a Zalman flower with a 4" fan turning at 1834 rpms on 
this XP2800, and a glaciator on the XP1400 turning about 6 grand, 
noisy.

This ones running setiathome of course, and so was the XP1400 when it 
was in this machine.

>[1]

Yikes, I'll have to save this out, and make it all into one line with 
vim & give it a try.  ATM though, I've got a cold & headed back to 
bed.  Friggin miserable.

Thanks again.

> http://groups-beta.google.com/group/linux.kernel/browse_thread/thre
>ad/bbf1d32da11eb369/8b2300b83ac0ab9e?q=%22Restart+IP+invalid%22&_don
>e=%2Fgroups%3Fq%3D%22Restart+IP+invalid%22%26hl%3Den%26lr%3D%26clien
>t%3Dfirefox%26rls%3Dorg.mozilla:en-US:unofficial%26sa%3DN%26tab%3Dwg
>%26&_doneTitle=Back+to+Search&&d#8b2300b83ac0ab9e -
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
