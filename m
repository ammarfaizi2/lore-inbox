Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422691AbWIGDdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422691AbWIGDdu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 23:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWIGDdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 23:33:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56006 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422688AbWIGDdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 23:33:49 -0400
Date: Wed, 6 Sep 2006 20:30:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Stelian Pop <stelian@popies.net>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [-mm patch] ACPI_SONY shouldn't default m
Message-Id: <20060906203003.95ad130a.akpm@osdl.org>
In-Reply-To: <20060906230700.GE12157@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
	<20060906230700.GE12157@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006 01:07:00 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> Drivers should default to n.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.18-rc5-mm1/drivers/acpi/Kconfig.old	2006-09-07 00:49:37.000000000 +0200
> +++ linux-2.6.18-rc5-mm1/drivers/acpi/Kconfig	2006-09-07 00:50:01.000000000 +0200
> @@ -251,7 +251,6 @@
>  config ACPI_SONY
>  	tristate "Sony Laptop Extras"
>  	depends on X86 && ACPI
> -	default m

Not this one - I need it on my Vaio and I get sick of the option vanishing.
Make it depend on CONFIG_AKPM?
