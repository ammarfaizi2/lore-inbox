Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVLPTJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVLPTJa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVLPTJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:09:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33285 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932110AbVLPTJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:09:30 -0500
Date: Fri, 16 Dec 2005 20:09:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Huess <huexxx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Error compiling linux-2.6.9
Message-ID: <20051216190931.GG23349@stusta.de>
References: <be2547710512151912w1593ff4eh@mail.gmail.com> <be2547710512151915k3ff5ba78j@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be2547710512151915k3ff5ba78j@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 04:15:35AM +0100, Huess wrote:

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
>...

You are using very recent binutils with an ancient kernel that is known 
to not compile with these binutils.

> Regards.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

