Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262262AbRFGRQz>; Thu, 7 Jun 2001 13:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbRFGRQp>; Thu, 7 Jun 2001 13:16:45 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:52489 "HELO
	clueserver.org") by vger.kernel.org with SMTP id <S262202AbRFGRQh>;
	Thu, 7 Jun 2001 13:16:37 -0400
Date: Thu, 7 Jun 2001 11:27:20 -0700 (PDT)
From: Alan Olsen <alan@clueserver.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: es1371 compile issue in 2.4.5-ac9 
In-Reply-To: <3333.991926884@ocs4.ocs-net>
Message-ID: <Pine.LNX.4.10.10106071123220.24181-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2001, Keith Owens wrote:

> On Wed, 6 Jun 2001 14:45:10 -0700 (PDT), 
> Alan Olsen <alan@clueserver.org> wrote:
> >I rebuilt from clean source and patch for 2.4.5-ac9 and neglected to add
> >in anything using the joystick.
> >
> >ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext ...
> >	-o vmlinux
> >drivers/sound/sounddrivers.o: In function `es1371_probe':
> >drivers/sound/sounddrivers.o(.text+0x5e5d): undefined reference to
> >`gameport_register_port'
> 
> Your attached .config (why was it in base64?) has
>   # CONFIG_SOUND is not set
> which is completely incompatible with the above error.  Either you
> manually overrode the compile or you enclosed the wrong .config.

It was in base64 because I sent it as an attachment with Pine.

Weird. I took it from the kernel I had just built. (And gotten that
error.)

I will try and reproduce it again.

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
 "All power is derived from the barrel of a gnu." - Mao Tse Stallman

