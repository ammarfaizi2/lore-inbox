Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130614AbQL3IuJ>; Sat, 30 Dec 2000 03:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133074AbQL3It6>; Sat, 30 Dec 2000 03:49:58 -0500
Received: from photon.idirect.com ([207.136.80.123]:53198 "EHLO photon")
	by vger.kernel.org with ESMTP id <S130614AbQL3Itp>;
	Sat, 30 Dec 2000 03:49:45 -0500
Message-ID: <000c01c07239$35b48820$2d8342d8@fermat>
From: "BH" <hammock@look.ca>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.18 and joy-gravis.o
Date: Sat, 30 Dec 2000 00:19:18 -0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0009_01C071F6.26938730"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0009_01C071F6.26938730
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Is the joy-gravis module non-working in 2.2.18 ?

setup:
es1370 on a K6-2 400 / ALi 15xx board, Gravis XTerminator gamepad

I'm loading the module with joystick=3D1 to enable the gameport, and it =
shows in dmesg, loading joystick module, then when I modprobe =
joy-gravis, I get this output:

lib/modules/.../misc/joy-gravis.o: init_module: Device or resource busy
/lib/modules/.../misc/joy-gravis.o: insmod =
/lib/modules/.../misc/joy-gravis.o failed

This also happens with the emu10k1 sound card.
Before when the boot-time gameport hack was used, the gamepad module =
loaded up fine.

------=_NextPart_000_0009_01C071F6.26938730
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 5.50.4611.1300" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Is the joy-gravis module non-working in =
2.2.18=20
?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>setup:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>es1370 on a K6-2 400&nbsp;/ ALi 15xx =
board, Gravis=20
XTerminator gamepad</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm loading the module with =
joystick=3D1 to enable=20
the gameport, and it shows in dmesg, loading joystick module, then when =
I=20
modprobe joy-gravis, I get this output:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>lib/modules/.../misc/joy-gravis.o: =
init_module:=20
Device or resource busy<BR>/lib/modules/.../misc/joy-gravis.o: insmod=20
/lib/modules/.../misc/joy-gravis.o failed</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>This also happens with the emu10k1 =
sound=20
card.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Before when the boot-time gameport hack =
was used,=20
the gamepad module loaded up fine.</FONT></DIV></BODY></HTML>

------=_NextPart_000_0009_01C071F6.26938730--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
