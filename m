Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131308AbQKLWH3>; Sun, 12 Nov 2000 17:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131309AbQKLWHK>; Sun, 12 Nov 2000 17:07:10 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:25420 "EHLO
	amsmta05-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S131308AbQKLWGz>; Sun, 12 Nov 2000 17:06:55 -0500
Date: Mon, 13 Nov 2000 00:14:41 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: juergen.heisel@planet-heisel.de
cc: Kernel devel list <linux-kernel@vger.kernel.org>
Subject: Re: Compile Error linux-2.2.17 and RedHat7.0
In-Reply-To: <E13v59O-0000op-00@mrvdom02.schlund.de>
Message-ID: <Pine.LNX.4.21.0011130014001.18364-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Nov 2000 juergen.heisel@planet-heisel.de wrote:

> 
> Hi there,
> I updated my system from RedHat 6.0 -> RedHat 7.0 and Murphy is still
> working.
> 
> [1]
>  I can't compile Kernel 2.2.17 since the update. 
>     (make bzImage)
> 
> [2]
> Error Message:
> make[2]: Entering directory '/usr/src/linux-2.2.17/arch/i386/lib'
> cc -D__KERNEL__ -I/usr/src/linux-2.2.17/include -D__ASSEMBLY__ -D__SMP__ 
> -traditional -c checksum.S -o checksum.o
> checksum.S:231 : badly punctuated parameter list in #define
> checksum.S:237 : badly punctuated parameter list in #define
> make[2] ***[checksum.o] Error 1
> make[2] Leaving directory '/usr/src/linux-2.2.17/arch/i386/lib'
> make[1] ***[first_rule] Error 2
> make[1] Leaving directory '/usr/src/linux-2.2.17/arch/i386/lib'
> make: *** [dir_arch/i386/lib] Error 2

Use kgcc. Change the CC line at top of the Makefile



	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
