Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263475AbUJ2Uy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUJ2Uy4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbUJ2Uxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:53:30 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:21443 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263475AbUJ2Ui7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:38:59 -0400
Date: Fri, 29 Oct 2004 17:39:07 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][PL2303] add id for Siemens x65 series of mobiles
Message-ID: <20041029203906.GA7681@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.6i
X-Bogosity: No, tests=bogofilter, spamicity=0.497629, version=0.16.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

	Please consider applying this one.

Best Regards,

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.2188, 2004-10-29 16:16:29-03:00, acme@toy.ghostprotocols.net
  [PL2303] add id for Siemens x65 series of mobiles
  
  Tested with CX65 and S65 models
  
  Signed-off-by: Arnaldo Carvalho de Melo <acme@conectiva.com.br>


 pl2303.c |    1 +
 pl2303.h |    3 +++
 2 files changed, 4 insertions(+)


diff -Nru a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
--- a/drivers/usb/serial/pl2303.c	2004-10-29 17:24:01 -03:00
+++ b/drivers/usb/serial/pl2303.c	2004-10-29 17:24:01 -03:00
@@ -91,6 +91,7 @@
 	{ USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_ID) },
 	{ USB_DEVICE(SAMSUNG_VENDOR_ID, SAMSUNG_PRODUCT_ID) },
        { USB_DEVICE(PHAROS_VENDOR_ID, PHAROS_PRODUCT_ID) },
+	{ USB_DEVICE(SIEMENS_VENDOR_ID, SIEMENS_PRODUCT_ID_X65) },
 	{ }					/* Terminating entry */
 };
 
diff -Nru a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
--- a/drivers/usb/serial/pl2303.h	2004-10-29 17:24:01 -03:00
+++ b/drivers/usb/serial/pl2303.h	2004-10-29 17:24:01 -03:00
@@ -53,3 +53,6 @@
 /* Pharos / Microsoft GPS puck */
 #define PHAROS_VENDOR_ID       0x067b
 #define PHAROS_PRODUCT_ID      0xaaa0
+
+#define SIEMENS_VENDOR_ID	0x11f5
+#define SIEMENS_PRODUCT_ID_X65	0x0003

===================================================================


This BitKeeper patch contains the following changesets:
1.2188
## Wrapped with gzip_uu ##


M'XL( .&F@D$  ^566V_:,!1^QK_B2'W9M)+X$N>"1D4':$/K!4&I)G45,K$A
M$4F,DO2F9?]]#EO;=:U:AK:G)I:<'!\?G>^<[W.R Y-"Y:V&"%.%=N"3+LI6
MH]0WUB(RCZM<ESK426%EJC3+(ZW-LAWI5-GU#GNVM(OXHI@UJ>4BXS 491C!
MI<J+5H-8[,Y2WJQ4JS'J?YP<[(\0:K>A&XELH<:JA'8;E3J_%(DL.J*,$IU9
M92ZR(E6EL$*=5G>N%<68FIL3CV'N5L3%CE>%1!(B'*(DIH[O.D@L5VE'%S*Q
M=+XXNXU]_C".0S!U":<4D\IU7.:A'A"+$M\'[-@$VS0 XK;,H$$3LQ;&4"/N
M/%T;>$>AB=$'^+=(NBB$L^$!99B=@Y 28@ESG<,X5JG*"KAV.9CVQ:H /8=4
MS^)$%6:/&2>J*)6$J[B,H/O%^(E,PMC,J98J^>4TCA>9DDT]GS=G-RW8SS.3
MNX:NJ$%$&J2"0Y5H>+^&'NI,A65\N<9BS?(]]!D"EZ'A?3-1\R\OA+# : ]6
M-4V>+IK,XYI0MJ&978,5B;U*ZI)8T7T9?<<CM*)N$+"*F=XJZGG$8=(Q]N<:
M]U+TFB8!"8A+W,KQ./6VS37\/5>?!)5YHW6N 0T\.5<<2Y\QOF6NX:-<*??Y
M6FC/;*JE]S_!H$6N%IUEKD6T2< Z?T(";J:*^::7:TEZ^$]!$G<309+7*<B?
MC3^&9GZU'D9BP^<XL(5B!P$#@AK?8#+^,.WU3P?=_IOQH'_8/QI/3_M'O>/1
M=-#;A5O3<'3<FW1/C&UJ8+^%[[LO\#+:FI<;'@@H#S7K&%<NQ<4JBK/UAZ(F
MZ_DFYP&FC!!>:XQAO.8HX=MQE+U2CJX/THTY&FW#4<Z!H:]H1ZIYG"EXQ,\&
FOB9DSA\Y/&2K\<(8L_M?FS!2X;*X2-L>(5((1Z ?[X)2TD()    
 
