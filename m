Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131526AbQK3FMw>; Thu, 30 Nov 2000 00:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131531AbQK3FMn>; Thu, 30 Nov 2000 00:12:43 -0500
Received: from [63.118.43.131] ([63.118.43.131]:17427 "EHLO
        receive.turbosport.com") by vger.kernel.org with ESMTP
        id <S131526AbQK3FM2>; Thu, 30 Nov 2000 00:12:28 -0500
Message-ID: <002a01c05a87$55b84b80$19211518@vnnys1.ca.home.com>
From: "Android" <android@turbosport.com>
To: <linux-kernel@vger.kernel.org>
Subject: Questions about Kernel 2.4.0.*
Date: Wed, 29 Nov 2000 20:38:02 -0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
        boundary="----=_NextPart_000_0027_01C05A44.449BA1A0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-MDRemoteIP: 63.118.43.130
X-Return-Path: android@turbosport.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0027_01C05A44.449BA1A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

1) There is a link in /lib/modules/2.4.0.11: =
build->/usr/src/linuxcreated by the Makefile (make modules_install). =
What for?

2)  (Answered)

3)  (Answered)

4) Some of the device special files are missing when using devfs.
devfsd is running (loaded at the beginning of rc.S by init).
There was no /dev/lp0 on my system, even though module lp was loaded.
After creating this file explicitly with mknod, the printer worked.

5) This problem is probably the fault of X11 - it doesn't repaint the =
screen properly
after coming out of console mode. I have to switch back and forth =
several times
before I get a proper repaint. May be related to using framebuffer with =
X.
X crashes and locks completely when using sound. Anyone know why?

6) When going through the bash command history (using the arrow keys)
while in framebuffer mode, there will be a pause for about 3 seconds - =
during this time,
the system is totally frozen until this pause has expired. Any ideas on =
this?
I know this is a problem with bash - this problem doesn't occur when =
using tcsh.

7) How does one disable the display of the penguin logo when booting in =
framebuffer
mode so that all video lines are available for text? I know this can be =
removed with setfont
and possible fbset, but I would prefer the video display be "normal" =
from the start. Thanks.

                                     -- Ted



******
Free web-based/POP3 mail from turbosport.com, turbomail.tv, mailplanet.net, and webmailcity.com
******
To report SPAM mail please send an e-mail to spam@turbosport.com.

------=_NextPart_000_0027_01C05A44.449BA1A0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 5.50.4134.100" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>1) There is a link in =
/lib/modules/2.4.0.11:=20
build-&gt;/usr/src/linux</FONT><FONT face=3DArial size=3D2>created by =
the Makefile=20
(make modules_install). What for?</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>2)&nbsp; (Answered)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>3)&nbsp; (Answered)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>4) Some of the device special files are =
missing=20
when using devfs.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>devfsd is running (loaded at the =
beginning of rc.S=20
by init).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>There was no /dev/lp0 on my system, =
even though=20
module lp was loaded.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>After creating this file explicitly =
with mknod, the=20
printer worked.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>5) This problem is probably the fault =
of X11 - it=20
doesn't repaint the screen properly</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>after coming out of console mode. I =
have to switch=20
back and forth several times</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>before I get a proper repaint. May be =
related to=20
using framebuffer with X.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>X crashes and locks completely when =
using sound.=20
Anyone know why?</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>6) When going through the bash command =
history=20
(using the arrow keys)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>while in framebuffer mode, there will =
be a pause=20
for about 3 seconds - during this time,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>the system is totally frozen until this =
pause has=20
expired. Any ideas on this?</FONT></DIV>
<DIV>I know this is a problem with bash - this problem doesn't occur =
when using=20
tcsh.</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>7) How does one disable the display of =
the penguin=20
logo when booting in framebuffer</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>mode so that all video lines are =
available for=20
text? I know this can be removed with setfont</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>and possible fbset, but I would prefer =
the video=20
display be "normal" from the start. Thanks.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
-- Ted</FONT></DIV>
<DIV>&nbsp;</DIV></FONT></DIV>
<BR>
******<BR>
Free web-based/POP3 mail from turbosport.com, turbomail.tv, mailplanet.net, and webmailcity.com<BR>
******<BR>
To report SPAM mail please send an e-mail to spam@turbosport.com.<BR>
</BODY></HTML>

------=_NextPart_000_0027_01C05A44.449BA1A0--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
