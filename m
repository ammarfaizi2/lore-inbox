Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbUDVDV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbUDVDV5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 23:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUDVDV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 23:21:56 -0400
Received: from fmr10.intel.com ([192.55.52.30]:8838 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S262862AbUDVDVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 23:21:55 -0400
Subject: Re: No luck getting 2.6.x kernel to work with ACPI on compaq laptop
From: Len Brown <len.brown@intel.com>
To: Danny ter Haar <dth@ncc1701.cistron.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F9628@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F9628@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1082604108.16332.163.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Apr 2004 23:21:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-21 at 01:51, Danny ter Haar wrote:
> My Compaq presario 700EA locks up dead during boot with
> ACPI enabled. With bootoption acpi=off (or not compiled into the
> kernel)
> the machine works just fine.
> 
> I put on acpi debug and typed over by hand (laptop's dont have serial
> ports these days anymore) :
> 
> ACPI: Subsystem revision 20040326
> tbxface-0017[03] acpi_load_tables: ACPI tables succesfully acquired
> Parsing all Control Methods: [......]
> Table [DSDT] (id F005) - 433 Objects with 44 Devices 109 Methods 15
> Regions
> Parsing all Control Methods: 
> Table [SSDT] (id f003) - 3 objects with 0 Devices 0 Methods 0 Regions
> ACPI: IRQ10 SCI: Edge set to level trigger
> 
> After this the machine is dead in the water.
> No magic sysrq or anything.

try booting with "nolapic" (or disable LOCAL_APIC in the kernel build)


