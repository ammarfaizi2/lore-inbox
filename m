Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265993AbUFUCEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUFUCEa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 22:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUFUCEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 22:04:30 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54728 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265993AbUFUCEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 22:04:25 -0400
Date: Mon, 21 Jun 2004 04:04:20 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm1
Message-ID: <20040621020420.GL27822@fs.tum.de>
References: <20040620174632.74e08e09.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040620174632.74e08e09.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 05:46:32PM -0700, Andrew Morton wrote:
>...
> +wanxl-firmware-build-fix.patch
> 
>  Fix allmodconfig build
>...

This option is in drivers/base/Kconfig, but the similar option 
STANDALONE [1] is in init/Kconfig.

Shouldn't buoth be at the same place?
What about moving STANDALONE ad let it depend on PREVENT_FIRMWARE_BUILD?

cu
Adrian

[1] both options do different things, and both seem to be needed,
    but I think they should be at the same place

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

