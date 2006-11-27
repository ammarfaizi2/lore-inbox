Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758593AbWK0XOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758593AbWK0XOJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 18:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758594AbWK0XOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 18:14:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43525 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1758593AbWK0XOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 18:14:06 -0500
Date: Tue, 28 Nov 2006 00:14:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] kconfig:  Remove obsolete CONFIG_DMA_IS_DMA32 entries from ia64 config files
Message-ID: <20061127231409.GQ15364@stusta.de>
References: <Pine.LNX.4.64.0611271631480.4759@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611271631480.4759@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 04:37:35PM -0500, Robert P. J. Day wrote:
> 
>   Remove the obsolete CONFIG_DMA_IS_DMA32 entries from the various
> "defconfig" files under arch/ia64.
>...

I do not like this manual editing of defconfigs:
- obsolete options in defconfigs don't cause any harm
- the next time someone refreshes the defconfigs they will 
  automatically go away
- if it became common to manually patch defconfigs, we'd soon get
  many patch conflicts

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

