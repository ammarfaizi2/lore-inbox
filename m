Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265368AbUAJUur (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265393AbUAJUuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:50:46 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:43706 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S265368AbUAJUum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:50:42 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None that appears to be detectable by casual observers
To: Bart Samwel <bart@samwel.tk>
Subject: Re: [PATCH][TRIVIAL] Remove bogus "value 0x37ffffff truncated to 0x37ffffff" warning.
Date: Sat, 10 Jan 2004 15:50:40 -0500
User-Agent: KMail/1.5.1
Cc: Tim Cambrant <tim@cambrant.com>, Mario Vanoni <vanonim@bluewin.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <40001CEE.5050206@bluewin.ch> <200401101342.40728.gene.heskett@verizon.net> <40005D29.5090803@samwel.tk>
In-Reply-To: <40005D29.5090803@samwel.tk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401101550.40901.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.61.108] at Sat, 10 Jan 2004 14:50:40 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 15:14, Bart Samwel wrote:
>Gene Heskett wrote:
[...]
>> Which is correct?
>
>This is a C macro. Apparently in your arch it isn't used in any
>assembler code. The reason that i386 doesn't cast to unsigned long
> is that casts aren't an assembler construct, and this macro is used
> in arch/i386/boot/setup.S. Also, PAGE_OFFSET includes an (unsigned
> long) cast as well, __PAGE_OFFSET doesn't, and that explains why
> i386 uses __PAGE_OFFSET.
>
>-- Bart

Thanks, that clears it up to me.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

