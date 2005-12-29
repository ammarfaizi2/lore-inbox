Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbVL2EjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVL2EjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 23:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVL2EjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 23:39:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15373 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965018AbVL2EjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 23:39:01 -0500
Date: Thu, 29 Dec 2005 05:39:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-tiny@selenic.com
Subject: Re: [PATCH] Make vm86 support optional
Message-ID: <20051229043900.GD4872@stusta.de>
References: <20051228202735.GU3356@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228202735.GU3356@waste.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 02:27:35PM -0600, Matt Mackall wrote:
>...
> +config VM86
> +	depends X86
> +	default y
> +	bool "Enable VM86 support" if EMBEDDED
> +	help
> +          This option is required by programs like DOSEMU to run 16-bit legacy
> +	  code on X86 processors. It also may be needed by software like
> +          XFree86 to initialize some video cards via BIOS. Disabling this
> +          option saves about 6k.
>...

I don't like such space statements ("about 6k") in help texts, since 
history has shown that noone updates them when the actual size 
changes...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

