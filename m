Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291161AbSBNJve>; Thu, 14 Feb 2002 04:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291171AbSBNJvY>; Thu, 14 Feb 2002 04:51:24 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:36568 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S291161AbSBNJvV>; Thu, 14 Feb 2002 04:51:21 -0500
Date: Thu, 14 Feb 2002 10:47:44 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] compile fixes
In-Reply-To: <3C6A2F86.E5C322D4@zip.com.au>
Message-ID: <Pine.NEB.4.44.0202141036020.25879-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Andrew Morton wrote:

> This patch should fix all the remaining .text.exit problems
> which have resulted from recent binutils changes.   For all
> files which are accessible to an x86 build.
>...

Thanks for your work, I tried to compile non-modular 2.4.18-pre9 with this
patch and as much as possible enabled. The .text.exit errors are now gone
with one exception:

drivers/char/char.o(.data+0xacf4): undefined reference to `local symbols
in discarded section .text.exit'


cu
Adrian




