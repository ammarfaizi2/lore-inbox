Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262958AbTCWILj>; Sun, 23 Mar 2003 03:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262964AbTCWILj>; Sun, 23 Mar 2003 03:11:39 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3268 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262958AbTCWILi>; Sun, 23 Mar 2003 03:11:38 -0500
Date: Sun, 23 Mar 2003 09:22:40 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parallel port
Message-ID: <20030323082239.GE6940@fs.tum.de>
References: <200303230000.h2N00nZX020752@hraefn.swansea.linux.org.uk> <Pine.LNX.4.44.0303221919160.2959-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303221919160.2959-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 07:21:11PM -0800, Linus Torvalds wrote:

> This one causes 
> 
> 	drivers/parport/parport_pc.c:2273: warning: implicit declaration of function `rename_region'
> 	drivers/built-in.o(.text+0x77a8c): In function `parport_pc_probe_port':
> 	: undefined reference to `rename_region'
> 
> for me. I think I complained about that once before already. Tssk, tssk.

It's perhaps a silly question:
Why did you use a "do ... while  (0)" in your fix?

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

