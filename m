Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130164AbRAKFgf>; Thu, 11 Jan 2001 00:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131949AbRAKFgZ>; Thu, 11 Jan 2001 00:36:25 -0500
Received: from m11.boston.juno.com ([63.211.172.74]:12983 "EHLO
	m11.boston.juno.com") by vger.kernel.org with ESMTP
	id <S131066AbRAKFgM>; Thu, 11 Jan 2001 00:36:12 -0500
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Date: Thu, 11 Jan 2001 00:28:28 -0500
Subject: 2.4.0-ac6: mm/vmalloc.c compile error
Message-ID: <20010111.002835.-160337.1.fdavis112@juno.com>
X-Mailer: Juno 5.0.15
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary=--__JNP_000_06e5.0bc1.6bf3
X-Juno-Line-Breaks: 9-6,7,11-23,24-32767
From: Frank Davis <fdavis112@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.  Since your mail reader does not understand
this format, some or all of this message may not be legible.

----__JNP_000_06e5.0bc1.6bf3
Content-Type: text/plain; charset=us-ascii  
Content-Transfer-Encoding: 7bit

Hello,
  The following error occurred while compiling 2.4.0-ac6..The strange
thing is that I checked mm/vmalloc.c (line 188, and the entire file) and
didn't see PKMAP_BASE mentioned. My guess is that there is a problem with
one of the header files.

Regards,
Frank
 
vmalloc.c: In function `get_vm_area':
vmalloc.c:188: `PKMAP_BASE' undeclared (first use in this function)
vmalloc.c:188: (Each undeclared identifier is reported only once
vmalloc.c:188: for each function it appears in.)
make[2]: *** [vmalloc.o] Error 1
make[2]: Leaving directory `/usr/src/linux/mm'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/mm'
make: *** [_dir_mm] Error 2
----__JNP_000_06e5.0bc1.6bf3
Content-Type: text/html; charset=us-ascii  
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dwindows-1252" http-equiv=3DContent-=
Type>
<META content=3D"MSHTML 5.00.2314.1000" name=3DGENERATOR></HEAD>
<BODY bottomMargin=3D0 leftMargin=3D3 rightMargin=3D3 topMargin=3D0>
<DIV>Hello,</DIV>
<DIV>&nbsp; The following error occurred while compiling 2.4.0-ac6..The =
strange=20
thing is that I checked mm/vmalloc.c (line 188, and the entire file) and =
didn't=20
see PKMAP_BASE mentioned. My guess is that there is a problem with one of =
the=20
header files.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Regards,</DIV>
<DIV>Frank</DIV>
<DIV>&nbsp;<SPAN style=3D"mso-fareast-font-family: 'MS Mincho'"></SPAN></=
DIV>
<DIV><SPAN style=3D"mso-fareast-font-family: 'MS Mincho'">vmalloc.c: In =
function=20
`get_vm_area':<BR>vmalloc.c:188: `PKMAP_BASE' undeclared (first use in this=
=20
function)<BR>vmalloc.c:188: (Each undeclared identifier is reported only=20
once<BR>vmalloc.c:188: for each function it appears in.)<BR>make[2]: ***=20
[vmalloc.o] Error 1<BR>make[2]: Leaving directory=20
`/usr/src/linux/mm'<BR>make[1]: *** [first_rule] Error 2<BR>make[1]: =
Leaving=20
directory `/usr/src/linux/mm'<BR>make: *** [_dir_mm] Error 2<BR></DIV></=
SPAN>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

----__JNP_000_06e5.0bc1.6bf3--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
