Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266785AbUBMHTB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 02:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUBMHTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 02:19:01 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:48396 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266785AbUBMHS4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 02:18:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Junio C Hamano <junkio@cox.net>, Michael Frank <mhf@linuxmail.org>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
Date: Fri, 13 Feb 2004 09:18:45 +0200
X-Mailer: KMail [version 1.4]
Cc: linux kernel <linux-kernel@vger.kernel.org>
References: <fa.fbh88ra.kn8094@ifi.uio.no> <7voes31ny4.fsf@assigned-by-dhcp.cox.net>
In-Reply-To: <7voes31ny4.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200402130918.45587.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 08:41, Junio C Hamano wrote:

> MF> +Periods terminating kernel messages are deprecated
> MF> +Usage of the apostrophe <'> in kernel messages is deprecated
>
> I do not think encouraging bad spelling like above has reached
> community consensus.  Personally I do not like those sloppy
> grammar ("donts" and missing period at the end of the sentence).

About dots. Let's look how it would look like with those
dots added everywhere, and then with dots removed.

klogd 1.4.1, log source = /proc/kmsg started.
Linux version 2.4.22-rc2_QoS (root@vda) (gcc version 3.2) #1 Tue Nov 18 15:55:00 GMT-2 2003.
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e000 (usable).
 BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved).
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved).
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved).
 BIOS-e820: 0000000000100000 - 0000000007cf0000 (usable).
 BIOS-e820: 0000000007cf0000 - 0000000007cff000 (ACPI data).
 BIOS-e820: 0000000007cff000 - 0000000007d00000 (ACPI NVS).
 BIOS-e820: 0000000007d00000 - 0000000007e80000 (usable).
 BIOS-e820: 0000000007e80000 - 0000000008000000 (reserved).
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved).
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved).
126MB LOWMEM available.
On node 0 totalpages: 32384.
zone(0): 4096 pages.
zone(1): 28288 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs  nfsroot=172.16.42.75:/.rootfs/.std,hard,intr  ip=:172.16.42.75:::(none):eth0:dhcp  devfs=mount.
Initializing CPU#0.
Detected 1196.031 MHz processor.
Console: colour VGA+ 80x30.
Calibrating delay loop... 2385.51 BogoMIPS.
Memory: 123856k/129536k available (2268k kernel code, 5224k reserved, 694k data, 564k init, 0k highmem).
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes).
Inode cache hash table entries: 8192 (order: 4, 65536 bytes).
Mount cache hash table entries: 512 (order: 0, 4096 bytes).
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes).
Page-cache hash table entries: 32768 (order: 5, 131072 bytes).
CPU: L1 I cache: 16K, L1 D cache: 16K.
CPU: L2 cache: 256K.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000.
CPU:             Common caps: 0383fbff 00000000 00000000 00000000.
CPU: Intel(R) Celeron(TM) CPU                1200MHz stepping 01.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX.
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au).
mtrr: detected mtrr type: Intel.
PCI: PCI BIOS revision 2.10 entry at 0xfd9b8, last bus=1.
PCI: Using configuration type 1.
PCI: Probing PCI hardware.
PCI: Probing PCI hardware (bus 00).

Kinda ugly, isn't it?

klogd 1.4.1, log source = /proc/kmsg started
Linux version 2.4.22-rc2_QoS (root@vda) (gcc version 3.2) #1 Tue Nov 18 15:55:00 GMT-2 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
 BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007cf0000 (usable)
 BIOS-e820: 0000000007cf0000 - 0000000007cff000 (ACPI data)
 BIOS-e820: 0000000007cff000 - 0000000007d00000 (ACPI NVS)
 BIOS-e820: 0000000007d00000 - 0000000007e80000 (usable)
 BIOS-e820: 0000000007e80000 - 0000000008000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
126MB LOWMEM available
On node 0 totalpages: 32384
zone(0): 4096 pages
zone(1): 28288 pages
zone(2): 0 pages
Kernel command line: root=/dev/nfs  nfsroot=172.16.42.75:/.rootfs/.std,hard,intr  ip=:172.16.42.75:::(none):eth0:dhcp  devfs=mount
Initializing CPU#0
Detected 1196.031 MHz processor
Console: colour VGA+ 80x30
Calibrating delay loop... 2385.51 BogoMIPS
Memory: 123856k/129536k available (2268k kernel code, 5224k reserved, 694k data, 564k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported
Intel machine check reporting enabled on CPU#0
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel(R) Celeron(TM) CPU                1200MHz stepping 01
Enabling fast FPU save and restore... done
Enabling unmasked SIMD FPU exception support... done
Checking 'hlt' instruction... OK
Checking for popad bug... OK
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd9b8, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)

Personally I like this better
--
vda
