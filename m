Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264200AbTEOT1L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264202AbTEOT1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:27:11 -0400
Received: from www.hostsharing.net ([212.42.230.151]:32153 "EHLO
	pima.hostsharing.net") by vger.kernel.org with ESMTP
	id S264200AbTEOT1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:27:02 -0400
Date: Thu, 15 May 2003 21:41:18 +0200
From: Elimar Riesebieter <riesebie@lxtec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: radeonfb and high mem
Message-ID: <20030515194118.GA696@gandalf.home.lxtec.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
Organization: LXTEC
X-gnupg-key-fingerprint: BE65 85E4 4867 7E9B 1F2A  B2CE DC88 3C6E C54F 7FB0
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi all,

I am running 2.4.21.rc2-ac2 with 1 GB RAM. The radeonfb can't map
FB. If I boot with mem=3D840MB the framebuffer runs. I thought it will
be fixed with the vesa_highmem fix but isn't with vesafb at all. The
same happens with noacpi ;-) The RAM is tested as good with memtest!

Does someone has some hints?

Thanks in advance

Elimar

##################################

# dmesg

Linux version 2.4.21-rc2-ac2-gandalf (root@gandalf) (gcc version 3.2.3) #3 =
Wed May 14 20:17:50 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffec000 (usable)
 BIOS-e820: 000000003ffec000 - 000000003ffef000 (ACPI data)
 BIOS-e820: 000000003ffef000 - 000000003ffff000 (reserved)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262124
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32748 pages.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f52b0
ACPI: RSDT (v001 ASUS   P4B533   16944.11825) @ 0x3ffec000
ACPI: FADT (v001 ASUS   P4B533   16944.11825) @ 0x3ffec0c0
ACPI: BOOT (v001 ASUS   P4B533   16944.11825) @ 0x3ffec030
ACPI: MADT (v001 ASUS   P4B533   16944.11825) @ 0x3ffec058
ACPI: DSDT (v001   ASUS P4B533   00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 16
Kernel command line: BOOT_IMAGE=3D2.4.21-rc2-ac2 ro root=3D306 video=3Drade=
onfb:1280x1024 hdc=3Dide-scsi
ide_setup: hdc=3Dide-scsi
Found and enabled local APIC!
Initializing CPU#0
Detected 2423.931 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4836.55 BogoMIPS
Memory: 1033188k/1048496k available (1631k kernel code, 14920k reserved, 52=
5k data, 112k init, 130992k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 2423.9336 MHz.
=2E.... host bus clock speed is 134.6628 MHz.
cpu: 0, clocks: 1346628, slice: 673314
CPU0<T0:1346624,T1:673296,D:14,S:673314,C:1346628>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
NTFS driver v1.1.22 [Flags: R/O]
i2c-core.o: i2c core module
PCI: Found IRQ 11 for device 01:00.0
PCI: Sharing IRQ 11 with 00:1d.0
radeonfb: ref_clk=3D2700, ref_div=3D12, xclk=3D25000 from BIOS
radeonfb: cannot map FB

# lspci

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge =
(rev 11)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (r=
ev 11)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01)
00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If [Rad=
eon 9000] (rev 01)
01:00.1 Display controller: ATI Technologies Inc Radeon R250 [Radeon 9000] =
(Secondary) (rev 01)
02:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
02:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C=
/8139C+ (rev 10)
02:0c.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)

# meminfo

        total:    used:    free:  shared: buffers:  cached:
Mem:  867450880 189087744 678363136        0 19050496 99794944
Swap: 2147467264        0 2147467264
MemTotal:       847120 kB
MemFree:        662464 kB
MemShared:           0 kB
Buffers:         18604 kB
Cached:          97456 kB
SwapCached:          0 kB
Active:          47828 kB
Inactive:       111248 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       847120 kB
LowFree:        662464 kB
SwapTotal:     2097136 kB
SwapFree:      2097136 kB


radeonfb.c is patched with

--- ../linux-2.4.21-rc2-ac2-unpatched/drivers/video/radeonfb.c	2003-05-13 2=
0:13:00.000000000 +0200
+++ ../linux-2.4.21-rc2-ac2/drivers/video/radeonfb.c	2003-05-13 20:16:28.00=
0000000 +0200
@@ -19,7 +19,7 @@
  *	2001-11-18	DFP fixes, Kevin Hendricks, 0.1.3
  *	2001-11-29	more cmap, backlight fixes, Benjamin Herrenschmidt
  *	2002-01-18	DFP panel detection via BIOS, Michael Clark, 0.1.4
