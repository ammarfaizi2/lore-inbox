Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVCIAXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVCIAXz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVCIAXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 19:23:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59660 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262251AbVCIAUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 19:20:49 -0500
Date: Wed, 9 Mar 2005 01:20:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Christophe Lucas <c.lucas@ifrance.com>,
       Domen Puncer <domen@coderock.org>
Cc: linux-kernel@vger.kernel.org, Karsten Keil <kkeil@suse.de>
Subject: Re: 2.6.11-mm2
Message-ID: <20050309002046.GD3146@stusta.de>
References: <20050308033846.0c4f8245.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308033846.0c4f8245.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 03:38:46AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.11-mm1:
>...
> +drivers-isdn-tpam-convert-to-pci_register_driver.patch
>...
>  Little code tweaks.
>...

Please drop this patch.

Karsten has a patch ready to remove this driver (because the hardware it 
was supposed to drive never went into production), and such patches only 
cause needless rediffs.

@Karsten:
Could you submit your patch to remove tpam to Andrew?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

