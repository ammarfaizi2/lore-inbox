Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbSK3Xg5>; Sat, 30 Nov 2002 18:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSK3Xg5>; Sat, 30 Nov 2002 18:36:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18439 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261337AbSK3Xgz>; Sat, 30 Nov 2002 18:36:55 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel space access to user space functions
Date: 30 Nov 2002 15:44:18 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <asbigi$gh7$1@cesium.transmeta.com>
References: <3DE91CBF.295C1491@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3DE91CBF.295C1491@bigpond.net.au>
By author:    Chris Ison <cisos@bigpond.net.au>
In newsgroup: linux.dev.kernel
>
> I realize I asked this previously, but the answer given was not to the
> question I asked.
> 
> How can I get a kernel module to call a function within a program?
> 

You can't.

> The reason being I am creating a software midi driver and already have a
> small program that does what I want the driver to do, problem is all the
> math in the program is floating point.

There are functions now in the kernel (kernel_fpu_begin() and
kernel_fpu_end()) to allow the use of floating point inside the
kernel.

> What I would like to do, is be able to run the program, and have the
> kernel software midi driver call a function within the program to que up
> midi events, and have the program do all the hard work of the wavetable
> synth.
> 
> This way, any improvements to the software don't have to be translated
> to the driver, and visa versa.
> 
> How can I make this happen. And please give an example.

You can't.

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