- *
+ *	2003-01-30 Added Radeon R9000, Tanaskovic Toplica <toptan_at_EUnet.yu>
  *	Special thanks to ATI DevRel team for their hardware donations.
  *
  */
@@ -101,6 +101,7 @@
 	RADEON_LW,	/* Radeon Mobility M7 */
 	RADEON_LY,	/* Radeon Mobility M6 */
 	RADEON_LZ,	/* Radeon Mobility M6 */
+	RADEON_IG,	/* Radeon RV250 (9000) */
 	RADEON_PM	/* Radeon Mobility P/M */
 };
=20
@@ -128,6 +129,7 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LW, PCI_ANY_ID, PCI_ANY_ID, 0, =
0, RADEON_LW},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LY, PCI_ANY_ID, PCI_ANY_ID, 0, =
0, RADEON_LY},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LZ, PCI_ANY_ID, PCI_ANY_ID, 0, =
0, RADEON_LZ},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_IG, PCI_ANY_ID, PCI_ANY_ID, 0, =
0, RADEON_IG},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_PM, PCI_ANY_ID, PCI_ANY_ID, 0, =
0, RADEON_PM},
 	{ 0, }
 };
@@ -858,7 +860,11 @@
 			strcpy(rinfo->name, "Radeon M6 LZ ");
 			rinfo->hasCRTC2 =3D 1;
 			break;
-	        case PCI_DEVICE_ID_RADEON_PM:
+		case PCI_DEVICE_ID_RADEON_IG:
+			strcpy(rinfo->name, "Radeon R9000 IG ");
+			rinfo->hasCRTC2 =3D 1;
+			break;
+		case PCI_DEVICE_ID_RADEON_PM:
 			strcpy(rinfo->name, "Radeon P/M ");
 			rinfo->hasCRTC2 =3D 1;
 		default:
@@ -871,14 +877,6 @@
 	/* mem size is bits [28:0], mask off the rest */
 	rinfo->video_ram =3D tmp & CONFIG_MEMSIZE_MASK;
=20
-	/* According to XFree86 4.2.0, some production M6's return 0
-	   for 8MB. */
-	if (rinfo->video_ram =3D=3D 0 &&
-	    (pdev->device =3D=3D PCI_DEVICE_ID_RADEON_LY ||
-	     pdev->device =3D=3D PCI_DEVICE_ID_RADEON_LZ)) {
-	    rinfo->video_ram =3D 8192 * 1024;
-	  }
-
 	/* ram type */
 	tmp =3D INREG(MEM_SDRAM_MODE_REG);
 	switch ((MEM_CFG_TYPE & tmp) >> 30) {
@@ -2786,7 +2784,7 @@
 	lvds_gen_cntl |=3D (LVDS_BL_MOD_EN | LVDS_BLON);
 	if (on && (level > BACKLIGHT_OFF)) {
 		lvds_gen_cntl |=3D LVDS_DIGON;
-		if ((lvds_gen_cntl & LVDS_ON) =3D=3D 0) {
+		if (!lvds_gen_cntl & LVDS_ON) {
 			lvds_gen_cntl &=3D ~LVDS_BLON;
 			OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
 			(void)INREG(LVDS_GEN_CNTL);


radeon.h is patched with


--- ../linux-2.4.21-rc2-ac2-unpatched/drivers/video/radeon.h	2002-11-29 00:=
53:15.000000000 +0100
+++ ../linux-2.4.21-rc2-ac2/drivers/video/radeon.h	2003-05-13 20:16:28.0000=
00000 +0200
@@ -12,6 +12,7 @@
 #define PCI_DEVICE_ID_RADEON_LW		0x4c57
 #define PCI_DEVICE_ID_RADEON_LY		0x4c59
 #define PCI_DEVICE_ID_RADEON_LZ		0x4c5a
+#define PCI_DEVICE_ID_RADEON_IG		0x4966
 #define PCI_DEVICE_ID_RADEON_PM		0x4c52
 #define PCI_DEVICE_ID_RADEON_QL		0x514c
 #define PCI_DEVICE_ID_RADEON_QW		0x5157




--=20
  Excellent day for drinking heavily.=20
  Spike the office water cooler;-)

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+w+1e3Ig8bsVPf7ARAvNeAJ4z4GVhZVwEngW5Al8ZbU45iDnzAgCeIBvS
UdWdt7Vaqyk8pz7hK+iLpJA=
=FYEd
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
