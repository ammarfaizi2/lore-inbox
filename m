Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbUDGOF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263669AbUDGOF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:05:27 -0400
Received: from click.bur.st ([203.34.17.217]:11027 "EHLO click.bur.st")
	by vger.kernel.org with ESMTP id S263656AbUDGOE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:04:57 -0400
Date: Wed, 7 Apr 2004 22:04:50 +0800
From: Trent Lloyd <lathiat@bur.st>
To: linux-kernel@vger.kernel.org
Cc: mkernel@linuxmail.org
Subject: Re: Rewrite Kernel
Message-ID: <20040407140448.GB17074@thump.bur.st>
References: <20040407125406.209FC39834A@ws5-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407125406.209FC39834A@ws5-1.us4.outblaze.com>
User-Agent: Mutt/1.3.28i
X-Random-Number: 5.49095791185383e+20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mohamed,

I am not sure if your intentions are real, but I am assuming they are.

Writing the linux kernel all in assembler would be almost impossible,
it has taken 10 years to get the kernel to the point it is in C, going
that all in ASM would be a) pointless and b) time consuming, your work
would be outdated before its done

Also, the technical know-how for such a task would be large, the kernel
is a collection of the knowledge, intelligence and time of hundreds of
people, I do not beleive one person could know or hold or the know how
for that (while some who do alot of hacking, linus, alan cox, etc may
know *alot*, i still don't beleive even they could do such a task)

However, if you are serious about something like this and have the
knowhow, time and will, you have a few options.

a) You could hack the kernel in C, including optimizing what is there,
making better algorithms of systems for doing things
b) You could convert some parts of the kernel to ASM for the i386 arch
specific stuff, if it can be as functional and have a usefull gain.
c) You could work on the GCC compiler for generating better assembly
code from the C output, I'm sure there are many areas this could be
improved.
d) You could work on libc, in a similar fassion to the above,
optimizing, fixing, improving and adding to it.

Best of luck with your adventures.

Cheers,
Trent
Bur.st

> i wanna to rewrite a version of linux kernel from scratch in assembly for intel 386+ fo speed and a libc also in assembly for speed
> what do u think guys

--
Trent "Lathiat" Lloyd <lathiat@bur.st>

Sixlabs.org (http://www.sixlabs.org/)
Bur.st Networking Inc. (http://www.bur.st/)
