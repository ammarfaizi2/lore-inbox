Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262536AbSIUTG1>; Sat, 21 Sep 2002 15:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263113AbSIUTG1>; Sat, 21 Sep 2002 15:06:27 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14840 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262536AbSIUTG1>; Sat, 21 Sep 2002 15:06:27 -0400
Date: Sat, 21 Sep 2002 21:11:29 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Burton Samograd <kruhft@kruhft.dyndns.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: problems building bzImage with 2.5.*
In-Reply-To: <20020921183527.GL22811@kruhft.dyndns.org>
Message-ID: <Pine.NEB.4.44.0209212107270.10334-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Sep 2002, Burton Samograd wrote:

> Hi all,

Hi Burton,

>...
>   net/built-in.o --end-group -o vmlinux
> drivers/built-in.o(.data+0xac34): undefined reference to `local
> symbols in discarded section .text.exit'
> make: *** [vmlinux] Error 1
>...

Is CONFIG_DE2104X enabled in your kernel? If yes this is a known problem
and a workaround is to compile this driver only modular. If this is not
the problem please send me your .config .

> Thanks in advance.
>
> burton

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

