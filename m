Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTJZRme (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 12:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263359AbTJZRme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 12:42:34 -0500
Received: from h13.ing.unife.it ([192.167.215.13]:11703 "EHLO
	liston.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S263357AbTJZRmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 12:42:32 -0500
From: Simone Piunno <pioppo@ferrara.linux.it>
To: linux-kernel@vger.kernel.org
Subject: [Oops]: 2.6.0-test8 - sleeping function called from invalid context
Date: Sun, 26 Oct 2003 18:54:56 +0100
User-Agent: KMail/1.5.3
X-Key-URL: http://members.ferrara.linux.it/pioppo/mykey.asc
X-Key-FP: 9C15F0D3E3093593AC952C92A0CD52B4860314FC
X-Key-ID: 860314FC/C09E842C
X-Message: GnuPG/PGP5 are welcome
X-Operating-System: Linux 2.6.0-test3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310261854.56470.pioppo@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux version 2.6.0-test8 (pioppo@abulafia.casa) (gcc version 3.3.1 (Mandrake 
Linux 9.2 3.3.1-2mdk)) #1 Wed Oct 22 20:47:10 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bffc000 (usable)
 BIOS-e820: 000000000bffc000 - 000000000bfff000 (ACPI data)
 BIOS-e820: 000000000bfff000 - 000000000c000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
191MB LOWMEM available.
On node 0 totalpages: 49148
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 45052 pages, LIFO batch:10
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.0 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f7f20
ACPI: RSDT (v001 ASUS   P5A      0x00000000  0x00000000) @ 0x0bffc000
ACPI: FADT (v001 ASUS   P5A      0x00000000  0x00000000) @ 0x0bffc080
ACPI: BOOT (v001 ASUS   P5A      0x00000000  0x00000000) @ 0x0bffc040
ACPI: DSDT (v001   ASUS P5A      0x00001000 MSFT 0x01000001) @ 0x00000000
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=260test8 ro root=1606 devfs=mount 
acpi=force
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 350.840 MHz processor.
Console: colour VGA+ 80x25
Debug: sleeping function called from invalid context at 
include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():1
Call Trace:
 [<c011a14b>] __might_sleep+0x8b/0xc0
 [<c011cbaa>] acquire_console_sem+0x2a/0x60
 [<c011ce50>] register_console+0xf0/0x1c0
 [<c035814d>] con_init+0x1ad/0x1e0
 [<c0105000>] rest_init+0x0/0x60
 [<c0357742>] console_init+0x22/0x40
 [<c0348662>] start_kernel+0xa2/0x140
 [<c0348480>] unknown_bootoption+0x0/0x100
Memory: 191128k/196592k available (1782k kernel code, 4824k reserved, 545k 
data, 368k init, 0k highmem)
Debug: sleeping function called from invalid context at mm/slab.c:1857
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011a14b>] __might_sleep+0x8b/0xc0
 [<c013c4e1>] kmem_cache_alloc+0x41/0x60
 [<c0105000>] rest_init+0x0/0x60
 [<c013b64c>] kmem_cache_create+0x4c/0x4c0
 [<c010aedc>] do_IRQ+0xfc/0x120
 [<c0105000>] rest_init+0x0/0x60
 [<c03519d5>] kmem_cache_init+0x1d5/0x260
 [<c0116513>] zap_low_mappings+0x13/0x40
 [<c0348675>] start_kernel+0xb5/0x140
Calibrating delay loop... 694.27 BogoMIPS
-- 
Adde parvum parvo magnus acervus erit -- Ovidio

