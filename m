Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSFJKxn>; Mon, 10 Jun 2002 06:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSFJKxm>; Mon, 10 Jun 2002 06:53:42 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:41947 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S314459AbSFJKxl>; Mon, 10 Jun 2002 06:53:41 -0400
Subject: PROBLEM: Kernel Panic 2.4.18-6mdk after ATAPI Reset on reading bad
	CD-RW (repeatable)
From: Lyall Pearce <lyallp@bigpond.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-gMo85BHB9v4y5kHoUWWD"
X-Mailer: Evolution/1.0.2-5mdk 
Date: 10 Jun 2002 20:23:35 +0930
Message-Id: <1023706416.2594.16.camel@lyalls-pc.home.net.au>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gMo85BHB9v4y5kHoUWWD
Content-Type: multipart/mixed; boundary="=-FEjXQxFVuqZLfdloTvXr"


--=-FEjXQxFVuqZLfdloTvXr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I am not sure where to send this message and am hoping you can assist.

Problem description.

I have a CD-RW80 which contains a 650mb part of a zip archive which I
was attempting to restore.
(so much for backups :( )

When attempting to read a CD-RW (700mb) in my Sony CRX1611 IDE based CD
Rewriter.
The CD-RW has a problem reading - I have no problems with this (other
than being annoyed), but when I use the following

dd conv=3D3Dnoerror if=3D3D/mnt/cdrom/Images.z01 or=3D3D~/images/Images.z01

dd reports lots of errors - this too is ok (since I figure I could
'bypass the missing section in the unpack'), until eventually the ATAPI
interface apparently resets.
Then the kernel thows a panic in the exception handler.

Initially it was simply hanging my X session - I tried doing the copy at
'init 2' level and this was when I noticed the panic.

I am able to reproduce this error at will - albeit a 5 minute turn
around time till the CD read gets to the 640mb mark where the problem
occurrs.

I do not know how to do a screen capture or where to find the panic
information - which I will gladly supply upon request, once I have been
given instructions on where to find it.

Feel free to talk technical - I am a C/Unix programmer of many years but
have had nothing to do with the kernel short of re-building it.

Mandrake 8.2 Standard Kernel version 2.4.18

Linux version 2.4.18-6mdk (quintela@bi.mandrakesoft.com) (gcc version
2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk)) #1 Fri Mar 15 02:59:08
CET 2002

Find attached a Mandrake HardDrake Report file of the hardware
configuration.

...Lyall





--=-FEjXQxFVuqZLfdloTvXr
Content-Disposition: attachment; filename=report.xml
Content-Type: text/xml; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<?xml version=3D"1.0"?>
<HARDDRAKE VERSION=3D"0.9.3">
  <DEVICES>
    <DEVICE VENDOR=3D"GenuineIntel" MODEL=3D"Pentium III (Katmai)" TYPE=3D"=
cpu" BUS=3D"Unknown" MODULE=3D"Not Available" POS=3D"0" FLAGS=3D"[HAS_FPU:H=
AS_MMX]" BOGOMIPS=3D"1104.28" BUGS=3D"(none)" FREQ=3D"553"/>
    <DEVICE TYPE=3D"memory" BUS=3D"Unknown" MODULE=3D"Not Available" POS=3D=
"0" TOTAL=3D"513868" FREE=3D"160592" SHARED=3D"0" BUFFERS=3D"119008" CACHED=
=3D"101516" SWAP_TOTAL=3D"261496" SWAP_FREE=3D"261496"/>
    <DEVICE VENDOR=3D"Unknown" MODEL=3D"ST38420A" TYPE=3D"disk" BUS=3D"ATAP=
I/IDE" MODULE=3D"Not Available" DEV=3D"/dev/hdd" POS=3D"0" SIZE=3D"16836120=
" CYLINDERS=3D"1048" HEADS=3D"255" SECTORS=3D"63"/>
    <DEVICE VENDOR=3D"Unknown" MODEL=3D"WDC WD300BB-00AUA1" TYPE=3D"disk" B=
US=3D"ATAPI/IDE" MODULE=3D"Not Available" DEV=3D"/dev/hdc" POS=3D"0" SIZE=
=3D"58633344" CYLINDERS=3D"58168" HEADS=3D"16" SECTORS=3D"63"/>
    <DEVICE VENDOR=3D"Unknown" MODEL=3D"Maxtor 92049U6" TYPE=3D"disk" BUS=
=3D"ATAPI/IDE" MODULE=3D"Not Available" DEV=3D"/dev/hda" POS=3D"0" SIZE=3D"=
40017915" CYLINDERS=3D"2491" HEADS=3D"255" SECTORS=3D"63"/>
    <DEVICE VENDOR=3D"PNY/Data" MODEL=3D"PNY/Datafab CF+S" TYPE=3D"disk" BU=
