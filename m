Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSIAM0O>; Sun, 1 Sep 2002 08:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316878AbSIAM0O>; Sun, 1 Sep 2002 08:26:14 -0400
Received: from dclient217-162-176-39.hispeed.ch ([217.162.176.39]:32773 "EHLO
	alder.intra.bruli.net") by vger.kernel.org with ESMTP
	id <S316857AbSIAM0N>; Sun, 1 Sep 2002 08:26:13 -0400
From: "Martin Brulisauer" <martin@bruli.net>
To: linux-kernel@vger.kernel.org
Date: Sun, 1 Sep 2002 14:30:41 +0200
Subject: Re: gcc-3.2
Reply-to: martin@bruli.net
Message-ID: <3D722491.13287.1C334D28@localhost>
In-reply-to: <Pine.LNX.4.44.0208301446030.1363-100000@boston.corp.fedex.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not on all platforms. I tried linux-2.4.19 with gcc-3.2.1 (csv):

Unable to handle kernel paging request at virtual address 
0000013000000ac0
Oops 0
pc = [<fffffc0000331200>]  ra = [<fffffffc00186aa8>]  ps = 0007   
Not tainted
v0 = 0000000000000000  t0 = 0000000000000001  t1 = 
0000000000000000
t2 = 0000013000000ac0  t3 = 0000000000000002  t4 = 
0000000000000001
t5 = fffffc0000571090  t6 = fffffc00059675f4  t7 = fffffc0005500000
s0 = 0000013000000608  s1 = fffffc00065ed000  s2 = 
fffffc00066600c0
s3 = fffffc00065ed000  s4 = fffffc00066600c0  s5 = 
0000013000000ac0
s6 = 0000000000000001
a0 = 0000000000000007  a1 = fffffc00065ed000  a2 = 
0000000000000000
a3 = 0000000000000000  a4 = fffffc00065ed0b8  a5 = 
000000000000001c
t8 = 000000000000001f  t9 = fffffc00059675f5  t10= 
0000000000000008
t11= 000002000019a260  pv = fffffc00003311f0  at = 
0000000000000000
gp = fffffffc00196700  sp = fffffc0005503a88
Trace:fffffc000043fe50 fffffc0000435434 fffffc000047ba2c 
fffffc000047b0bc fffffc000043a57c fffffc000043b15c fffffc0000454d9c 
fffffc0000453194 fffffc0000454140 fffffc000047b674 fffffc00004791a8 
fffffc0000478d20 fffffc00004833e8 fffffc000042aca4 fffffc000042c0d8 
fffffc0000313670 fffffc000042be50 fffffc0000313670 fffffc0000313670
Code: 23de0020  6bfa8001  47f00403  221f0007  00000035  
2ffe0000 <a4430000> 47ff0404
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Greetings,
Martin

On 30 Aug 2002, at 14:51, Jeff Chua wrote:

> 
> 
> Just to let everyone knows that gcc-3.2 compiled the linux-2.4.20-pre5
> cleanly and booted up successfully.
> 
> If you recompile glib2.25 after installing gcc-3.2, you'll need to patch
> glib2.25 sysdeps divdi3.c.
> 
> 
> Thanks,
> Jeff
> [ jchua@fedex.com ]
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


