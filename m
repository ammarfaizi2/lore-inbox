Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274746AbRJTWRb>; Sat, 20 Oct 2001 18:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274749AbRJTWRW>; Sat, 20 Oct 2001 18:17:22 -0400
Received: from smtpsrv0.isis.unc.edu ([152.2.1.139]:56975 "EHLO
	smtpsrv0.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S274746AbRJTWRK>; Sat, 20 Oct 2001 18:17:10 -0400
Date: Sat, 20 Oct 2001 18:17:43 -0400 (EDT)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: Stuart Luscombe <stuart@ubersecksie.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Compilation of 2.4.0 fails when processing /i386/boot
In-Reply-To: <20011020231131.A4560@ubersecksie.co.uk>
Message-ID: <Pine.A41.4.21L1.0110201816050.33706-100000@login3.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you sure your binutils is up to date? This is eerily reminiscent of
the --oformat change documented in 2.10.91.0.2-2 ...

---
Dan Chen                 crimsun@email.unc.edu
GPG key: www.cs.unc.edu/~chenda/pubkey.gpg.asc

On Sat, 20 Oct 2001, Stuart Luscombe wrote:

> I am compiling kernel 2.4.0, and I am getting the following error
> during the 'make install' part of the build:
[...]
> ld -m elf_i386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
> make[1]: Leaving directory `/usr/src/linux/arch/i386/boot'
> ld: cannot open binary: No such file or directory
> make[1]: *** [bbootsect] Error 1
> make: *** [install] Error 2
> 
> I have checked all assembler packages, and they all seem to be installed.
> I am running Debian sid and all packages are up-to-date.

