Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131330AbQL1WGQ>; Thu, 28 Dec 2000 17:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132027AbQL1WGG>; Thu, 28 Dec 2000 17:06:06 -0500
Received: from cambot.suite224.net ([209.176.64.2]:43023 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S131330AbQL1WGC>;
	Thu, 28 Dec 2000 17:06:02 -0500
Message-ID: <000a01c07116$a474a160$ba42b0d1@pittscomp.com>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: <linux-kernel@vger.kernel.org>
Subject: linux 2.4.0-test12 compile error
Date: Thu, 28 Dec 2000 16:39:15 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0007_01C070EC.B804F7E0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01C070EC.B804F7E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Forgive me if this question has already been answered. I am unable to =
compile 2.4.0-test12 on my system.

Linux-Mandrake 7.1=20
gcc-2.95.3 (might be a gcc snapshot)
binutils-2.10.0.33 (freshly compiled today)
modutils-2.3.23 (compiled yesterday)

the following is the message I get

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -g =
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe =
-mpreferred-stack-boundary=3D2 -march=3Di586 -c -o init/main.o =
init/main.c

In file included from /usr/src/linux/include/linux/pagemap.h:16,

from /usr/src/linux/include/linux/locks.h:8,

from /usr/src/linux/include/linux/raid/md.h:36,

from init/main.c:24:

/usr/src/linux/include/linux/highmem.h:48: macro `clear_user_page' used =
with too many (3) args

/usr/src/linux/include/linux/highmem.h:90: macro `copy_user_page' used =
with too many (4) args

make: *** [init/main.o] Error 1



the kernel I am trying to compile is linux-2.4.0-test12 with =
linux-2.4.0-test12-ia64-001214 and linux-2.4.0-test12-reiserfs-3.6.23 =
patches applied. Is there something else I need?



Matthew D. Pitts

mpitts@suite224.net


------=_NextPart_000_0007_01C070EC.B804F7E0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.2614.3500" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Forgive me if this question has already =
been=20
answered. I am unable to compile 2.4.0-test12 on my system.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Linux-Mandrake 7.1 </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>gcc-2.95.3 (might be a gcc =
snapshot)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>binutils-2.10.0.33 (freshly compiled=20
today)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>modutils-2.3.23 (compiled =
yesterday)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>the following is the message I =
get</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2>
<P align=3Dleft><FONT face=3DArial>gcc -D__KERNEL__ =
-I/usr/src/linux/include -Wall=20
-Wstrict-prototypes -g -O2 -fomit-frame-pointer -fno-strict-aliasing =
-pipe=20
-mpreferred-stack-boundary=3D2 -march=3Di586 -c -o init/main.o=20
init/main.c</FONT></P>
<P align=3Dleft><FONT face=3DArial>In file included from=20
/usr/src/linux/include/linux/pagemap.h:16,</FONT></P>
<P align=3Dleft><FONT face=3DArial>from=20
/usr/src/linux/include/linux/locks.h:8,</FONT></P>
<P align=3Dleft><FONT face=3DArial>from=20
/usr/src/linux/include/linux/raid/md.h:36,</FONT></P>
<P align=3Dleft><FONT face=3DArial>from init/main.c:24:</FONT></P>
<P align=3Dleft><FONT =
face=3DArial>/usr/src/linux/include/linux/highmem.h:48: macro=20
`clear_user_page' used with too many (3) args</FONT></P>
<P align=3Dleft><FONT =
face=3DArial>/usr/src/linux/include/linux/highmem.h:90: macro=20
`copy_user_page' used with too many (4) args</FONT></P>
<P><FONT face=3DArial>make: *** [init/main.o] Error 1</FONT></P>
<P>&nbsp;</P>
<P><FONT face=3DArial>the kernel&nbsp;I am trying to compile is =
linux-2.4.0-test12=20
with linux-2.4.0-test12-ia64-001214 and =
linux-2.4.0-test12-reiserfs-3.6.23=20
patches applied. Is there something else I need?</FONT></P>
<P>&nbsp;</P>
<P><FONT face=3DArial>Matthew D. Pitts</FONT></P>
<P><FONT face=3DArial><A=20
href=3D"mailto:mpitts@suite224.net">mpitts@suite224.net</A></FONT></P></F=
ONT></DIV></BODY></HTML>

------=_NextPart_000_0007_01C070EC.B804F7E0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
