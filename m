Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133074AbQL3JK7>; Sat, 30 Dec 2000 04:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133088AbQL3JKt>; Sat, 30 Dec 2000 04:10:49 -0500
Received: from m11.boston.juno.com ([63.211.172.74]:62615 "EHLO
	m11.boston.juno.com") by vger.kernel.org with ESMTP
	id <S133074AbQL3JKk>; Sat, 30 Dec 2000 04:10:40 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Date: Sat, 30 Dec 2000 03:33:42 -0500
Subject: [PATCH] test13-pre6  net/atm/lec.c
Message-ID: <20001230.033349.-192941.1.fdavis112@juno.com>
X-Mailer: Juno 5.0.15
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary=--__JNP_000_5510.0696.1d1b
X-Juno-Line-Breaks: 9-6,7,9-25,26-32767
From: Frank Davis <fdavis112@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.  Since your mail reader does not understand
this format, some or all of this message may not be legible.

----__JNP_000_5510.0696.1d1b
Content-Type: text/plain; charset=us-ascii  
Content-Transfer-Encoding: 7bit

Hello,
  The following patch appears to fix 2 of the 3 undefined references:
publish_netdev is still unresolved.
Regards,
Frank
--- net/atm/lec.c.old Sat Dec 30 03:08:14 2000
+++ net/atm/lec.c     Sat Dec 30 03:17:44 2000
@@ -772,10 +772,10 @@
                 size = sizeof(struct lec_priv);
 #ifdef CONFIG_TR
                 if (is_trdev)
-                        dev_lec[i] = prepare_trdev(NULL, size);
+                        dev_lec[i] = init_trdev(NULL, size);
                 else
 #endif
-                dev_lec[i] = prepare_etherdev(NULL, size);
+                dev_lec[i] = init_etherdev(NULL, size);
                 if (!dev_lec[i])
                         return -ENOMEM;
 
----__JNP_000_5510.0696.1d1b
Content-Type: text/html; charset=us-ascii  
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dwindows-1252" http-equiv=3DContent-=
Type>
<META content=3D"MSHTML 5.00.2314.1000" name=3DGENERATOR></HEAD>
<BODY bottomMargin=3D0 leftMargin=3D3 rightMargin=3D3 topMargin=3D0>
<DIV>Hello,</DIV>
<DIV>&nbsp; The following patch appears to fix 2 of the 3 undefined =
references:=20
publish_netdev is still unresolved.</DIV>
<DIV>
<P class=3DMsoPlainText><SPAN=20
style=3D"mso-fareast-font-family: 'MS Mincho'">Regards,</SPAN></P>
<P class=3DMsoPlainText><SPAN=20
style=3D"mso-fareast-font-family: 'MS Mincho'">Frank</SPAN></P>
<P class=3DMsoPlainText><SPAN style=3D"mso-fareast-font-family: 'MS Mincho'=
">---=20
net/atm/lec.c.old<SPAN style=3D"mso-tab-count: 1"> </SPAN>Sat Dec 30 03:08:=
14=20
2000<BR>+++ net/atm/lec.c<SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp=
;&nbsp;=20
</SPAN>Sat Dec 30 03:17:44 2000<BR>@@ -772,10 +772,10 @@<BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>size =3D sizeof(struct lec_priv);<BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN>#ifdef CONFIG_TR<BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>if (is_trdev)<BR>-<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;=20
</SPAN>dev_lec[i] =3D prepare_trdev(NULL, size);<BR>+<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;=20
</SPAN>dev_lec[i] =3D init_trdev(NULL, size);<BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>else<BR><SPAN style=3D"mso-spacerun: yes">&nbsp;</SPAN>#endif<BR>-<=
SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>dev_lec[i] =3D prepare_etherdev(NULL, size);<BR>+<SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>dev_lec[i] =3D init_etherdev(NULL, size);<BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>if (!dev_lec[i])<BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>return -ENOMEM;<BR><SPAN=20
style=3D"mso-spacerun: yes">&nbsp;</SPAN><BR></P></SPAN></DIV></BODY></HTML>

----__JNP_000_5510.0696.1d1b--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
