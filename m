Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276167AbRI1Q6t>; Fri, 28 Sep 2001 12:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276171AbRI1Q6j>; Fri, 28 Sep 2001 12:58:39 -0400
Received: from dns.logatique.fr ([213.41.101.1]:61682 "HELO
	persephone.dmz.logatique.fr") by vger.kernel.org with SMTP
	id <S276167AbRI1Q6d>; Fri, 28 Sep 2001 12:58:33 -0400
Message-ID: <3BB4ACFF.62106478@logatique.fr>
Date: Fri, 28 Sep 2001 19:01:51 +0200
From: Jean Marc LACROIX <jean-marc.lacroix@logatique.fr>
Organization: Logatique
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Francois Romieu <romieu@cogenit.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10 hang with agpart driver enable on Laptob HP 4150
In-Reply-To: <3BB2E84E.12381FB9@logatique.fr> <20010927134241.A4815@se1.cogenit.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> 
> Salut,
> 
> Jean Marc LACROIX <jean-marc.lacroix@logatique.fr> :
> [...]
> > I have a Laptob omnibook 4150 with "Debian testing Woody" configuration.
> > I have compiled 2.4.10 kernel with agpart char driver enable, installed
> > it and reboot.....
> > The system hang with following message:
> >
> > -----------------------------------------------
> > linux agpart interface V0.99 (c) Jeff Hartmann
> > agpart: Maximum main memory to use for agp memory : 27M
> > agpart: Detected Intel 440Bx chipset
> > -----------------------------------------------
> 
> It misses a 'printk(KERN_INFO PFX "AGP aperture is %dM @ 0x%lx\n", ...',
> you're stuck in agp_backend_initialize.
> Does SysRq still work after this message ?
> 
> --
> Ueimor
I have only suppress the agp driver in kernel in order to make my test, 
and recompile it . 
It was not possible to make any access on my host, the linux box is
frozen.
The only solution is to remove power.

Thank you for your suggestion.
best regard



-- 
Jean-Marc LACROIX        		Senior Consultant
LOGATIQUE                    		www.logatique.fr
50, Rue Marcel Dassault			jean-marc.lacroix@logatique.fr
92100 Boulogne Billancourt		tel 01 46 21 59 59
France					fax 01 46 21 84 94
