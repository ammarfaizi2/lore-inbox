Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269372AbUHZTDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269372AbUHZTDR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269387AbUHZS5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:57:02 -0400
Received: from fmr10.intel.com ([192.55.52.30]:20649 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S269353AbUHZSsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:48:01 -0400
Subject: Re: [PATCH] export acpi_strict
From: Len Brown <len.brown@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200408261232.34350.bjorn.helgaas@hp.com>
References: <200408261232.34350.bjorn.helgaas@hp.com>
Content-Type: text/plain
Organization: 
Message-Id: <1093546069.7766.79.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Aug 2004 14:47:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Accepted.

thanks,
-Len

On Thu, 2004-08-26 at 14:32, Bjorn Helgaas wrote:
> I sent this to acpi-devel, but probably more appropriate for the
> general
> list, since it's not under drivers/acpi/.
> 
> 
> Export acpi_strict for use in modular drivers.  This will enable
> drivers to work around BIOS deficiencies, while still allowing the
> drivers to be more picky under acpi_strict.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> ===== arch/i386/kernel/acpi/boot.c 1.69 vs edited =====
> --- 1.69/arch/i386/kernel/acpi/boot.c   2004-07-14 14:00:16 -06:00
> +++ edited/arch/i386/kernel/acpi/boot.c 2004-08-26 09:21:44 -06:00
> @@ -71,6 +71,7 @@
>  int acpi_lapic;
>  int acpi_ioapic;
>  int acpi_strict;
> +EXPORT_SYMBOL(acpi_strict);
>  
>  acpi_interrupt_flags acpi_sci_flags __initdata;
>  int acpi_sci_override_gsi __initdata;
> 

