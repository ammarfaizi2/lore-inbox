Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262085AbTCHRHn>; Sat, 8 Mar 2003 12:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262092AbTCHRHn>; Sat, 8 Mar 2003 12:07:43 -0500
Received: from mail.ithnet.com ([217.64.64.8]:3077 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S262085AbTCHRHm>;
	Sat, 8 Mar 2003 12:07:42 -0500
Date: Sat, 8 Mar 2003 18:18:17 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: hm, page 000f0000 reserved twice ?
Message-Id: <20030308181817.31247f93.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Can any kind soul please tell me what "hm, page xxxx reserved twice" means? And
additionally: is there any magic involved in getting a serial console working?
There seems no way to make it work on below system. All "echo >/dev/ttyS0 test"
do work, but no console output whatsoever visible...

Regards,
Stephan

dmesg:

Inspecting /boot/System.map-2.4.21-pre5
Loaded 17206 symbols from /boot/System.map-2.4.21-pre5.
Symbols match kernel version 2.4.21.
No module symbols loaded.
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.4.21-pre5 (root@admin) (gcc version 3.2) #8 SMP Sat Mar 8
17:20:05 CET 2003
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009e800 (usable)   
<4> BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved) 
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved) 
<4> BIOS-e820: 0000000000100000 - 000000001fffb000 (usable)
<4> BIOS-e820: 000000001fffb000 - 000000001ffff000 (ACPI data)
<4> BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
<4> BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
<5>0MB HIGHMEM available.
<5>511MB LOWMEM available.
<4>found SMP MP-table at 000f0410
<4>hm, page 000f0000 reserved twice.
<4>hm, page 000f1000 reserved twice.
<4>hm, page 000f0000 reserved twice.      
<4>On node 0 totalpages: 131067
<4>zone(0): 4096 pages.
<4>zone(1): 126971 pages.
<4>zone(2): 0 pages.
<4>Intel MultiProcessor Specification v1.4
<4>    Virtual Wire compatibility mode. 
<4>OEM ID: ASUS     Product ID: PROD00000000 APIC at: 0xFEE00000
<4>Processor #3 Pentium(tm) Pro APIC version 17
<4>Processor #0 Pentium(tm) Pro APIC version 17
<4>I/O APIC #4 Version 17 at 0xFEC00000.
<4>I/O APIC #5 Version 17 at 0xFEC01000.
<4>I/O APIC #6 Version 17 at 0xFEC02000.
<4>Enabling APIC mode: Flat.    Using 3 I/O APICs
<4>Processors: 2
<4>Kernel command line: root=/dev/sda3  hda=none hdb=none hdc=ide-scsi
console=ttyS0,9600

