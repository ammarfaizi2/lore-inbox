Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268073AbUHFCMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268073AbUHFCMn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268077AbUHFCMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:12:41 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:32431 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S268061AbUHFCMO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:12:14 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Thu, 5 Aug 2004 22:12:10 -0400
User-Agent: KMail/1.6.82
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408051133.55359.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0408050913320.24588@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408050913320.24588@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408052212.10818.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.63.211] at Thu, 5 Aug 2004 21:12:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 12:26, Linus Torvalds wrote:
[...]
>Anyway, one other thing that makes me worry is the fact that Gene
>apparently has a K7. One of the things AMD has gotten wrong several
> times is prefetching, and it so happens that the dcache code is one
> of the users of the prefetch instruction. prude_dcache() in
> particular.
>
>So I'm also entertaining the notion that there's an actual prefetch
> data corruption, not just the known AMD bug with occasional
> spurious page faults. Who else has seen the problem? What CPU's are
> involved?
>
>		Linus

If we run it down to that, can I bounce it back at AMD as defective?  
Or can it be coded around?  If its bugging my Athlon 2800XP, then I'd 
have to assume (dmesg says its stepping 00 FWIW) that I'm far from 
alone.  AMD is peddling these just like Orville R. sells popcorn.  
And, from previous experience with this particular vendor, if I give 
convincing proof the chip really is from a defective run, I'd suspect 
a replacement would be in a fedex bag & headed my way before the day 
is out.  But I'd need proof of the problem.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
