Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266694AbUGLDCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266694AbUGLDCr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 23:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUGLDCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 23:02:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43216 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266694AbUGLDCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 23:02:36 -0400
Date: Mon, 12 Jul 2004 05:02:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       matt_domsch@dell.com, akpm <akpm@osdl.org>
Subject: Re: [PATCH] edd (Re: Linux 2.6.8-rc1)
Message-ID: <20040712030223.GL4701@fs.tum.de>
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org> <20040711160019.00c2d658.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040711160019.00c2d658.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 04:00:19PM -0700, Randy.Dunlap wrote:
>...
> --- ./arch/i386/kernel/setup.c~edd_reference	2004-07-11 15:47:27.000000000 -0700
> +++ ./arch/i386/kernel/setup.c	2004-07-11 15:42:05.000000000 -0700
> @@ -628,10 +628,10 @@ static int __init copy_e820_map(struct e
>  }
>  
>  #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
>...

This still seems to be broken:
What happens if a user later compiles the edd module to his already 
running kernel without edd support?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

