Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVA3SMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVA3SMR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 13:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbVA3SMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 13:12:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59665 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261757AbVA3SKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 13:10:45 -0500
Date: Sun, 30 Jan 2005 19:10:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>,
       Michael Werner <werner@mrcoffee.engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, dwmw2@infradead.org, davej@codemonkey.org.uk,
       Andrew Morton <akpm@osdl.org>
Subject: Re: inter-module-* removal.. small next step
Message-ID: <20050130181042.GR3185@stusta.de>
References: <20050130180016.GA12987@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050130180016.GA12987@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 06:00:17PM +0000, Arjan van de Ven wrote:

> Hi,
> 
> intermodule is deprecated for quite some time now, and MTD is the sole last
> user in the tree. To shrink the kernel for the people who don't use MTD, and
> to prevent accidental return of more users of this, make the compiling of
> this function conditional on MTD.
>...

agpgart-allow-multiple-backends-to-be-initialized.patch in -mm adds a 
call to inter_module_unregister to drivers/char/agp/backend.c ...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

