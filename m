Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbUBKW2r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266222AbUBKW2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:28:46 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3800 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266220AbUBKW2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:28:09 -0500
Date: Wed, 11 Feb 2004 23:27:59 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Greg KH <greg@kroah.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
       kkeil@suse.de, kai.germaschewski@gmx.de,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
Message-ID: <20040211222759.GV7388@fs.tum.de>
References: <10763689362321@kroah.com> <Pine.GSO.4.58.0402101702420.2261@waterleaf.sonytel.be> <20040210164612.GB27221@kroah.com> <20040210174903.GA27891@pingi3.kke.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210174903.GA27891@pingi3.kke.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 06:49:03PM +0100, Karsten Keil wrote:
>...
> The bug is to use irq_resource[0].start here, it must be isa_dev[i].irq
> instead, allready fixed in last night patch.
>...

Additionally, the following file needs to be fixed:
  drivers/isdn/hisax/hisax_fcclassic.c


Fixes for compilation errors introduced in 2.6.3-rc should not end in
the big ISDN patch, they belong into 2.6.3-final.

Please submit these fixes alone to Linus.


> Karsten Keil

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

