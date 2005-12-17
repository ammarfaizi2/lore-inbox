Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbVLQRsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbVLQRsV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 12:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbVLQRsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 12:48:21 -0500
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:33980
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S932618AbVLQRsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 12:48:21 -0500
Message-ID: <43A44F5F.7020207@ev-en.org>
Date: Sat, 17 Dec 2005 17:48:15 +0000
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Huess <huexxx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Error compiling linux-2.6.9
References: <be2547710512151912w1593ff4eh@mail.gmail.com> <be2547710512151915k3ff5ba78j@mail.gmail.com>
In-Reply-To: <be2547710512151915k3ff5ba78j@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Huess wrote:
> [1.] Error compiling linux-2.6.9
> [2.] When I try to compile the kernel, executing make, the script
> returns an error.
> [3.]
> [4.] Linux version 2.6.13-15-smp (geeko@buildhost) (gcc version 4.0.2
> 20050901 (prerelease) (SUSE Linux)) #1 SMP Tue Sep 13 14:56:15 UTC
> 2005
> [5.]
> [6.] Running make, I obtain the following:
> piv2800ht:/usr/src/linux-2.6.9 # make vmlinux
>   CHK     include/linux/version.h
> make[1]: `arch/i386/kernel/asm-offsets.s' está actualizado.
>   CHK     include/linux/compile.h
> 
>   CC      arch/i386/kernel/process.o
> arch/i386/kernel/process.c: In function 'show_regs':
> arch/i386/kernel/process.c:252: warning: pointer targets in passing
> argument 2 of 'show_trace' differ in signedness
> {entrada estándar}: Mensajes del ensamblador:
> 
> {entrada estándar}:741: Error: sufijo u operandos inválidos para `mov'
> {entrada estándar}:742: Error: sufijo u operandos inválidos para `mov'
> {entrada estándar}:950: Error: sufijo u operandos inválidos para `mov'
> 
> {entrada estándar}:951: Error: sufijo u operandos inválidos para `mov'
> {entrada estándar}:1027: Error: sufijo u operandos inválidos para `mov'
> {entrada estándar}:1028: Error: sufijo u operandos inválidos para `mov'
> 
> {entrada estándar}:1125: Error: sufijo u operandos inválidos para `mov'
> {entrada estándar}:1126: Error: sufijo u operandos inválidos para `mov'
> {entrada estándar}:1220: Error: sufijo u operandos inválidos para `mov'
> 
> {entrada estándar}:1232: Error: sufijo u operandos inválidos para `mov'
> make[1]: *** [arch/i386/kernel/process.o] Error 1
> make: *** [arch/i386/kernel] Error 2

Use http://www.google.ie/search?hl=en&q=linux-2.6-seg-5.patch to search
for the patch I used to solve a similar problem.

As Adrian said, the newer binutils are more strict on what they accept.

Baruch
