Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130514AbQK1FBM>; Tue, 28 Nov 2000 00:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130749AbQK1FBC>; Tue, 28 Nov 2000 00:01:02 -0500
Received: from ha1.rdc2.occa.home.com ([24.2.8.66]:12250 "EHLO
        mail.rdc2.occa.home.com") by vger.kernel.org with ESMTP
        id <S130514AbQK1FAp>; Tue, 28 Nov 2000 00:00:45 -0500
Message-ID: <002501c058f4$173e5780$19211518@vnnys1.ca.home.com>
From: "Android" <android@turbosport.com>
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@transmeta.com>
In-Reply-To: <001e01c0572d$f18a6e60$19211518@vnnys1.ca.home.com>
Subject: Re: Questions about Kernel 2.4.0.?
Date: Mon, 27 Nov 2000 20:31:34 -0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
        boundary="----=_NextPart_000_0022_01C058B1.088407A0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0022_01C058B1.088407A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

----- Original Message -----=20
  From: Android=20
  To: linux-kernel@vger.kernel.org=20
  Sent: Saturday, November 25, 2000 2:20 PM
  Subject: Questions about Kernel 2.4.0.?


  1) There is a link in /lib/modules/2.4.0.11: build->/usr/src/linux
  created by the Makefile (make modules_install). What for?

  2) Lines missing from /usr/src/linux/include/asm/uaccess.h:
     #define put_user_ret(x,ptr,ret) ({ if (put_user(x,ptr)) return ret; =
})
     #define get_user_ret(x,ptr,ret) ({ if (get_user(x,ptr)) return ret; =
})
     #define __put_user_ret(x,ptr,ret) ({ if (__put_user(x,ptr)) return =
ret; })
     #define __get_user_ret(x,ptr,ret) ({ if (__get_user(x,ptr)) return =
ret; })
  Some modules will not compile without these lines included.

  3) Where are the drivers for bt878 (Video For Linux)?

  4) Some of the device special files are missing when using devfs.
  devfsd is running (loaded at the beginning of rc.S by init).
  There was no /dev/lp0 on my system, even though module lp was loaded.
  After creating this file explicitly with mknod, the printer worked.

  5) This problem is probably the fault of X11 - it doesn't repaint the =
screen properly
  after coming out of console mode. I have to switch back and forth =
several times
  before I get a proper repaint. May be related to using framebuffer =
with X.
  X crashes and locks completely when using sound. Anyone know why?

  6) When going through the bash command history (using the arrow keys)
  while in framebuffer mode, there will be a pause for about 3 seconds - =
during this time,
  the system is totally frozen until this pause has expired. Any ideas =
on this?

  7) How does one disable the display of the penguin logo when booting =
in framebuffer
  mode so that all video lines are available for text? I know this can =
be removed with setfont
  and possible fbset, but I would prefer the video display be "normal" =
from the start. Thanks.

                                       -- Ted

  P.S. Ignore the ads that follow this line - this is what happens when =
using free POP accounts.



------=_NextPart_000_0022_01C058B1.088407A0
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
<DIV>----- Original Message ----- </DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dandroid@turbosport.com=20
  href=3D"mailto:android@turbosport.com">Android</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Dlinux-kernel@vger.kernel.org=20
  =
href=3D"mailto:linux-kernel@vger.kernel.org">linux-kernel@vger.kernel.org=
</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Saturday, November 25, =
2000 2:20=20
  PM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Questions about Kernel =

  2.4.0.?</DIV>
  <DIV><FONT face=3DArial size=3D2></FONT><FONT face=3DArial =
size=3D2></FONT><FONT=20
  face=3DArial size=3D2></FONT><FONT face=3DArial =
size=3D2></FONT><BR></DIV>
  <DIV><FONT face=3DArial size=3D2>1) There is a link in =
/lib/modules/2.4.0.11:=20
  build-&gt;/usr/src/linux</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>created by the Makefile (make =
modules_install).=20
  What for?</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT><FONT face=3DArial=20
size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>2) Lines missing from=20
  /usr/src/linux/include/asm/uaccess.h:<BR>&nbsp;&nbsp; #define=20
  put_user_ret(x,ptr,ret) ({ if (put_user(x,ptr)) return ret; =
})<BR>&nbsp;&nbsp;=20
  #define get_user_ret(x,ptr,ret) ({ if (get_user(x,ptr)) return ret;=20
  })<BR>&nbsp;&nbsp; #define __put_user_ret(x,ptr,ret) ({ if =
(__put_user(x,ptr))=20
  return ret; })<BR>&nbsp;&nbsp; #define __get_user_ret(x,ptr,ret) ({ if =

  (__get_user(x,ptr)) return ret; })</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>Some modules will not compile without =
these lines=20
  included.</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>3) Where are the drivers for bt878 =
(Video For=20
  Linux)?</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>4) Some of the device special files =
are missing=20
  when using devfs.</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>devfsd is running (loaded at the =
beginning of=20
  rc.S by init).</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>There was no /dev/lp0 on my system, =
even though=20
  module lp was loaded.</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>After creating this file explicitly =
with mknod,=20
  the printer worked.</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>5) This problem is probably the fault =
of X11 - it=20
  doesn't repaint the screen properly</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>after coming out of console mode. I =
have to=20
  switch back and forth several times</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>before I get a proper repaint. May be =
related to=20
  using framebuffer with X.</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>X crashes and locks completely when =
using sound.=20
  Anyone know why?</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>6) When going through the bash =
command history=20
  (using the arrow keys)</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>while in framebuffer mode, there will =
be a pause=20
  for about 3 seconds - during this time,</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>the system is totally frozen until =
this pause has=20
  expired. Any ideas on this?</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>7) How does one disable the display =
of the=20
  penguin logo when booting in framebuffer</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>mode so that all video lines are =
available for=20
  text? I know this can be removed with setfont</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2>and possible fbset, but I would =
prefer the video=20
  display be "normal" from the start. Thanks.</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial=20
  =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
  -- Ted</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>P.S. Ignore the ads that follow this =
line - this=20
  is what happens when using free POP accounts.</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV>&nbsp;</DIV></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0022_01C058B1.088407A0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
