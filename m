Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932773AbWHOMhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbWHOMhp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 08:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWHOMhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 08:37:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:1495 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932775AbWHOMho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 08:37:44 -0400
Subject: Re: [PATCH 2/2] acpi,backlight: MSI S270 laptop support - driver
From: Thomas Renninger <trenn@suse.de>
Reply-To: trenn@suse.de
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
In-Reply-To: <20060810010517.GA20849@curacao>
References: <20060810010517.GA20849@curacao>
Content-Type: text/plain
Organization: Novell/SUSE
Date: Tue, 15 Aug 2006 14:42:16 +0200
Message-Id: <1155645736.4302.1161.camel@queen.suse.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 03:05 +0200, Lennart Poettering wrote:
> From: Lennart Poettering <mzxreary@0pointer.de>
> 
>  
> +config ACPI_MSI_S270
> +	tristate "MSI S270 Laptop Extras"
> +	depends on X86
> +    depends on BACKLIGHT_CLASS_DEVICE
> +	---help---
> +	  This is a Linux ACPI driver for MSI S270 laptops. It adds
> +	  support for Bluetooth, WLAN and LCD brightness control.
> +
> +	  More information about this driver is available at
> +	  <http://0pointer.de/lennart/tchibo.html>.
> +
> +	  If you have an MSI S270 laptop, say Y or M here.

I don't know anything about MSI laptops. But S270 sounds like a very
specific model to me?

Shouldn't the driver just be called acpi_msi driver and try to also
support other MSI models later that might do things at least similar?

    Thomas

