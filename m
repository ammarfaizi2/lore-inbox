Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265803AbTFVThj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 15:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265804AbTFVThj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 15:37:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55250 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265803AbTFVThi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 15:37:38 -0400
Date: Sun, 22 Jun 2003 21:51:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
Message-ID: <20030622195134.GA29280@fs.tum.de>
References: <20030621125111.0bb3dc1c.akpm@digeo.com> <20030622103251.158691c3.akpm@digeo.com> <bd4u7s$jkp$1@tangens.hometree.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd4u7s$jkp$1@tangens.hometree.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 22, 2003 at 06:58:04PM +0000, Henning P. Schmiedehausen wrote:
> Andrew Morton <akpm@digeo.com> writes:
> 
> Your problem is not the compiler but the build tool / system which
> forces you to recompile all of your kernel if you change only small
> parts.

That's not true in 2.5, the 2.5 build system only recompiles files that 
have to be recompiled.

But if you edit an often used header file many fils have to be 
recompiled.

> 	Regards
> 		Henning

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

