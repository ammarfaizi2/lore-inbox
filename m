Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKYWuK>; Sat, 25 Nov 2000 17:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129703AbQKYWuB>; Sat, 25 Nov 2000 17:50:01 -0500
Received: from ha1.rdc2.occa.home.com ([24.2.8.66]:666 "EHLO
        mail.rdc2.occa.home.com") by vger.kernel.org with ESMTP
        id <S129091AbQKYWts>; Sat, 25 Nov 2000 17:49:48 -0500
Message-ID: <001e01c0572d$f18a6e60$19211518@vnnys1.ca.home.com>
From: "Android" <android@turbosport.com>
To: <linux-kernel@vger.kernel.org>
Subject: Questions about Kernel 2.4.0.?
Date: Sat, 25 Nov 2000 14:20:39 -0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
        boundary="----=_NextPart_000_001B_01C056EA.E3259180"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_001B_01C056EA.E3259180
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

There is a link in /lib/modules/2.4.0.11: build->/usr/src/linux
created by the Makefile (make modules_install).
What for? depmod doesn't like this link. It gets confused.

Lines missing from /usr/src/linux/include/asm/uaccess.h:
   #define put_user_ret(x,ptr,ret) ({ if (put_user(x,ptr)) return ret; =
})
   #define get_user_ret(x,ptr,ret) ({ if (get_user(x,ptr)) return ret; =
})
   #define __put_user_ret(x,ptr,ret) ({ if (__put_user(x,ptr)) return =
ret; })
   #define __get_user_ret(x,ptr,ret) ({ if (__get_user(x,ptr)) return =
ret; })
Some modules will not compile without these lines included.

Where are the drivers for bt878 (Video For Linux)?

Some of the device special files are missing when using devfs.
devfsd is running (loaded at the beginning of rc.S by init).
There was no /dev/lp0 on my system, even though module lp was loaded.
After creating this file explicitly with mknod, the printer worked.

This problem is probably the fault of X11 - it doesn't repaint the =
screen properly
after coming out of console mode. I have to switch back and forth =
several times
before I get a proper repaint. May be related to using framebuffer with =
X.
X crashes and locks completely when using sound. Anyone know why?

                                     -- Ted


------=_NextPart_000_001B_01C056EA.E3259180
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
<DIV><FONT face=3DArial size=3D2>There is a link in =
/lib/modules/2.4.0.11:=20
build-&gt;/usr/src/linux</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>created by the Makefile (make=20
modules_install).<BR>What for? depmod doesn't like this link. It gets=20
confused.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Lines missing from=20
/usr/src/linux/include/asm/uaccess.h:<BR>&nbsp;&nbsp; #define=20
put_user_ret(x,ptr,ret) ({ if (put_user(x,ptr)) return ret; =
})<BR>&nbsp;&nbsp;=20
#define get_user_ret(x,ptr,ret) ({ if (get_user(x,ptr)) return ret;=20
})<BR>&nbsp;&nbsp; #define __put_user_ret(x,ptr,ret) ({ if =
(__put_user(x,ptr))=20
return ret; })<BR>&nbsp;&nbsp; #define __get_user_ret(x,ptr,ret) ({ if=20
(__get_user(x,ptr)) return ret; })</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Some modules will not compile without =
these lines=20
included.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Where are the drivers for bt878 (Video =
For=20
Linux)?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Some of the device special files are =
missing when=20
using devfs.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>devfsd is running (loaded at the =
beginning of rc.S=20
by init).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>There was no /dev/lp0 on my system, =
even though=20
module lp was loaded.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>After creating this file explicitly =
with mknod, the=20
printer worked.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>This problem is probably the fault of =
X11 - it=20
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
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
-- Ted</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_001B_01C056EA.E3259180--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