S=3D"SCSI" MODULE=3D"Not Available" DEV=3D"/dev/sda" POS=3D"0" SIZE=3D"2095=
104" CYLINDERS=3D"1023" HEADS=3D"64" SECTORS=3D"32"/>
    <DEVICE VENDOR=3D"Unknown" MODEL=3D"1.44MB 3.5&quot;" TYPE=3D"floppy" B=
US=3D"Floppy Drive Controller" MODULE=3D"Not Available" DEV=3D"/dev/fd0" PO=
S=3D"0"/>
    <DEVICE VENDOR=3D"Unknown" MODEL=3D"SONY CD-RW CRX1611" TYPE=3D"cdrom" =
BUS=3D"ATAPI/IDE" MODULE=3D"ignore" DEV=3D"/dev/hdb" POS=3D"0"/>
    <DEVICE VENDOR=3D"SONY" MODEL=3D"CD-RW CRX1611" TYPE=3D"cdrom" BUS=3D"S=
CSI" MODULE=3D"ignore" DEV=3D"/dev/scd0" POS=3D"0"/>
    <DEVICE VENDOR=3D"Realtek Semiconductor Co., Ltd." MODEL=3D"RTL-8139" T=
YPE=3D"ethernet" BUS=3D"PCI" MODULE=3D"rtl8139" POS=3D"0" ID=3D"10ec8139"/>
    <DEVICE VENDOR=3D"nVidia Corporation" MODEL=3D"GeForce DDR (generic)	NV=
11" TYPE=3D"video" BUS=3D"PCI" MODULE=3D"Not Available" POS=3D"0" ID=3D"000=
00000"/>
    <DEVICE VENDOR=3D"VIA Technologies, Inc." MODEL=3D"VT82C586 IDE [Apollo=
]" TYPE=3D"ide" BUS=3D"PCI" MODULE=3D"ignore" POS=3D"0" ID=3D"11060571"/>
    <DEVICE VENDOR=3D"VIA Technologies, Inc." MODEL=3D"VT82C586B USB" TYPE=
=3D"usb" BUS=3D"PCI" MODULE=3D"usb-uhci" POS=3D"0" ID=3D"11063038"/>
    <DEVICE VENDOR=3D"Ensoniq" MODEL=3D"5880 AudioPCI" TYPE=3D"sound" BUS=
=3D"PCI" MODULE=3D"es1371" POS=3D"0" FLAGS=3D"[]" ID=3D"12745880"/>
    <DEVICE VENDOR=3D"Unknown" MODEL=3D"Unknown" TYPE=3D"other" BUS=3D"USB"=
 POS=3D"0" ID=3D"045e0040"/>
    <DEVICE VENDOR=3D"Unknown" MODEL=3D"Unknown" TYPE=3D"other" BUS=3D"USB"=
 POS=3D"0" ID=3D"04512046"/>
    <DEVICE VENDOR=3D"Unknown" MODEL=3D"Unknown" TYPE=3D"other" BUS=3D"USB"=
 POS=3D"0" ID=3D"07c4a005"/>
    <DEVICE VENDOR=3D"VIA Technologies, Inc." MODEL=3D"VT82C691 [Apollo PRO=
]" TYPE=3D"bridge" BUS=3D"PCI" MODULE=3D"ignore" POS=3D"0" ID=3D"11060691"/=
>
    <DEVICE VENDOR=3D"VIA Technologies, Inc." MODEL=3D"VT82C598 [Apollo MVP=
3 AGP]" TYPE=3D"bridge" BUS=3D"PCI" MODULE=3D"ignore" POS=3D"0" ID=3D"11068=
598"/>
    <DEVICE VENDOR=3D"VIA Technologies, Inc." MODEL=3D"VT82C596 ISA [Apollo=
 PRO]" TYPE=3D"bridge" BUS=3D"PCI" MODULE=3D"ignore" POS=3D"0" ID=3D"110605=
96"/>
    <DEVICE VENDOR=3D"VIA Technologies, Inc." MODEL=3D"Power Management Con=
troller" TYPE=3D"bridge" BUS=3D"PCI" MODULE=3D"ignore" POS=3D"0" ID=3D"1106=
3050"/>
  </DEVICES>
</HARDDRAKE>

--=-FEjXQxFVuqZLfdloTvXr--

--=-gMo85BHB9v4y5kHoUWWD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj0EhS8ACgkQnWl+ZG69hPdf6QCfU/jP/Pb9OrPCKK1jF7HFGmtr
+q0Anj6jzOJZkHjM06gNCmldubSKKq95
=tK7u
-----END PGP SIGNATURE-----

--=-gMo85BHB9v4y5kHoUWWD--

