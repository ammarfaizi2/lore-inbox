Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280074AbRJaFJo>; Wed, 31 Oct 2001 00:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280076AbRJaFJe>; Wed, 31 Oct 2001 00:09:34 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:13572
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S280074AbRJaFJT>; Wed, 31 Oct 2001 00:09:19 -0500
Message-Id: <5.1.0.14.2.20011030235723.022818d8@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 31 Oct 2001 00:06:57 -0500
To: linux-kernel@vger.kernel.org
From: Stevie O <stevie@qrpff.net>
Subject: Local APIC option (CONFIG_X86_UP_APIC) locks up Inspiron 8100
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just bought a Dell Inspiron 8100. <long story of what happened snipped>. 
So after a few dozen kernel builds I've narrowed it down to this: When I 
build the 2.4.13 kernel with Local APIC support (CONFIG_X86_UP_APIC=y), two 
things happen (so far that i've noticed):

1) The power button stops working, as if the kernel was intercepting the 
signal and ignoring it. I have to hold it for five seconds to turn off the 
machine.

2) Anytime I change the plugged-in status of the AC adapter (if it wasn't 
plugged in, if I plug it in; if it was plugged in, if I unplug it), the 
machine locks up completely.

As the help on this option has no warnings about it being dangerous to use, 
I would really like to help find out what part of it is locking up. The 
only problem, is... I have no idea where to start.

One other thing: how would the kernel react to the "SpeedStep" feature of 
changing the CPU speed while things are still running?


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

