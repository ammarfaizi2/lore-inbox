Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317877AbSGQIVx>; Wed, 17 Jul 2002 04:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318244AbSGQIVv>; Wed, 17 Jul 2002 04:21:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:15352 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318242AbSGQIVu>; Wed, 17 Jul 2002 04:21:50 -0400
Date: Wed, 17 Jul 2002 10:24:44 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: "Justin M. Forbes" <kernelmail@attbi.com>
cc: marcelo@conectiva.com.br, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc2 compile fail
In-Reply-To: <Pine.LNX.4.44.0207161957140.11639-100000@leaper.linuxtx.org>
Message-ID: <Pine.NEB.4.44.0207171023470.16056-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002, Justin M. Forbes wrote:

> I get this failure when trying to compile 2.4.19-rc2
>
>
> gcc -E -D__KERNEL__ -I/usr/src/linux-2.4.19-rc2/include -traditional
> -DCHIP=710 fake7.c | grep -v '^#' | perl -s script_asm.pl -ncr7x0_family
> script_asm.pl : Illegal combination of registers in line 72 : 	MOVE
> CTEST7 & 0xef TO CTEST7
> 	Either source and destination registers must be the same,
> 	or either source or destination register must be SFBR.
> make[2]: *** [sim710_d.h] Error 255
> make[2]: Leaving directory `/usr/src/linux-2.4.19-rc2/drivers/scsi'
> make[1]: *** [_modsubdir_scsi] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.19-rc2/drivers'
> make: *** [_mod_drivers] Error


Which version of gcc do you use?
Could you send your .config?


> Justin M. Forbes

TIA
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

