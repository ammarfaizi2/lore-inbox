Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129738AbQLKEfl>; Sun, 10 Dec 2000 23:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129866AbQLKEfc>; Sun, 10 Dec 2000 23:35:32 -0500
Received: from web1.clubnet.net ([206.126.128.3]:64777 "EHLO web1.clubnet.net")
	by vger.kernel.org with ESMTP id <S129738AbQLKEfS>;
	Sun, 10 Dec 2000 23:35:18 -0500
Message-ID: <012001c06327$8ed6f3a0$338d7ece@snowline.net>
From: "Eddy" <edmc@snowline.net>
To: <apm@linuxcare.com.au>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: APM-Bios Hang at Boot-up 2.2.16 2.2.17 2.2.18pre26
Date: Sun, 10 Dec 2000 20:05:09 -0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_011D_01C062E4.7F6D29E0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_011D_01C062E4.7F6D29E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I can't seem to get my A&T 486 to boot-up. If I disable APM from the =
above kernels my computer resets and re-boots automatically immediately =
following the kernel message "Ok booting the kernel"=20

With APM enabled in the kernel config the system boots and gets to the =
kernel message.=20
ne.c:v1.10 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)
NE*000 ethercard probe at 0x280: 00:40:05:3f:20:d6
eth0: NE2000 found at 0x280, using IRQ 9.
_
and then hangs.

Probing with magic-sysreq-P led me to APM-Code.

After turning on APM_DEBUG in arch/i386/kernel/apm.c I now get the =
continuous message=20
"apm: received normal resume notify"

How can I get around this. I've tried different APM-BIOS settings and =
different kernel configurations to no avail. I really don't understand =
what is really going on here to be able to fix it.

I have 66Mhz Intel-486-D2 with AMIBIOS Date 12/15/93
AMIBIOS 1993 release 07/08/1994
40-E300-001473-00111111-GREEN-H
Rom Label =3D AI.8-1 AB7130565

------=_NextPart_000_011D_01C062E4.7F6D29E0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 5.50.4207.2601" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DTerminal size=3D2>I can't seem to get my A&amp;T 486 =
to boot-up.=20
If I disable APM from the above kernels my computer resets and re-boots=20
automatically immediately following the kernel message "Ok booting the =
kernel"=20
</FONT></DIV>
<DIV><FONT face=3DTerminal size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DTerminal size=3D2>With APM enabled in the kernel =
config the system=20
boots and gets to the kernel message. </FONT></DIV>
<DIV><FONT face=3DTerminal size=3D2><FONT face=3DArial>ne.c:v1.10 =
9/23/94 Donald=20
Becker (</FONT><A href=3D"mailto:becker@cesdis.gsfc.nasa.gov"><FONT=20
face=3DArial>becker@cesdis.gsfc.nasa.gov</FONT></A><FONT =
face=3DArial>)<BR>NE*000=20
ethercard probe at 0x280: 00:40:05:3f:20:d6</FONT></FONT></DIV>
<DIV><FONT face=3DTerminal size=3D2><FONT face=3DArial>eth0: NE2000 =
found at 0x280,=20
using IRQ 9.<BR>_</FONT></FONT></DIV>
<DIV><FONT face=3DTerminal size=3D2>and then hangs.</FONT></DIV>
<DIV><FONT face=3DTerminal size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DTerminal size=3D2>Probing with magic-sysreq-P led me =
to=20
APM-Code.</FONT></DIV>
<DIV><FONT face=3DTerminal size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DTerminal size=3D2>After turning on APM_DEBUG in=20
arch/i386/kernel/apm.c I now get the continuous message </FONT></DIV>
<DIV><FONT face=3DTerminal size=3D2>"apm: received normal resume=20
notify"</FONT></DIV>
<DIV><FONT face=3DTerminal size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DTerminal size=3D2>How can I get around this. I've =
tried different=20
APM-BIOS settings and different kernel configurations to no avail. I =
really=20
don't understand what is really going on here to be able to fix =
it.</FONT></DIV>
<DIV><FONT face=3DTerminal size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DTerminal size=3D2>I have 66Mhz Intel-486-D2 with =
AMIBIOS Date=20
12/15/93</FONT></DIV>
<DIV><FONT face=3DTerminal size=3D2>AMIBIOS 1993 release =
07/08/1994</FONT></DIV>
<DIV><FONT face=3DTerminal =
size=3D2>40-E300-001473-00111111-GREEN-H</FONT></DIV>
<DIV><FONT face=3DTerminal size=3D2>Rom Label =3D AI.8-1=20
AB7130565</FONT></DIV></BODY></HTML>

------=_NextPart_000_011D_01C062E4.7F6D29E0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
