Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129144AbRBNTMv>; Wed, 14 Feb 2001 14:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129949AbRBNTMn>; Wed, 14 Feb 2001 14:12:43 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:18480 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129842AbRBNTM1>; Wed, 14 Feb 2001 14:12:27 -0500
Date: Wed, 14 Feb 2001 13:12:11 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Andriy Korud <akorud@polynet.lviv.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre12
In-Reply-To: <15273990267.20010214210308@polynet.lviv.ua>
Message-ID: <Pine.LNX.3.96.1010214131123.6565N-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 14 Feb 2001, Andriy Korud wrote:

> Hello Alan,
> 
> Wednesday, February 14, 2001, 6:33:49 PM, you wrote:
> 
> 
> Alan> 2.2.19pre12
> Alan> o       Update the DAC960 driver                        (Leonard Zubkoff)
> Alan> o       Small PPC fixes                                 (Benjamin Herrenschmidt)
> Alan> o       Document irda options config                    (Steven Cole)
> Alan> o       Small isdn fixes/obsolete code removal          (Kai Germaschewski)
> Alan> o       Fix alpha kernel builds                         (Michal Jaegermann)
> Alan> o       Update ver_linux to match the 2.4 one           (Steven Cole)
> Alan> o       AVM isdn driver updates                         (Carsten Paeth)
> Alan> o       ISDN capi/ppp fixes                             (Kai Germaschewski)
> 
> When trying to compile:
> 
> rm -f scsi_n_syms.o
> ld -m elf_i386  -r -o scsi_n_syms.o scsi.o
> cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-fr
> ame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -m486 -malign-loops=
> 2 -malign-jumps=2 -malign-functions=2 -DCPU=686   -c -o hosts.o hosts.c
> hosts.c:139: aic7xxx.h: No such file or directory
> hosts.c:500: `AIC7XXX' undeclared here (not in a function)
> hosts.c:500: initializer element for `builtin_scsi_hosts[0]' is not constant

I'm sure Alan will notice and pick up the proper fix.  For a workaround
to get you going, you can change hosts.c to include aic7xxx/aic7xxx.h...

	Jeff




