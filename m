Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266308AbUJNSZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUJNSZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUJNSZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:25:58 -0400
Received: from fw1.afb.de ([195.30.9.122]:48009 "EHLO fw1.afb.de")
	by vger.kernel.org with ESMTP id S266186AbUJNRYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 13:24:23 -0400
Message-ID: <2F4E8F809920D611B0B300508BDE95FE7AD447@AFB91>
From: BoehmeSilvio <Boehme.Silvio@afb.de>
To: linux-kernel@vger.kernel.org
Subject: USB Keyboard not working
Date: Thu, 14 Oct 2004 19:25:31 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4B212.CE742490"
X-Scan-Signature: 2a26fc964b28f6975663cc5c3647e6fb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4B212.CE742490
Content-Type: text/plain;
	charset="iso-8859-1"

Hi!

I have a problem with my USB keyboard.

It seems that the keyboard is recognized somehow, but it's not working at
the end.
I have tested this with Kernel 2.6.9-rc4, 2.6.8.1 and 2.6.4 with the same
results.

Please find attached the output at dmesg in case of plug and unplug.
I have compiled the kernel with hid debugging turned on.
(hid-core.c #define DEBUG)

Can someone have a look at these messages?

thanks

Silvio Boehme


------_=_NextPart_000_01C4B212.CE742490
Content-Type: text/plain;
	name="plug.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="plug.txt"

hid-debug: input Keyboard.0028 =3D 0=0A=
hid-debug: input Keyboard.0052 =3D 1=0A=
hid-debug: input Keyboard.0052 =3D 0=0A=
hub 5-0:1.0: connect-debounce failed, port 8 disabled=0A=
usb 4-1: new low speed USB device using address 3=0A=
drivers/usb/input/hid-core.c: HID probe called for ifnum 0=0A=
drivers/usb/input/hid-core.c: submitting ctrl urb: Get_Report =
wValue=3D0x0103 wIndex=3D0x0000 wLength=3D8=0A=
hid-debug: input Keyboard.002a =3D 1=0A=
hid-debug: input Keyboard.002a =3D 0=0A=
hid-debug: input Keyboard.002a =3D 1=0A=
hid-debug: input Keyboard.002a =3D 0=0A=
hid-debug: input Keyboard.002a =3D 1=0A=
hid-debug: input Keyboard.002a =3D 0=0A=
hid-debug: input Keyboard.0028 =3D 1=0A=
hid-debug: input Keyboard.0028 =3D 0=0A=
hid-debug: input Keyboard.0052 =3D 1=0A=
hid-debug: input Keyboard.0052 =3D 0=0A=
hid-debug: input Keyboard.0028 =3D 1=0A=
hid-debug: input Keyboard.0028 =3D 0=0A=
hid-debug: input Keyboard.0052 =3D 1=0A=
hid-debug: input Keyboard.0052 =3D 0=0A=
hid-debug: input Keyboard.0028 =3D 1=0A=
hid-debug: input Keyboard.0028 =3D 0=0A=
hid-debug: input Keyboard.0028 =3D 1=0A=
hid-debug: input Keyboard.0028 =3D 0=0A=
hid-debug: input Keyboard.0052 =3D 1=0A=
hid-debug: input Keyboard.0052 =3D 0=0A=
hid-debug: input Keyboard.0028 =3D 1=0A=
hid-debug: input Keyboard.0028 =3D 0=0A=
drivers/usb/input/hid-core.c: timeout waiting for ctrl or out queue to =
clear=0A=
drivers/usb/input/hid-core.c: submitting ctrl urb: Get_Report =
wValue=3D0x0102 wIndex=3D0x0000 wLength=3D2=0A=
hid-debug: input Keyboard.0052 =3D 1=0A=
hid-debug: input Keyboard.0052 =3D 0=0A=
hid-debug: input Keyboard.0028 =3D 1=0A=
hid-debug: input Keyboard.0028 =3D 0=0A=
hid-debug: input Keyboard.0052 =3D 1=0A=
hid-debug: input Keyboard.0052 =3D 0=0A=
hid-debug: input Keyboard.0028 =3D 1=0A=
hid-debug: input Keyboard.0028 =3D 0=0A=
hid-debug: input Keyboard.0052 =3D 1=0A=
hid-debug: input Keyboard.0052 =3D 0=0A=
hid-debug: input Keyboard.0028 =3D 1=0A=
hid-debug: input Keyboard.0028 =3D 0=0A=
drivers/usb/input/hid-core.c: timeout waiting for ctrl or out queue to =
clear=0A=
drivers/usb/input/hid-core.c: submitting ctrl urb: Get_Report =
wValue=3D0x0101 wIndex=3D0x0000 wLength=3D3=0A=
drivers/usb/input/hid-core.c: timeout waiting for ctrl or out queue to =
clear=0A=
drivers/usb/input/hid-core.c: submitting ctrl urb: Get_Report =
wValue=3D0x0104 wIndex=3D0x0000 wLength=3D5=0A=
drivers/usb/input/hid-core.c: timeout waiting for ctrl or out queue to =
clear=0A=
drivers/usb/input/hid-core.c: timeout initializing reports=0A=
=0A=
  INPUT(3)[INPUT]=0A=
    Field(0)=0A=
      Usage(8)=0A=
        Keyboard.00e0=0A=
        Keyboard.00e1=0A=
        Keyboard.00e2=0A=
        Keyboard.00e3=0A=
        Keyboard.00e4=0A=
        Keyboard.00e5=0A=
        Keyboard.00e6=0A=
        Keyboard.00e7=0A=
      Logical Minimum(0)=0A=
      Logical Maximum(1)=0A=
      Report Size(1)=0A=
      Report Count(8)=0A=
      Report Offset(0)=0A=
      Flags( Variable Absolute )=0A=
    Field(1)=0A=
      Usage(256)=0A=
        Keyboard.LED=0A=
        Keyboard.0001=0A=
        Keyboard.0002=0A=
        Keyboard.0003=0A=
        Keyboard.0004=0A=
        Keyboard.0005=0A=
        Keyboard.0006=0A=
        Keyboard.0007=0A=
        Keyboard.0008=0A=
        Keyboard.0009=0A=
        Keyboard.000a=0A=
        Keyboard.000b=0A=
        Keyboard.000c=0A=
        Keyboard.000d=0A=
        Keyboard.000e=0A=
        Keyboard.000f=0A=
        Keyboard.0010=0A=
        Keyboard.0011=0A=
        Keyboard.0012=0A=
        Keyboard.0013=0A=
        Keyboard.0014=0A=
        Keyboard.0015=0A=
        Keyboard.0016=0A=
        Keyboard.0017=0A=
        Keyboard.0018=0A=
        Keyboard.0019=0A=
        Keyboard.001a=0A=
        Keyboard.001b=0A=
        Keyboard.001c=0A=
        Keyboard.001d=0A=
        Keyboard.001e=0A=
        Keyboard.001f=0A=
        Keyboard.0020=0A=
        Keyboard.0021=0A=
        Keyboard.0022=0A=
        Keyboard.0023=0A=
        Keyboard.0024=0A=
        Keyboard.0025=0A=
        Keyboard.0026=0A=
        Keyboard.0027=0A=
        Keyboard.0028=0A=
        Keyboard.0029=0A=
        Keyboard.002a=0A=
        Keyboard.002b=0A=
        Keyboard.002c=0A=
        Keyboard.002d=0A=
        Keyboard.002e=0A=
        Keyboard.002f=0A=
        Keyboard.0030=0A=
        Keyboard.0031=0A=
        Keyboard.0032=0A=
        Keyboard.0033=0A=
        Keyboard.0034=0A=
        Keyboard.0035=0A=
        Keyboard.0036=0A=
        Keyboard.0037=0A=
        Keyboard.0038=0A=
        Keyboard.0039=0A=
        Keyboard.003a=0A=
        Keyboard.003b=0A=
        Keyboard.003c=0A=
        Keyboard.003d=0A=
        Keyboard.003e=0A=
        Keyboard.003f=0A=
        Keyboard.0040=0A=
        Keyboard.0041=0A=
        Keyboard.0042=0A=
        Keyboard.0043=0A=
        Keyboard.0044=0A=
        Keyboard.0045=0A=
        Keyboard.0046=0A=
        Keyboard.0047=0A=
        Keyboard.0048=0A=
        Keyboard.0049=0A=
        Keyboard.004a=0A=
        Keyboard.004b=0A=
        Keyboard.004c=0A=
        Keyboard.004d=0A=
        Keyboard.004e=0A=
        Keyboard.004f=0A=
        Keyboard.0050=0A=
        Keyboard.0051=0A=
        Keyboard.0052=0A=
        Keyboard.0053=0A=
        Keyboard.0054=0A=
        Keyboard.0055=0A=
        Keyboard.0056=0A=
        Keyboard.0057=0A=
        Keyboard.0058=0A=
        Keyboard.0059=0A=
        Keyboard.005a=0A=
        Keyboard.005b=0A=
        Keyboard.005c=0A=
        Keyboard.005d=0A=
        Keyboard.005e=0A=
        Keyboard.005f=0A=
        Keyboard.0060=0A=
        Keyboard.0061=0A=
        Keyboard.0062=0A=
        Keyboard.0063=0A=
        Keyboard.0064=0A=
        Keyboard.0065=0A=
        Keyboard.0066=0A=
        Keyboard.0067=0A=
        Keyboard.0068=0A=
        Keyboard.0069=0A=
        Keyboard.006a=0A=
        Keyboard.006b=0A=
        Keyboard.006c=0A=
        Keyboard.006d=0A=
        Keyboard.006e=0A=
        Keyboard.006f=0A=
        Keyboard.0070=0A=
        Keyboard.0071=0A=
        Keyboard.0072=0A=
        Keyboard.0073=0A=
        Keyboard.0074=0A=
        Keyboard.0075=0A=
        Keyboard.0076=0A=
        Keyboard.0077=0A=
        Keyboard.0078=0A=
        Keyboard.0079=0A=
        Keyboard.007a=0A=
        Keyboard.007b=0A=
        Keyboard.007c=0A=
        Keyboard.007d=0A=
        Keyboard.007e=0A=
        Keyboard.007f=0A=
        Keyboard.0080=0A=
        Keyboard.0081=0A=
        Keyboard.0082=0A=
        Keyboard.0083=0A=
        Keyboard.0084=0A=
        Keyboard.0085=0A=
        Keyboard.0086=0A=
        Keyboard.0087=0A=
        Keyboard.0088=0A=
        Keyboard.0089=0A=
        Keyboard.008a=0A=
        Keyboard.008b=0A=
        Keyboard.008c=0A=
        Keyboard.008d=0A=
        Keyboard.008e=0A=
        Keyboard.008f=0A=
        Keyboard.0090=0A=
        Keyboard.0091=0A=
        Keyboard.0092=0A=
        Keyboard.0093=0A=
        Keyboard.0094=0A=
        Keyboard.0095=0A=
        Keyboard.0096=0A=
        Keyboard.0097=0A=
        Keyboard.0098=0A=
        Keyboard.0099=0A=
        Keyboard.009a=0A=
        Keyboard.009b=0A=
        Keyboard.009c=0A=
        Keyboard.009d=0A=
        Keyboard.009e=0A=
        Keyboard.009f=0A=
        Keyboard.00a0=0A=
        Keyboard.00a1=0A=
        Keyboard.00a2=0A=
        Keyboard.00a3=0A=
        Keyboard.00a4=0A=
        Keyboard.00a5=0A=
        Keyboard.00a6=0A=
        Keyboard.00a7=0A=
        Keyboard.00a8=0A=
        Keyboard.00a9=0A=
        Keyboard.00aa=0A=
        Keyboard.00ab=0A=
        Keyboard.00ac=0A=
        Keyboard.00ad=0A=
        Keyboard.00ae=0A=
        Keyboard.00af=0A=
        Keyboard.00b0=0A=
        Keyboard.00b1=0A=
        Keyboard.00b2=0A=
        Keyboard.00b3=0A=
        Keyboard.00b4=0A=
        Keyboard.00b5=0A=
        Keyboard.00b6=0A=
        Keyboard.00b7=0A=
        Keyboard.00b8=0A=
        Keyboard.00b9=0A=
        Keyboard.00ba=0A=
        Keyboard.00bb=0A=
        Keyboard.00bc=0A=
        Keyboard.00bd=0A=
        Keyboard.00be=0A=
        Keyboard.00bf=0A=
        Keyboard.00c0=0A=
        Keyboard.00c1=0A=
        Keyboard.00c2=0A=
        Keyboard.00c3=0A=
        Keyboard.00c4=0A=
        Keyboard.00c5=0A=
        Keyboard.00c6=0A=
        Keyboard.00c7=0A=
        Keyboard.00c8=0A=
        Keyboard.00c9=0A=
        Keyboard.00ca=0A=
        Keyboard.00cb=0A=
        Keyboard.00cc=0A=
        Keyboard.00cd=0A=
        Keyboard.00ce=0A=
        Keyboard.00cf=0A=
        Keyboard.00d0=0A=
        Keyboard.00d1=0A=
        Keyboard.00d2=0A=
        Keyboard.00d3=0A=
        Keyboard.00d4=0A=
        Keyboard.00d5=0A=
        Keyboard.00d6=0A=
        Keyboard.00d7=0A=
        Keyboard.00d8=0A=
        Keyboard.00d9=0A=
        Keyboard.00da=0A=
        Keyboard.00db=0A=
        Keyboard.00dc=0A=
        Keyboard.00dd=0A=
        Keyboard.00de=0A=
        Keyboard.00df=0A=
        Keyboard.00e0=0A=
        Keyboard.00e1=0A=
        Keyboard.00e2=0A=
        Keyboard.00e3=0A=
        Keyboard.00e4=0A=
        Keyboard.00e5=0A=
        Keyboard.00e6=0A=
        Keyboard.00e7=0A=
        Keyboard.00e8=0A=
        Keyboard.00e9=0A=
        Keyboard.00ea=0A=
        Keyboard.00eb=0A=
        Keyboard.00ec=0A=
        Keyboard.00ed=0A=
        Keyboard.00ee=0A=
        Keyboard.00ef=0A=
        Keyboard.00f0=0A=
        Keyboard.00f1=0A=
        Keyboard.00f2=0A=
        Keyboard.00f3=0A=
        Keyboard.00f4=0A=
        Keyboard.00f5=0A=
        Keyboard.00f6=0A=
        Keyboard.00f7=0A=
        Keyboard.00f8=0A=
        Keyboard.00f9=0A=
        Keyboard.00fa=0A=
        Keyboard.00fb=0A=
        Keyboard.00fc=0A=
        Keyboard.00fd=0A=
        Keyboard.00fe=0A=
        Keyboard.00ff=0A=
      Logical Minimum(0)=0A=
      Logical Maximum(255)=0A=
      Report Size(8)=0A=
      Report Count(6)=0A=
      Report Offset(8)=0A=
      Flags( Array Absolute )=0A=
  INPUT(2)[INPUT]=0A=
    Field(0)=0A=
      Usage(8)=0A=
        GenericDesktop.0081=0A=
        GenericDesktop.0082=0A=
        GenericDesktop.0083=0A=
        GenericDesktop.0084=0A=
        GenericDesktop.0085=0A=
        GenericDesktop.0086=0A=
        GenericDesktop.0087=0A=
        GenericDesktop.0088=0A=
      Logical Minimum(0)=0A=
      Logical Maximum(1)=0A=
      Report Size(1)=0A=
      Report Count(8)=0A=
      Report Offset(0)=0A=
      Flags( Variable Absolute )=0A=
  INPUT(1)[INPUT]=0A=
    Field(0)=0A=
      Usage(573)=0A=
        Hotkey.Digitizers=0A=
        Hotkey.0001=0A=
        Hotkey.0002=0A=
        Hotkey.0003=0A=
        Hotkey.0004=0A=
        Hotkey.0005=0A=
        Hotkey.0006=0A=
        Hotkey.0007=0A=
        Hotkey.0008=0A=
        Hotkey.0009=0A=
        Hotkey.000a=0A=
        Hotkey.000b=0A=
        Hotkey.000c=0A=
        Hotkey.000d=0A=
        Hotkey.000e=0A=
        Hotkey.000f=0A=
        Hotkey.0010=0A=
        Hotkey.0011=0A=
        Hotkey.0012=0A=
        Hotkey.0013=0A=
        Hotkey.0014=0A=
        Hotkey.0015=0A=
        Hotkey.0016=0A=
        Hotkey.0017=0A=
        Hotkey.0018=0A=
        Hotkey.0019=0A=
        Hotkey.001a=0A=
        Hotkey.001b=0A=
        Hotkey.001c=0A=
        Hotkey.001d=0A=
        Hotkey.001e=0A=
        Hotkey.001f=0A=
        Hotkey.0020=0A=
        Hotkey.0021=0A=
        Hotkey.0022=0A=
        Hotkey.0023=0A=
        Hotkey.0024=0A=
        Hotkey.0025=0A=
        Hotkey.0026=0A=
        Hotkey.0027=0A=
        Hotkey.0028=0A=
        Hotkey.0029=0A=
        Hotkey.002a=0A=
        Hotkey.002b=0A=
        Hotkey.002c=0A=
        Hotkey.002d=0A=
        Hotkey.002e=0A=
        Hotkey.002f=0A=
        Hotkey.0030=0A=
        Hotkey.0031=0A=
        Hotkey.0032=0A=
        Hotkey.0033=0A=
        Hotkey.0034=0A=
        Hotkey.0035=0A=
        Hotkey.0036=0A=
        Hotkey.0037=0A=
        Hotkey.0038=0A=
        Hotkey.0039=0A=
        Hotkey.003a=0A=
        Hotkey.003b=0A=
        Hotkey.003c=0A=
        Hotkey.003d=0A=
        Hotkey.003e=0A=
        Hotkey.003f=0A=
        Hotkey.0040=0A=
        Hotkey.0041=0A=
        Hotkey.0042=0A=
        Hotkey.0043=0A=
        Hotkey.0044=0A=
        Hotkey.0045=0A=
        Hotkey.0046=0A=
        Hotkey.0047=0A=
        Hotkey.0048=0A=
        Hotkey.0049=0A=
        Hotkey.004a=0A=
        Hotkey.004b=0A=
        Hotkey.004c=0A=
        Hotkey.004d=0A=
        Hotkey.004e=0A=
        Hotkey.004f=0A=
        Hotkey.0050=0A=
        Hotkey.0051=0A=
        Hotkey.0052=0A=
        Hotkey.0053=0A=
        Hotkey.0054=0A=
        Hotkey.0055=0A=
        Hotkey.0056=0A=
        Hotkey.0057=0A=
        Hotkey.0058=0A=
        Hotkey.0059=0A=
        Hotkey.005a=0A=
        Hotkey.005b=0A=
        Hotkey.005c=0A=
        Hotkey.005d=0A=
        Hotkey.005e=0A=
        Hotkey.005f=0A=
        Hotkey.0060=0A=
        Hotkey.0061=0A=
        Hotkey.0062=0A=
        Hotkey.0063=0A=
        Hotkey.0064=0A=
        Hotkey.0065=0A=
        Hotkey.0066=0A=
        Hotkey.0067=0A=
        Hotkey.0068=0A=
        Hotkey.0069=0A=
        Hotkey.006a=0A=
        Hotkey.006b=0A=
        Hotkey.006c=0A=
        Hotkey.006d=0A=
        Hotkey.006e=0A=
        Hotkey.006f=0A=
        Hotkey.0070=0A=
        Hotkey.0071=0A=
        Hotkey.0072=0A=
        Hotkey.0073=0A=
        Hotkey.0074=0A=
        Hotkey.0075=0A=
        Hotkey.0076=0A=
        Hotkey.0077=0A=
        Hotkey.0078=0A=
        Hotkey.0079=0A=
        Hotkey.007a=0A=
        Hotkey.007b=0A=
        Hotkey.007c=0A=
        Hotkey.007d=0A=
        Hotkey.007e=0A=
        Hotkey.007f=0A=
        Hotkey.0080=0A=
        Hotkey.0081=0A=
        Hotkey.0082=0A=
        Hotkey.0083=0A=
        Hotkey.0084=0A=
        Hotkey.0085=0A=
        Hotkey.0086=0A=
        Hotkey.0087=0A=
        Hotkey.0088=0A=
        Hotkey.0089=0A=
        Hotkey.008a=0A=
        Hotkey.008b=0A=
        Hotkey.008c=0A=
        Hotkey.008d=0A=
        Hotkey.008e=0A=
        Hotkey.008f=0A=
        Hotkey.0090=0A=
        Hotkey.0091=0A=
        Hotkey.0092=0A=
        Hotkey.0093=0A=
        Hotkey.0094=0A=
        Hotkey.0095=0A=
        Hotkey.0096=0A=
        Hotkey.0097=0A=
        Hotkey.0098=0A=
        Hotkey.0099=0A=
        Hotkey.009a=0A=
        Hotkey.009b=0A=
        Hotkey.009c=0A=
        Hotkey.009d=0A=
        Hotkey.009e=0A=
        Hotkey.009f=0A=
        Hotkey.00a0=0A=
        Hotkey.00a1=0A=
        Hotkey.00a2=0A=
        Hotkey.00a3=0A=
        Hotkey.00a4=0A=
        Hotkey.00a5=0A=
        Hotkey.00a6=0A=
        Hotkey.00a7=0A=
        Hotkey.00a8=0A=
        Hotkey.00a9=0A=
        Hotkey.00aa=0A=
        Hotkey.00ab=0A=
        Hotkey.00ac=0A=
        Hotkey.00ad=0A=
        Hotkey.00ae=0A=
        Hotkey.00af=0A=
        Hotkey.00b0=0A=
        Hotkey.00b1=0A=
        Hotkey.00b2=0A=
        Hotkey.00b3=0A=
        Hotkey.00b4=0A=
        Hotkey.00b5=0A=
        Hotkey.00b6=0A=
        Hotkey.00b7=0A=
        Hotkey.00b8=0A=
        Hotkey.00b9=0A=
        Hotkey.00ba=0A=
        Hotkey.00bb=0A=
        Hotkey.00bc=0A=
        Hotkey.00bd=0A=
        Hotkey.00be=0A=
        Hotkey.00bf=0A=
        Hotkey.00c0=0A=
        Hotkey.00c1=0A=
        Hotkey.00c2=0A=
        Hotkey.00c3=0A=
        Hotkey.00c4=0A=
        Hotkey.00c5=0A=
        Hotkey.00c6=0A=
        Hotkey.00c7=0A=
        Hotkey.00c8=0A=
        Hotkey.00c9=0A=
        Hotkey.00ca=0A=
        Hotkey.00cb=0A=
        Hotkey.00cc=0A=
        Hotkey.00cd=0A=
        Hotkey.00ce=0A=
        Hotkey.00cf=0A=
        Hotkey.00d0=0A=
        Hotkey.00d1=0A=
        Hotkey.00d2=0A=
        Hotkey.00d3=0A=
        Hotkey.00d4=0A=
        Hotkey.00d5=0A=
        Hotkey.00d6=0A=
        Hotkey.00d7=0A=
        Hotkey.00d8=0A=
        Hotkey.00d9=0A=
        Hotkey.00da=0A=
        Hotkey.00db=0A=
        Hotkey.00dc=0A=
        Hotkey.00dd=0A=
        Hotkey.00de=0A=
        Hotkey.00df=0A=
        Hotkey.00e0=0A=
        Hotkey.00e1=0A=
        Hotkey.00e2=0A=
        Hotkey.00e3=0A=
        Hotkey.00e4=0A=
        Hotkey.00e5=0A=
        Hotkey.00e6=0A=
        Hotkey.00e7=0A=
        Hotkey.00e8=0A=
        Hotkey.00e9=0A=
        Hotkey.00ea=0A=
        Hotkey.00eb=0A=
        Hotkey.00ec=0A=
        Hotkey.00ed=0A=
        Hotkey.00ee=0A=
        Hotkey.00ef=0A=
        Hotkey.00f0=0A=
        Hotkey.00f1=0A=
        Hotkey.00f2=0A=
        Hotkey.00f3=0A=
        Hotkey.00f4=0A=
        Hotkey.00f5=0A=
        Hotkey.00f6=0A=
        Hotkey.00f7=0A=
        Hotkey.00f8=0A=
        Hotkey.00f9=0A=
        Hotkey.00fa=0A=
        Hotkey.00fb=0A=
        Hotkey.00fc=0A=
        Hotkey.00fd=0A=
        Hotkey.00fe=0A=
        Hotkey.00ff=0A=
        Hotkey.0100=0A=
        Hotkey.0101=0A=
        Hotkey.0102=0A=
        Hotkey.0103=0A=
        Hotkey.0104=0A=
        Hotkey.0105=0A=
        Hotkey.0106=0A=
        Hotkey.0107=0A=
        Hotkey.0108=0A=
        Hotkey.0109=0A=
        Hotkey.010a=0A=
        Hotkey.010b=0A=
        Hotkey.010c=0A=
        Hotkey.010d=0A=
        Hotkey.010e=0A=
        Hotkey.010f=0A=
        Hotkey.0110=0A=
        Hotkey.0111=0A=
        Hotkey.0112=0A=
        Hotkey.0113=0A=
        Hotkey.0114=0A=
        Hotkey.0115=0A=
        Hotkey.0116=0A=
        Hotkey.0117=0A=
        Hotkey.0118=0A=
        Hotkey.0119=0A=
        Hotkey.011a=0A=
        Hotkey.011b=0A=
        Hotkey.011c=0A=
        Hotkey.011d=0A=
        Hotkey.011e=0A=
        Hotkey.011f=0A=
        Hotkey.0120=0A=
        Hotkey.0121=0A=
        Hotkey.0122=0A=
        Hotkey.0123=0A=
        Hotkey.0124=0A=
        Hotkey.0125=0A=
        Hotkey.0126=0A=
        Hotkey.0127=0A=
        Hotkey.0128=0A=
        Hotkey.0129=0A=
        Hotkey.012a=0A=
        Hotkey.012b=0A=
        Hotkey.012c=0A=
        Hotkey.012d=0A=
        Hotkey.012e=0A=
        Hotkey.012f=0A=
        Hotkey.0130=0A=
        Hotkey.0131=0A=
        Hotkey.0132=0A=
        Hotkey.0133=0A=
        Hotkey.0134=0A=
        Hotkey.0135=0A=
        Hotkey.0136=0A=
        Hotkey.0137=0A=
        Hotkey.0138=0A=
        Hotkey.0139=0A=
        Hotkey.013a=0A=
        Hotkey.013b=0A=
        Hotkey.013c=0A=
        Hotkey.013d=0A=
        Hotkey.013e=0A=
        Hotkey.013f=0A=
        Hotkey.0140=0A=
        Hotkey.0141=0A=
        Hotkey.0142=0A=
        Hotkey.0143=0A=
        Hotkey.0144=0A=
        Hotkey.0145=0A=
        Hotkey.0146=0A=
        Hotkey.0147=0A=
        Hotkey.0148=0A=
        Hotkey.0149=0A=
        Hotkey.014a=0A=
        Hotkey.014b=0A=
        Hotkey.014c=0A=
        Hotkey.014d=0A=
        Hotkey.014e=0A=
        Hotkey.014f=0A=
        Hotkey.0150=0A=
        Hotkey.0151=0A=
        Hotkey.0152=0A=
        Hotkey.0153=0A=
        Hotkey.0154=0A=
        Hotkey.0155=0A=
        Hotkey.0156=0A=
        Hotkey.0157=0A=
        Hotkey.0158=0A=
        Hotkey.0159=0A=
        Hotkey.015a=0A=
        Hotkey.015b=0A=
        Hotkey.015c=0A=
        Hotkey.015d=0A=
        Hotkey.015e=0A=
        Hotkey.015f=0A=
        Hotkey.0160=0A=
        Hotkey.0161=0A=
        Hotkey.0162=0A=
        Hotkey.0163=0A=
        Hotkey.0164=0A=
        Hotkey.0165=0A=
        Hotkey.0166=0A=
        Hotkey.0167=0A=
        Hotkey.0168=0A=
        Hotkey.0169=0A=
        Hotkey.016a=0A=
        Hotkey.016b=0A=
        Hotkey.016c=0A=
        Hotkey.016d=0A=
        Hotkey.016e=0A=
        Hotkey.016f=0A=
        Hotkey.0170=0A=
        Hotkey.0171=0A=
        Hotkey.0172=0A=
        Hotkey.0173=0A=
        Hotkey.0174=0A=
        Hotkey.0175=0A=
        Hotkey.0176=0A=
        Hotkey.0177=0A=
        Hotkey.0178=0A=
        Hotkey.0179=0A=
        Hotkey.017a=0A=
        Hotkey.017b=0A=
        Hotkey.017c=0A=
        Hotkey.017d=0A=
        Hotkey.017e=0A=
        Hotkey.017f=0A=
        Hotkey.0180=0A=
        Hotkey.0181=0A=
        Hotkey.0182=0A=
        Hotkey.0183=0A=
        Hotkey.0184=0A=
        Hotkey.0185=0A=
        Hotkey.0186=0A=
        Hotkey.0187=0A=
        Hotkey.0188=0A=
        Hotkey.0189=0A=
        Hotkey.018a=0A=
        Hotkey.018b=0A=
        Hotkey.018c=0A=
        Hotkey.018d=0A=
        Hotkey.018e=0A=
        Hotkey.018f=0A=
        Hotkey.0190=0A=
        Hotkey.0191=0A=
        Hotkey.0192=0A=
        Hotkey.0193=0A=
        Hotkey.0194=0A=
        Hotkey.0195=0A=
        Hotkey.0196=0A=
        Hotkey.0197=0A=
        Hotkey.0198=0A=
        Hotkey.0199=0A=
        Hotkey.019a=0A=
        Hotkey.019b=0A=
        Hotkey.019c=0A=
        Hotkey.019d=0A=
        Hotkey.019e=0A=
        Hotkey.019f=0A=
        Hotkey.01a0=0A=
        Hotkey.01a1=0A=
        Hotkey.01a2=0A=
        Hotkey.01a3=0A=
        Hotkey.01a4=0A=
        Hotkey.01a5=0A=
        Hotkey.01a6=0A=
        Hotkey.01a7=0A=
        Hotkey.01a8=0A=
        Hotkey.01a9=0A=
        Hotkey.01aa=0A=
        Hotkey.01ab=0A=
        Hotkey.01ac=0A=
        Hotkey.01ad=0A=
        Hotkey.01ae=0A=
        Hotkey.01af=0A=
        Hotkey.01b0=0A=
        Hotkey.01b1=0A=
        Hotkey.01b2=0A=
        Hotkey.01b3=0A=
        Hotkey.01b4=0A=
        Hotkey.01b5=0A=
        Hotkey.01b6=0A=
        Hotkey.01b7=0A=
        Hotkey.01b8=0A=
        Hotkey.01b9=0A=
        Hotkey.01ba=0A=
        Hotkey.01bb=0A=
        Hotkey.01bc=0A=
        Hotkey.01bd=0A=
        Hotkey.01be=0A=
        Hotkey.01bf=0A=
        Hotkey.01c0=0A=
        Hotkey.01c1=0A=
        Hotkey.01c2=0A=
        Hotkey.01c3=0A=
        Hotkey.01c4=0A=
        Hotkey.01c5=0A=
        Hotkey.01c6=0A=
        Hotkey.01c7=0A=
        Hotkey.01c8=0A=
        Hotkey.01c9=0A=
        Hotkey.01ca=0A=
        Hotkey.01cb=0A=
        Hotkey.01cc=0A=
        Hotkey.01cd=0A=
        Hotkey.01ce=0A=
        Hotkey.01cf=0A=
        Hotkey.01d0=0A=
        Hotkey.01d1=0A=
        Hotkey.01d2=0A=
        Hotkey.01d3=0A=
        Hotkey.01d4=0A=
        Hotkey.01d5=0A=
        Hotkey.01d6=0A=
        Hotkey.01d7=0A=
        Hotkey.01d8=0A=
        Hotkey.01d9=0A=
        Hotkey.01da=0A=
        Hotkey.01db=0A=
        Hotkey.01dc=0A=
        Hotkey.01dd=0A=
        Hotkey.01de=0A=
        Hotkey.01df=0A=
        Hotkey.01e0=0A=
        Hotkey.01e1=0A=
        Hotkey.01e2=0A=
        Hotkey.01e3=0A=
        Hotkey.01e4=0A=
        Hotkey.01e5=0A=
        Hotkey.01e6=0A=
        Hotkey.01e7=0A=
        Hotkey.01e8=0A=
        Hotkey.01e9=0A=
        Hotkey.01ea=0A=
        Hotkey.01eb=0A=
        Hotkey.01ec=0A=
        Hotkey.01ed=0A=
        Hotkey.01ee=0A=
        Hotkey.01ef=0A=
        Hotkey.01f0=0A=
        Hotkey.01f1=0A=
        Hotkey.01f2=0A=
        Hotkey.01f3=0A=
        Hotkey.01f4=0A=
        Hotkey.01f5=0A=
        Hotkey.01f6=0A=
        Hotkey.01f7=0A=
        Hotkey.01f8=0A=
        Hotkey.01f9=0A=
        Hotkey.01fa=0A=
        Hotkey.01fb=0A=
        Hotkey.01fc=0A=
        Hotkey.01fd=0A=
        Hotkey.01fe=0A=
        Hotkey.01ff=0A=
        Hotkey.0200=0A=
        Hotkey.0201=0A=
        Hotkey.0202=0A=
        Hotkey.0203=0A=
        Hotkey.0204=0A=
        Hotkey.0205=0A=
        Hotkey.0206=0A=
        Hotkey.0207=0A=
        Hotkey.0208=0A=
        Hotkey.0209=0A=
        Hotkey.020a=0A=
        Hotkey.020b=0A=
        Hotkey.020c=0A=
        Hotkey.020d=0A=
        Hotkey.020e=0A=
        Hotkey.020f=0A=
        Hotkey.0210=0A=
        Hotkey.0211=0A=
        Hotkey.0212=0A=
        Hotkey.0213=0A=
        Hotkey.0214=0A=
        Hotkey.0215=0A=
        Hotkey.0216=0A=
        Hotkey.0217=0A=
        Hotkey.0218=0A=
        Hotkey.0219=0A=
        Hotkey.021a=0A=
        Hotkey.021b=0A=
        Hotkey.021c=0A=
        Hotkey.021d=0A=
        Hotkey.021e=0A=
        Hotkey.021f=0A=
        Hotkey.0220=0A=
        Hotkey.0221=0A=
        Hotkey.0222=0A=
        Hotkey.0223=0A=
        Hotkey.0224=0A=
        Hotkey.0225=0A=
        Hotkey.0226=0A=
        Hotkey.0227=0A=
        Hotkey.0228=0A=
        Hotkey.0229=0A=
        Hotkey.022a=0A=
        Hotkey.022b=0A=
        Hotkey.022c=0A=
        Hotkey.022d=0A=
        Hotkey.022e=0A=
        Hotkey.022f=0A=
        Hotkey.0230=0A=
        Hotkey.0231=0A=
        Hotkey.0232=0A=
        Hotkey.0233=0A=
        Hotkey.0234=0A=
        Hotkey.0235=0A=
        Hotkey.0236=0A=
        Hotkey.0237=0A=
        Hotkey.0238=0A=
        Hotkey.0239=0A=
        Hotkey.023a=0A=
        Hotkey.023b=0A=
        Hotkey.023c=0A=
      Logical Minimum(0)=0A=
      Logical Maximum(572)=0A=
      Report Size(16)=0A=
      Report Count(1)=0A=
      Report Offset(0)=0A=
      Flags( Array Absolute )=0A=
  INPUT(4)[INPUT]=0A=
    Field(0)=0A=
      Physical(GenericDesktop.0001)=0A=
      Usage(3)=0A=
        Button.0001=0A=
        Button.0002=0A=
        Button.0003=0A=
      Logical Minimum(0)=0A=
      Logical Maximum(1)=0A=
      Report Size(1)=0A=
      Report Count(3)=0A=
      Report Offset(0)=0A=
      Flags( Variable Absolute )=0A=
    Field(1)=0A=
      Physical(GenericDesktop.0001)=0A=
      Usage(1)=0A=
        Undefined.GenericDesktop=0A=
      Logical Minimum(0)=0A=
      Logical Maximum(1)=0A=
      Report Size(5)=0A=
      Report Count(1)=0A=
      Report Offset(3)=0A=
      Flags( Constant Array Absolute )=0A=
    Field(2)=0A=
      Physical(GenericDesktop.0001)=0A=
      Usage(3)=0A=
        GenericDesktop.0030=0A=
        GenericDesktop.0031=0A=
        GenericDesktop.0038=0A=
      Logical Minimum(-127)=0A=
      Logical Maximum(127)=0A=
      Report Size(8)=0A=
      Report Count(3)=0A=
      Report Offset(8)=0A=
      Flags( Variable Relative )=0A=
  OUTPUT(3)[OUTPUT]=0A=
    Field(0)=0A=
      Usage(5)=0A=
        LED.0001=0A=
        LED.0002=0A=
        LED.0003=0A=
        LED.0004=0A=
        LED.0005=0A=
      Logical Minimum(0)=0A=
      Logical Maximum(1)=0A=
      Report Size(1)=0A=
      Report Count(5)=0A=
      Report Offset(0)=0A=
      Flags( Variable Absolute )=0A=
    Field(1)=0A=
      Usage(1)=0A=
        Undefined.GenericDesktop=0A=
      Logical Minimum(0)=0A=
      Logical Maximum(1)=0A=
      Report Size(3)=0A=
      Report Count(1)=0A=
      Report Offset(5)=0A=
      Flags( Constant Array Absolute )=0A=
hid-debug: input LED.0001 =3D 1=0A=
drivers/usb/input/hid-core.c: submitting ctrl urb: Set_Report =
wValue=3D0x0203 wIndex=3D0x0000 wLength=3D2=0A=
drivers/usb/input/hid-core.c: undefined report_id 0 received=0A=
input: USB HID v1.10 Keyboard [ABBAHOME USB Keyboard] on =
usb-0000:00:1d.3-1=0A=
hid-debug: input Keyboard.0052 =3D 1=0A=
hid-debug: input Keyboard.0052 =3D 0=0A=
hid-debug: input Keyboard.0028 =3D 1=0A=
hid-debug: input Keyboard.0028 =3D 0=0A=
hid-debug: input Keyboard.0052 =3D 1=0A=
hid-debug: input Keyboard.0052 =3D 0=0A=
hid-debug: input Keyboard.002c =3D 1=0A=
hid-debug: input Keyboard.002c =3D 0=0A=
hid-debug: input Keyboard.00e1 =3D 1=0A=
hid-debug: input Keyboard.0064 =3D 1=0A=
hid-debug: input Keyboard.00e1 =3D 0=0A=
hid-debug: input Keyboard.0064 =3D 0=0A=
hid-debug: input Keyboard.002c =3D 1=0A=
hid-debug: input Keyboard.002c =3D 0=0A=
hid-debug: input Keyboard.0007 =3D 1=0A=
hid-debug: input Keyboard.0008 =3D 1=0A=
hid-debug: input Keyboard.0007 =3D 0=0A=
hid-debug: input Keyboard.0008 =3D 0=0A=
hid-debug: input Keyboard.0005 =3D 1=0A=
hid-debug: input Keyboard.0005 =3D 0=0A=
hid-debug: input Keyboard.002b =3D 1=0A=
hid-debug: input Keyboard.002b =3D 0=0A=
hid-debug: input Keyboard.0028 =3D 1=0A=

------_=_NextPart_000_01C4B212.CE742490
Content-Type: text/plain;
	name="unplug.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="unplug.txt"

hid-debug: input Keyboard.0028 =3D 0=0A=
drivers/usb/input/hid-core.c: input irq status -84 received=0A=
drivers/usb/input/hid-core.c: input irq status -84 received=0A=
usb 4-1: USB disconnect, address 3=0A=
hid-debug: input Keyboard.0052 =3D 1=0A=
hid-debug: input Keyboard.0052 =3D 0=0A=
hub 5-0:1.0: connect-debounce failed, port 8 disabled=0A=
hid-debug: input Keyboard.002a =3D 1=0A=
hid-debug: input Keyboard.002a =3D 0=0A=
hid-debug: input Keyboard.002a =3D 1=0A=
hid-debug: input Keyboard.002a =3D 0=0A=
hid-debug: input Keyboard.002a =3D 1=0A=
hid-debug: input Keyboard.002a =3D 0=0A=
hid-debug: input Keyboard.0028 =3D 1=0A=
hid-debug: input Keyboard.0028 =3D 0=0A=
hid-debug: input Keyboard.0052 =3D 1=0A=
hid-debug: input Keyboard.0052 =3D 0=0A=
hid-debug: input Keyboard.002c =3D 1=0A=
hid-debug: input Keyboard.002c =3D 0=0A=
hid-debug: input Keyboard.00e1 =3D 1=0A=
hid-debug: input Keyboard.0064 =3D 1=0A=
hid-debug: input Keyboard.00e1 =3D 0=0A=
hid-debug: input Keyboard.0064 =3D 0=0A=
hid-debug: input Keyboard.002c =3D 1=0A=
hid-debug: input Keyboard.002c =3D 0=0A=
hid-debug: input Keyboard.0018 =3D 1=0A=
hid-debug: input Keyboard.0018 =3D 0=0A=
hid-debug: input Keyboard.0011 =3D 1=0A=
hid-debug: input Keyboard.0011 =3D 0=0A=
hid-debug: input Keyboard.0013 =3D 1=0A=
hid-debug: input Keyboard.0013 =3D 0=0A=
hid-debug: input Keyboard.000f =3D 1=0A=
hid-debug: input Keyboard.000f =3D 0=0A=
hid-debug: input Keyboard.0018 =3D 1=0A=
hid-debug: input Keyboard.000c =3D 1=0A=
hid-debug: input Keyboard.0018 =3D 0=0A=
hid-debug: input Keyboard.000c =3D 0=0A=
hid-debug: input Keyboard.000a =3D 1=0A=
hid-debug: input Keyboard.000a =3D 0=0A=
hid-debug: input Keyboard.002a =3D 1=0A=
hid-debug: input Keyboard.002a =3D 0=0A=
hid-debug: input Keyboard.002a =3D 1=0A=
hid-debug: input Keyboard.002a =3D 0=0A=
hid-debug: input Keyboard.002a =3D 1=0A=
hid-debug: input Keyboard.002a =3D 0=0A=
hid-debug: input Keyboard.002a =3D 1=0A=
hid-debug: input Keyboard.002a =3D 0=0A=
hid-debug: input Keyboard.002a =3D 1=0A=
hid-debug: input Keyboard.002a =3D 0=0A=
hid-debug: input Keyboard.0013 =3D 1=0A=
hid-debug: input Keyboard.0013 =3D 0=0A=
hid-debug: input Keyboard.000f =3D 1=0A=
hid-debug: input Keyboard.000f =3D 0=0A=
hid-debug: input Keyboard.0018 =3D 1=0A=
hid-debug: input Keyboard.0018 =3D 0=0A=
hid-debug: input Keyboard.000a =3D 1=0A=
hid-debug: input Keyboard.000a =3D 0=0A=
hid-debug: input Keyboard.0037 =3D 1=0A=
hid-debug: input Keyboard.0037 =3D 0=0A=
hid-debug: input Keyboard.0017 =3D 1=0A=
hid-debug: input Keyboard.0017 =3D 0=0A=
hid-debug: input Keyboard.001b =3D 1=0A=
hid-debug: input Keyboard.001b =3D 0=0A=
hid-debug: input Keyboard.0017 =3D 1=0A=
hid-debug: input Keyboard.0017 =3D 0=0A=
hid-debug: input Keyboard.0028 =3D 1=0A=

------_=_NextPart_000_01C4B212.CE742490--
