Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267384AbSKPVvk>; Sat, 16 Nov 2002 16:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267385AbSKPVvk>; Sat, 16 Nov 2002 16:51:40 -0500
Received: from mail1.csc.albany.edu ([169.226.1.133]:3535 "EHLO
	smtp.albany.edu") by vger.kernel.org with ESMTP id <S267384AbSKPVv1>;
	Sat, 16 Nov 2002 16:51:27 -0500
From: Justin A <ja6447@albany.edu>
To: linux-kernel@vger.kernel.org
Subject: pnpbios oops on boot w/ 2.5.47
Date: Sat, 16 Nov 2002 17:00:29 -0500
User-Agent: KMail/1.4.3
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_TSVOTJ0NI3W5EIFNKPYA"
Message-Id: <200211161700.29653.ja6447@albany.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_TSVOTJ0NI3W5EIFNKPYA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi :)

I tried to "port" kmsgdump to 2.5.47 and for some reason, it worked.

Attached is the full dmesg

Alan: I ran dmidecode under 2.4.19 which said simply "PNP BIOS present"

This is a thinkpad 760e, really old..I don't even think I need pnpbios su=
pport=20
for anything.  2.5.47/2.5.47-ac5 boot with pnpbios turned off, so I think=
 you=20
just need to add this to your blacklist?

--=20
-Justin

--------------Boundary-00=_TSVOTJ0NI3W5EIFNKPYA
Content-Type: text/plain;
  charset="us-ascii";
  name="messages.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="messages.txt"

<4>Linux version 2.5.47 (justin@s.bouncybouncy.net) (gcc version 2.95.4 20011002 (Debian prerelease)) #8 Sat Nov 16 16:33:57 EST 2002
<4>Video mode to be used for restore is f00
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 0000000004800000 (usable)
<4> BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
<5>72MB LOWMEM available.
<4>On node 0 totalpages: 18432
<4>  DMA zone: 4096 pages, LIFO batch:1
<4>  Normal zone: 14336 pages, LIFO batch:3
<4>  HighMem zone: 0 pages, LIFO batch:1
<4>Building zonelist for node : 0
<4>Kernel command line: BOOT_IMAGE=test ro root=302 resume=/dev/hda1
<6>Initializing CPU#0
<4>Detected 119.769 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 235.52 BogoMIPS
<6>Memory: 69928k/73728k available (1155k kernel code, 3324k reserved, 1053k data, 80k init, 0k highmem)
<6>Security Scaffold v1.0.0 initialized
<6>Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
<4>Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
<4>Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
<6>-> /dev
<6>-> /dev/console
<6>-> /root
<7>CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
<5>Intel Pentium with F0 0F bug - workaround enabled.
<7>CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
<7>CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
<7>CPU:             Common caps: 000001bf 00000000 00000000 00000000
<4>CPU: Intel Pentium 75 - 200 stepping 0c
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<6>Linux Plug and Play Support v0.9 (c) Adam Belay
<6>PCI: PCI BIOS revision 2.10 entry at 0xfdaa0, last bus=6
<6>PCI: Using configuration type 1
<7>Registering system device cpu0
<7>adding 'CPU 0' to cpu class interfaces
<4>BIO: pool of 256 setup, 14Kb (56 bytes/bio)
<4>biovec pool[0]:   1 bvecs: 134 entries (12 bytes)
<4>biovec pool[1]:   4 bvecs: 134 entries (48 bytes)
<4>biovec pool[2]:  16 bvecs: 134 entries (192 bytes)
<4>biovec pool[3]:  64 bvecs:  67 entries (768 bytes)
<4>biovec pool[4]: 128 bvecs:  33 entries (1536 bytes)
<4>biovec pool[5]: 256 bvecs:  16 entries (3072 bytes)
<4>block request queues:
<4> 128 requests per read queue
<4> 128 requests per write queue
<4> 8 requests per batch
<4> enter congestion at 31
<4> exit congestion at 33
<6>PnPBIOS: Found PnP BIOS installation structure at 0xc00fe700
<6>PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe724, dseg 0xf0000
<6>pnp: 00:10: ioport range 0x100-0x107 has been reserved
<6>pnp: 00:10: ioport range 0x15ee-0x15ef has been reserved
<6>PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
<6>isapnp: Scanning for PnP cards...
<6>isapnp: No Plug & Play device found
<4>PCI: Probing PCI hardware
<4>PCI: Probing PCI hardware (bus 00)
<7>Registering system device pic0
<7>Registering system device rtc0
<6>slab: reap timer started for cpu 0
<4>Starting kswapd
<5>aio_setup: sizeof(struct page) = 40
<6>[c4782040] eventpoll: driver installed.
<6>Journalled Block Device driver loaded
<6>devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
<6>devfs: boot_options: 0x0
<6>Capability LSM initialized
<6>Initializing Cryptographic API
<6>Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
<4>tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
<3>PnPBIOS: set_dev_node: Unexpected status 0x85
<4>------------[ cut here ]------------
<4>kernel BUG at mm/slab.c:1454!
<4>invalid operand: 0000
<4> 
<4>CPU:    0
<4>EIP:    0060:[<c012c4c2>]    Not tainted
<4>EFLAGS: 00010093
<4>EIP is at kfree+0x136/0x220
<4>eax: c47fea10   ebx: c47ff080   ecx: c47fe000   edx: 02f84b00
<4>esi: c47fe9e8   edi: 000047fe   ebp: c473f800   esp: c4785ef4
<4>ds: 0068   es: 0068   ss: 0068
<4>Process swapper (pid: 1, threadinfo=c4784000 task=c4782040)
<4>Stack: c47fe9ec 00000002 c4762400 00000004 00000000 c47fe9ec 000b3fb0 00000282 
<4>       c01d01d8 c47fe9ec c4738000 14738000 00520010 c01cdc92 c4762400 c4738000 
<4>       00000000 c0318840 c4762400 ffffffed 00000000 c01ccb8f c4762400 c476264c 
<4>Call Trace:
<4> [<c01d01d8>] pnpbios_set_resources+0x7c/0x90
<4> [<c01cdc92>] pnp_activate_dev+0xe6/0x114
<4> [<c01ccb8f>] pnp_device_probe+0x33/0xc4
<4> [<c0192723>] bus_match+0x37/0x5c
<4> [<c0192810>] driver_attach+0x44/0x74
<4> [<c0192ab8>] bus_add_driver+0x60/0x80
<4> [<c0192fa5>] driver_register+0x69/0x84
<4> [<c01cccd1>] pnp_register_driver+0x29/0x48
<4> [<c0105024>] init+0x0/0x13c
<4> [<c010503e>] init+0x1a/0x13c
<4> [<c0105024>] init+0x0/0x13c
<4> [<c0106e95>] kernel_thread_helper+0x5/0xc
<4>
<4>Code: 0f 0b ae 05 c8 95 22 c0 8b 49 0c 8b 53 30 89 f0 29 c8 89 54 
<4> <0>Kernel panic: Attempted to kill init!
<4> <0>Dumping messages in 0 seconds : last chance for Alt-SysRq...

--------------Boundary-00=_TSVOTJ0NI3W5EIFNKPYA--

