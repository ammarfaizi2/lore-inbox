Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291675AbSBNOQM>; Thu, 14 Feb 2002 09:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291676AbSBNOQC>; Thu, 14 Feb 2002 09:16:02 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:42196 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S291675AbSBNOPw>; Thu, 14 Feb 2002 09:15:52 -0500
Date: Thu, 14 Feb 2002 15:12:13 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] compile fixes
In-Reply-To: <3C6B8B01.E0A3B194@zip.com.au>
Message-ID: <Pine.NEB.4.44.0202141509200.9063-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2002, Andrew Morton wrote:

>...
> > drivers/char/char.o(.data+0xacf4): undefined reference to `local symbols
> > in discarded section .text.exit'
>
> Well that's odd.  Perhaps something is configured differently.
> Please do this:
>...
> Now, go through all the junk in /tmp/1 and search for the text "discarded".
> It will mention a filename.   That's the info we want.

./drivers/char/wdt_pci.o(.data+0x114): undefined reference to `local
symbols in discarded section .text.exit'

> Thanks.

cu
Adrian


