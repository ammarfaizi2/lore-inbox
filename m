Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132822AbRDDQxT>; Wed, 4 Apr 2001 12:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132833AbRDDQxJ>; Wed, 4 Apr 2001 12:53:09 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:2515 "HELO
	smtp2.pandora.be") by vger.kernel.org with SMTP id <S132822AbRDDQw4>;
	Wed, 4 Apr 2001 12:52:56 -0400
Message-ID: <000701c0bd17$1232f200$04a8a8c0@vortex.prv>
From: "Vik Heyndrickx" <vik.heyndrickx@pandora.be>
To: <rhw@memalpha.cx>, <linux-kernel@vger.kernel.org>
Cc: <rgooch@atnf.csiro.au>
Subject: 2.4 kernel hangs on 486 machine at boot
Date: Wed, 4 Apr 2001 16:53:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Problem: Linux kernel 2.4 consistently hangs at boot on 486 machine

Shortly after lilo starts the kernel it hangs at the following message:
Checking if this processor honours the WP bit even in supervisor mode...
<blinking cursor>

I experience this problem on a VLB AMD 486 DX/2-66 system. This machine ran
all kernels up to 2.2.18 without any problem (it still does).

This 2.4 kernel runs fine on a Pentium, Pentium II and even on a _386DX_
(!!!), but not on my 486 machine (which I am using as a router, and I
thought: let's try the netfilter/iptables feature :) on it).

I tried both the precompiled 2.4 kernels from the Redhat linux releases and
betas, and a couple of self-compiled stock kernels (2.4.0 and 2.4.2) from
ftp://ftp.kernel.org/

Anyway I find it obvious that the kernel hangs only on 486's (and probably
not all of them), so it must be a bug (can I call this an oops? ;-))
I'm not familiar enough with the kernel and protected mode x86 asm to
correct this problem myself, but if anyone would know what may be causing
this (probably in arch/i386/mm/init.c) I can rebuild, install and test any
supplied patches (don't send entire precompiled kernels to me, please).

BTW Keep in mind that I'm not on any kernel related mailing list, but I like
to be informed.

Thanks & kind regards,

--
Vik


