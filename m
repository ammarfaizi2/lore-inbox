Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbREYSFR>; Fri, 25 May 2001 14:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261404AbREYSFH>; Fri, 25 May 2001 14:05:07 -0400
Received: from comverse-in.com ([38.150.222.2]:4306 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S261369AbREYSEr>; Fri, 25 May 2001 14:04:47 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678EF9@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: linux-kernel@vger.kernel.org
Cc: "'torvalds@transmeta.com'" <torvalds@transmeta.com>,
        alan@lxorguk.ukuu.org.uk
Subject: [PATCH] 2.4.x: update for PCI vendor id 0x12d4
Date: Fri, 25 May 2001 14:03:31 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C0E545.021F8C60"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C0E545.021F8C60
Content-Type: text/plain;
	charset="koi8-r"

This is my 1st attempt to submit a patch here - flames welcome if I did smth
wrong...
It was done across 2.4.2, but it works safely against 2.4.4 as well.

 <<pci_vendor_12d4.patch>> 

Kind regards,
	Vassilii

------_=_NextPart_000_01C0E545.021F8C60
Content-Type: application/octet-stream;
	name="pci_vendor_12d4.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pci_vendor_12d4.patch"

--- /usr/src/linux-2.4.2/include/linux/pci_ids.h	Sat Feb  3 15:48:00 =
2001=0A=
+++ pci_ids.h	Fri May 25 13:15:51 2001=0A=
@@ -1110,6 +1110,8 @@=0A=
 #define PCI_VENDOR_ID_NVIDIA_SGS	0x12d2=0A=
 #define PCI_DEVICE_ID_NVIDIA_SGS_RIVA128 0x0018=0A=
 =0A=
+#define PCI_VENDOR_ID_ULTICOM	0x12d4 /* Formerly DGM&S */=0A=
+=0A=
 #define PCI_SUBVENDOR_ID_CHASE_PCIFAST		0x12E0=0A=
 #define PCI_SUBDEVICE_ID_CHASE_PCIFAST4		0x0031=0A=
 #define PCI_SUBDEVICE_ID_CHASE_PCIFAST8		0x0021=0A=
--- /usr/src/linux-2.4.2/drivers/pci/devlist.h	Tue Mar 27 16:10:22 =
2001=0A=
+++ devlist.h	Fri May 25 13:35:50 2001=0A=
@@ -3733,7 +3733,7 @@=0A=
 VENDOR(12d3,"Vingmed Sound A/S")=0A=
 ENDVENDOR()=0A=
 =0A=
-VENDOR(12d4,"DGM&S")=0A=
+VENDOR(12d4,"Ulticom (formerly DGM&S)")=0A=
 ENDVENDOR()=0A=
 =0A=
 VENDOR(12d5,"Equator Technologies")=0A=

------_=_NextPart_000_01C0E545.021F8C60--
