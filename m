Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318031AbSHaVW6>; Sat, 31 Aug 2002 17:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318032AbSHaVW5>; Sat, 31 Aug 2002 17:22:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:26877 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318031AbSHaVW5>; Sat, 31 Aug 2002 17:22:57 -0400
Date: Sat, 31 Aug 2002 23:27:17 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alex Pelts <alexp@itvd.sel.sony.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: mtdblock with gcc 2.95.4 patch
In-Reply-To: <3D62C6DD.9000306@itvd.sel.sony.com>
Message-ID: <Pine.NEB.4.44.0208312323450.147-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2002, Alex Pelts wrote:

> Hi,

Hi Alex,

> After installing new debian stable with gcc 2.95.4, kernel 2.4.17
> stopped linking. The error is "undefined reference to local symbols...".
>...
> something tricky about __exit macro and 2.95.4 compiler.
> For people getting error:
> drivers/mtd/mtdlink.o(.text.lock+0x26c): undefined reference to `local
> symbols in discarded section .text.exit'

this is a known issue with recent binutils - and it's considered to be a
bug in the kernel.

> here is the patch that seems to fix it.

I do currently not understand why your patch should fix it. Could you send
me the .config you used to reproduce the problem in 2.4.19?

> Thanks,
> Alex
>...

TIA
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


