Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVAXSYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVAXSYL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVAXSYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:24:11 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:54214 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261551AbVAXSYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:24:07 -0500
Date: Mon, 24 Jan 2005 21:43:36 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050124214336.2c555b53@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050124175449.GK3515@stusta.de>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	<20050124175449.GK3515@stusta.de>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 18:54:49 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> It seems noone who reviewed the SuperIO patches noticed that there are 
> now two modules "scx200" in the kernel...

They are almost mutually exlusive(SuperIO contains more advanced), 
so I do not see any problem here.
Only one of them can be loaded in a time.

So what does exactly bother you?

> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
