Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbSJENDn>; Sat, 5 Oct 2002 09:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262323AbSJENDm>; Sat, 5 Oct 2002 09:03:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7654 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262322AbSJENDm>; Sat, 5 Oct 2002 09:03:42 -0400
Date: Sat, 5 Oct 2002 15:09:12 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: sean darcy <seandarcy@hotmail.com>, <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40 compile fails: undef ref in drivers/builtin.o
In-Reply-To: <F214mLZ6T0yPXzLwhz40000f826@hotmail.com>
Message-ID: <Pine.NEB.4.44.0210051506350.17935-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002, sean darcy wrote:

> .config is attached. I'm running rh8.0, gcc 3.2 , binutils-2.13.90.0.2-2

Thanks, this is the well-known problem when you try to compile
drivers/net/tulip/de2104x.c statically into the kernel. A workaround is to
compile de2104x modular.

> thanks
> jay

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


