Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275505AbTHNVOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 17:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275508AbTHNVOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 17:14:37 -0400
Received: from admingilde.org ([213.95.21.5]:16773 "EHLO admingilde.org")
	by vger.kernel.org with ESMTP id S275505AbTHNVOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 17:14:33 -0400
Date: Thu, 14 Aug 2003 23:14:36 +0200
From: Martin Waitz <tali@admingilde.org>
To: linux-kernel@vger.kernel.org
Cc: linux1394-devel@lists.sourceforge.net
Subject: sleep while atomic in ieee1394
Message-ID: <20030814211435.GA4423@admingilde.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

while testing my new firewire/usb disc enclosure, i got
the following error: (kernel is something between test2 & test3)


Aug 14 22:05:44 pergament kernel: ohci1394: $Rev: 1023 $ Ben Collins <bcoll=
ins@debian.org>
Aug 14 22:05:44 pergament kernel: ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=3D[1=
0]  MMIO=3D[81c00000-81c007ff]  Max Packet=3D[2048]
Aug 14 22:05:44 pergament kernel: Debug: sleeping function called from inva=
lid context at mm/slab.c:1817
Aug 14 22:05:44 pergament kernel: Call Trace:
Aug 14 22:05:44 pergament kernel:  [<c0124ad1>] __might_sleep+0x61/0x80
Aug 14 22:05:44 pergament kernel:  [<c015c714>] __kmalloc+0x1b4/0x1d0
Aug 14 22:05:44 pergament kernel:  [<d0a44dc9>] hpsb_create_hostinfo+0x39/0=
xd0 [ieee1394]
Aug 14 22:05:44 pergament kernel:  [<d0a4a3c4>] nodemgr_add_host+0x24/0x210=
 [ieee1394]
Aug 14 22:05:44 pergament kernel:  [<c0206ebf>] sprintf+0x1f/0x30
Aug 14 22:05:44 pergament kernel:  [<d0a45656>] highlevel_add_host+0x76/0x8=
0 [ieee1394]
Aug 14 22:05:44 pergament kernel:  [<d0a44bed>] hpsb_add_host+0x6d/0xa0 [ie=
ee1394]
Aug 14 22:05:44 pergament kernel:  [<d09d6eb4>] ohci1394_pci_probe+0x484/0x=
620 [ohci1394]
Aug 14 22:05:44 pergament kernel:  [<d09d3d40>] ohci_irq_handler+0x0/0x1110=
 [ohci1394]
Aug 14 22:05:44 pergament kernel:  [<c020cb9d>] pci_device_probe_static+0x4=
d/0x70
Aug 14 22:05:44 pergament kernel:  [<c020cf0c>] __pci_device_probe+0x3c/0x50
Aug 14 22:05:44 pergament kernel:  [<c020cf4f>] pci_device_probe+0x2f/0x50
Aug 14 22:05:44 pergament kernel:  [<c025c423>] bus_match+0x43/0x80
Aug 14 22:05:44 pergament kernel:  [<c025c54d>] driver_attach+0x5d/0x70
Aug 14 22:05:44 pergament kernel:  [<c025c854>] bus_add_driver+0xb4/0xd0
Aug 14 22:05:44 pergament kernel:  [<c025cd28>] driver_register+0x88/0x90
Aug 14 22:05:44 pergament kernel:  [<c020d3a8>] pci_register_driver+0xa8/0x=
d0
Aug 14 22:05:44 pergament kernel:  [<d092c015>] ohci1394_init+0x15/0x3e [oh=
ci1394]
Aug 14 22:05:44 pergament kernel:  [<c0149c7a>] sys_init_module+0x1ea/0x3c0
Aug 14 22:05:44 pergament kernel:  [<c010b04b>] syscall_call+0x7/0xb
Aug 14 22:05:44 pergament kernel:=20
Aug 14 22:05:45 pergament kernel: SCSI subsystem initialized
Aug 14 22:05:45 pergament kernel: sbp2: $Rev: 1018 $ Ben Collins <bcollins@=
debian.org>
Aug 14 22:05:45 pergament kernel: scsi0 : SCSI emulation for IEEE-1394 SBP-=
2 Devices
Aug 14 22:05:47 pergament kernel: ieee1394: sbp2: Logged into SBP-2 device
Aug 14 22:05:47 pergament kernel: arch/i386/kernel/semaphore.c:84: spin_is_=
locked on uninitialized spinlock c0aa0898.
Aug 14 22:05:47 pergament kernel: Unable to handle kernel paging request at=
 virtual address 6b6b6b6b
