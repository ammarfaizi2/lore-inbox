Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161359AbWI2S0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161359AbWI2S0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161372AbWI2S0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:26:04 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:22449 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1161359AbWI2S0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:26:01 -0400
In-Reply-To: <1159551809.13029.56.camel@localhost.localdomain>
References: <1159551809.13029.56.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <20A1F284-F6EB-46DA-B9DC-B1AC3F1D1E44@bootc.net>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Chris Boot <bootc@bootc.net>
Subject: Re: [PATCH] libata: test driver for Marvell PATA
Date: Fri, 29 Sep 2006 19:25:58 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29 Sep 2006, at 18:43, Alan Cox wrote:

> This should drive the Marvell PATA (and first two SATA ports) but I
> don't have hardware to test so give it a spin. Currently it'll  
> probably
> clash with the AHCI driver if you are using the SATA ports but if we
> know this code works for the PATA port that is fixable later on.
>
> Alan
>
> diff -u --new-file --recursive --exclude-from /usr/src/exclude  
> linux.vanilla-2.6.18-mm2/drivers/ata/Kconfig linux-2.6.18-mm2/ 
> drivers/ata/Kconfig
> --- linux.vanilla-2.6.18-mm2/drivers/ata/Kconfig	2006-09-28  
> 14:33:46.000000000 +0100
> +++ linux-2.6.18-mm2/drivers/ata/Kconfig	2006-09-29  
> 17:42:31.392428080 +0100
> @@ -327,6 +327,15 @@
>
>  	  If unsure, say N.
>
> +config PATA_MARVELL
> +	tristate "Marvell PATA support via legacy nmode"

mode?

Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/


