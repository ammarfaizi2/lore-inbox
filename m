Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTDWSyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTDWSyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:54:51 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:20384 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S264300AbTDWSxL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:53:11 -0400
Message-ID: <20030423190503.3135.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 24 Apr 2003 03:05:03 +0800
Subject: [ACPI] dmesg output
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I'm really ignorant of ACPI, so this email could be totaly
uselless...

Kernel version is 2.5.68, I enabled ACPI in the config,
following my dmesg:
----
ACPI: RSDP (v000 HP-MCD                     ) @ 0x000f6770
ACPI: RSDT (v001 HP-MCD EA RSDT  00386.00000) @ 0x0fff59b8
ACPI: FADT (v001 HP-MCD EA FACP  00386.00000) @ 0x0ffffb65
ACPI: BOOT (v001 PTLTD  EABFTBL$ 00386.00000) @ 0x0ffffbd9
ACPI: DSDT (v001 HP-MCD EA DSDT  00386.00000) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
Building zonelist for node : 0
[...]
ACPI: Subsystem revision 20030328
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:............................................................................................................................................................................................................................................................................................................
Table [DSDT] - 1043 Objects with 69 Devices 300 Methods 32 Regions
ACPI Namespace successfully loaded at root c05232fc
evregion-0254 [23] ev_address_space_dispa: no handler for region(cff7f29c) [PCI_Config]
 exfldio-0235 [22] ex_access_region      : Region PCI_Config(2) has no handler
evregion-0254 [23] ev_address_space_dispa: no handler for region(cff7f29c) [PCI_Config]
 exfldio-0235 [22] ex_access_region      : Region PCI_Config(2) has no handler
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.FDS_.FCB1.CSID] (Node cff7faa0), AE_NOT_EXIST
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.FDS_._REG] (Node c12c0884), AE_NOT_EXIST
ACPI: Unable to start the ACPI Interpreter
 utalloc-0986 [05] ut_dump_allocations   : No outstanding allocations.
---

Are those lines intersting ?

Hw is a HP omnibook 6000.

Let me know if you need further information.

Ciao,
        Paolo
        
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
