Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267751AbTAMKBd>; Mon, 13 Jan 2003 05:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267787AbTAMKBd>; Mon, 13 Jan 2003 05:01:33 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46839 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267751AbTAMKBb>; Mon, 13 Jan 2003 05:01:31 -0500
Date: Mon, 13 Jan 2003 11:10:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jan Yenya Kasprzak <kas@informatics.muni.cz>
Cc: torvalds@transmeta.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.56: Two global symbols "io"
Message-ID: <20030113101012.GX21826@fs.tum.de>
References: <20030112131244.GW21826@fs.tum.de> <20030113085518.D3702@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113085518.D3702@fi.muni.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 08:55:18AM +0100, Jan Yenya Kasprzak wrote:

>...
> by Arnd Bergmann from the Kernel Janitors Project. However: cosa.c
> can be built as a module only.
>...

Ups, sorry, that was again the "Kconfig doesn't handle && m in kernels 
without module support" bug (#269 at bugzilla.kernel.org).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

