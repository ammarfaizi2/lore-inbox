Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266157AbUGJGVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUGJGVU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 02:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266158AbUGJGVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 02:21:20 -0400
Received: from wl-193.226.227-253-szolnok.dunaweb.hu ([193.226.227.253]:19095
	"EHLO szolnok.dunaweb.hu") by vger.kernel.org with ESMTP
	id S266157AbUGJGVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 02:21:18 -0400
Message-ID: <40EF8ADC.4070507@dunaweb.hu>
Date: Sat, 10 Jul 2004 08:21:16 +0200
From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.4.1) Gecko/20031114
X-Accept-Language: hu, en-US
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm7
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found in my logs something that indicates problems with ACPI:

ACPI: Subsystem revision 20040615
ACPI: System description tables not found
     ACPI-0084: *** Error: acpi_load_tables: Could not get RSDP, 
AE_NOT_FOUND
     ACPI-0134: *** Error: acpi_load_tables: Could not load tables: 
AE_NOT_FOUND
ACPI: Unable to load the System Description Tables
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7510
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x645b, dseg 0xf0000
PnPBIOS: 12 nodes reported by PnP BIOS; 12 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3227] at 0000:00:11.0
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 1!
PCI BIOS passed nonexistent PCI bus 0!

Machine is MSI K8T Neo FIS2R with fairly recent 1.6 BIOS.
I dont have this with Linux-2.6.7.

Best regards,
Zoltán Böszörményi