Aug 14 22:05:47 pergament kernel:  printing eip:
Aug 14 22:05:47 pergament kernel: c0206d0a
Aug 14 22:05:47 pergament kernel: *pde =3D 00000000
Aug 14 22:05:47 pergament kernel: Oops: 0000 [#1]
Aug 14 22:05:47 pergament kernel: CPU:    0
Aug 14 22:05:47 pergament kernel: EIP:    0060:[<c0206d0a>]    Not tainted
Aug 14 22:05:47 pergament kernel: EFLAGS: 00010097
Aug 14 22:05:47 pergament kernel: EIP is at vsnprintf+0x31a/0x450
Aug 14 22:05:47 pergament ieee1394.agent[1908]: ... can't load module sbp2
Aug 14 22:05:47 pergament ieee1394.agent[1908]: missing kernel or user mode=
 driver sbp2=20
Aug 14 22:05:47 pergament kernel: eax: 6b6b6b6b   ebx: 0000000a   ecx: 6b6b=
6b6b   edx: fffffffe
Aug 14 22:05:47 pergament kernel: esi: c043a6eb   edi: 00000000   ebp: c0a0=
bd78   esp: c0a0bd40
Aug 14 22:05:47 pergament kernel: ds: 007b   es: 007b   ss: 0068
Aug 14 22:05:47 pergament kernel: Process modprobe (pid: 1918, threadinfo=
=3Dc0a0a000 task=3Dc0b29be0)
Aug 14 22:05:47 pergament kernel: Stack: c043a6dd c043aabf 00000054 0000000=
0 0000000a ffffffff 00000001 00000002=20
Aug 14 22:05:47 pergament kernel:        ffffffff ffffffff c043aabf c043a6c=
0 00000046 c0364d19 c0a0bdc8 c012916b=20
Aug 14 22:05:47 pergament kernel:        c043a6c0 00000400 c035e312 c0a0bde=
0 c0122085 ce194494 c0aa0860 00000004=20
Aug 14 22:05:47 pergament kernel: Call Trace:
Aug 14 22:05:47 pergament kernel:  [<c012916b>] printk+0x16b/0x3e0
Aug 14 22:05:47 pergament kernel:  [<c0122085>] schedule+0x3d5/0x720
Aug 14 22:05:47 pergament kernel:  [<d09d1468>] dma_trm_flush+0x128/0x180 [=
ohci1394]
Aug 14 22:05:47 pergament kernel:  [<c0109184>] __down+0x1d4/0x340
Aug 14 22:05:47 pergament kernel:  [<c0122420>] default_wake_function+0x0/0=
x30
Aug 14 22:05:47 pergament kernel:  [<d0a41e62>] hpsb_send_packet+0xa2/0x1b0=
 [ieee1394]
Aug 14 22:05:47 pergament kernel:  [<c01097e7>] __down_failed+0xb/0x14
Aug 14 22:05:47 pergament kernel:  [<d09b6f5d>] .text.lock.sbp2+0x5/0x38 [s=
bp2]
Aug 14 22:05:47 pergament kernel:  [<d09b472d>] sbp2_start_device+0x1fd/0x3=
e0 [sbp2]
Aug 14 22:05:47 pergament kernel:  [<d09b44e5>] sbp2_start_ud+0x105/0x150 [=
sbp2]
Aug 14 22:05:47 pergament kernel:  [<d09b3fa8>] sbp2_probe+0x38/0x50 [sbp2]
Aug 14 22:05:47 pergament kernel:  [<c025c423>] bus_match+0x43/0x80
Aug 14 22:05:47 pergament kernel:  [<c025c54d>] driver_attach+0x5d/0x70
Aug 14 22:05:47 pergament kernel:  [<c025c854>] bus_add_driver+0xb4/0xd0
Aug 14 22:05:47 pergament kernel:  [<c025cd28>] driver_register+0x88/0x90
Aug 14 22:05:47 pergament kernel:  [<d0a49777>] hpsb_register_protocol+0x17=
/0x30 [ieee1394]
Aug 14 22:05:47 pergament kernel:  [<d09b6f2c>] sbp2_module_init+0x7c/0xa8 =
[sbp2]
Aug 14 22:05:47 pergament kernel:  [<c0149c7a>] sys_init_module+0x1ea/0x3c0
Aug 14 22:05:47 pergament kernel:  [<c010b04b>] syscall_call+0x7/0xb
Aug 14 22:05:47 pergament kernel:=20
Aug 14 22:05:47 pergament kernel: Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4=
 29 c8 83 e7 10 89 c3 75=20
Aug 14 22:05:47 pergament kernel:  <6>note: modprobe[1918] exited with pree=
mpt_count 2

there are some more related errors afterwards caused by the above...


under 2.4, /proc/bus/ieee1394/devices looks like:

Node[0-01:1023]  GUID[000124100c0111aa]:
  Vendor ID: `Linux OHCI-1394' [0x000000]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(1) CMC(1) ISC(1) BMC(0) PMC(0) GEN(0)
    LSPD(2) MAX_REC(2048) CYC_CLK_ACC(0)
  Host Node Status:
    Host Driver     : ohci1394
    Nodes connected : 2
    Nodes active    : 2
    SelfIDs received: 2
    Irm ID          : [0-01:1023]
    BusMgr ID       : [0-63:1023]
    In Bus Reset    : no
    Root            : yes
    Cycle Master    : yes
    IRM             : yes
    Bus Manager     : no
Node[0-00:1023]  GUID[0001a300000096af]:
  Vendor ID: `Terabit 2.5" Portable HDD' [0x0001a3]
  Capabilities: 0x0083c0
  Bus Options:
    IRMC(0) CMC(0) ISC(0) BMC(0) PMC(0) GEN(0)
    LSPD(2) MAX_REC(64) CYC_CLK_ACC(255)
  Unit Directory 0:
    Vendor/Model ID: Terabit 2.5" Portable HDD [0001a3] / Unknown [008034]
    Software Specifier ID: 00609e
    Software Version: 010483
    Driver: SBP2 Driver
    Length (in quads): 5

--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  Department of Computer Science 3       _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/O/u7j/Eaxd/oD7IRAuE/AJ9KPdJhxDl/sxU3e1GtiQBCLcji/gCeINpL
jjM2ovJNZa1AfHvUNjXtsuE=
=izOU
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
