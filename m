Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268701AbUHTUNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268701AbUHTUNN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268706AbUHTUNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:13:12 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:62953 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S268701AbUHTUIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:08:55 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Fri, 20 Aug 2004 16:08:50 -0400
User-Agent: KMail/1.6.82
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, v13@priest.com
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408201329.05176.gene.heskett@verizon.net> <20040820201326.23cf62bb.Ballarin.Marc@gmx.de>
In-Reply-To: <20040820201326.23cf62bb.Ballarin.Marc@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408201608.51038.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.62.54] at Fri, 20 Aug 2004 15:08:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 August 2004 14:13, Marc Ballarin wrote:
>On Fri, 20 Aug 2004 13:29:05 -0400
>
>Gene Heskett <gene.heskett@verizon.net> wrote:
>> I tried disabling it in the bios and the machine became unusable
>> for all practical purposes.
>
>Is ECC checking for L2 cache enabled in your BIOS?

There isn't a switch for that and as near as I can tell, no L2 cache 
on this board, only the L1 in the cpu.  If there is an L2, then 
memtest86 can't find it, and I don't see any chips that look like 
seperate memory.  Memtest86 may not know howto enable it if its an 
nforce2 option.  Whatever cache shown as switchable in the bios, 
turning it off makes a very sick bird out of the machine, like a 
33mhz 386sx?

I've located the bios docs on the Biostar site, and was set to print 
them when it locked up the last time. So I'll restart that project 
shortly.

But it does run with it off and for the short time I left it that way, 
no errors.

>BTW: I trimmed the CC list somewhat
>
>Regards

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
