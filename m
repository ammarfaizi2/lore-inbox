Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbSKZLCN>; Tue, 26 Nov 2002 06:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbSKZLCN>; Tue, 26 Nov 2002 06:02:13 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:27829 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263276AbSKZLCN>; Tue, 26 Nov 2002 06:02:13 -0500
Message-Id: <4.3.2.7.2.20021126115405.00b51200@mail.dns-host.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 26 Nov 2002 12:09:47 +0100
To: linux-kernel@vger.kernel.org
From: Margit Schubert-While <margit@margit.com>
Subject: Linux 2.4.20 ACPI
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest ACPI acpi-20021118-2.4.20-rc1.diff.gz over at
http://sourceforge.net/project/showfiles.php?group_id=36832
applies cleanly to 2.4.20-rc3
Leading to :
<6>ACPI: RSDP (v000 ACPIAM                     ) @ 0x000f70d0
<6>ACPI: RSDT (v001 INTEL  D845PESV 08194.04144) @ 0x1ff40000
<6>ACPI: FADT (v002 INTEL  D845PESV 08194.04144) @ 0x1ff40200
<6>ACPI: MADT (v001 INTEL  D845PESV 08194.04144) @ 0x1ff40300
<6>ACPI: ASF! (v016 AMIASF I845GASF 00000.00001) @ 0x1ff44390
<6>ACPI: DSDT (v001 INTEL  D845PESV 00000.00266) @ 0x00000000
<5>ACPI: BIOS passes blacklist

etc. instead of :

<4> tbutils-0200 [03] Tb_validate_table_head: Table signature at e080f390 
[c15ffe24] has invalid characters
<4> tbutils-0202: *** Warning: Invalid table signature ASF! found
<4> tbxface-0095: *** Error: Acpi_load_tables: Error getting required 
tables (DSDT/FADT/FACS):AE_BAD_SIGNATURE
<4> tbxface-0116: *** Error: Acpi_load_tables: Could not load tables: 
AE_BAD_SIGNATURE
<3>ACPI: System description table load failed

- Tom Diehl - Try a Suse 8.1 distro, it has ACPI enabled by default :-)

Margit

