Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267392AbSKQLOz>; Sun, 17 Nov 2002 06:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267409AbSKQLOz>; Sun, 17 Nov 2002 06:14:55 -0500
Received: from 2-103.ctame701-2.telepar.net.br ([200.181.170.103]:26380 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267392AbSKQLOy>; Sun, 17 Nov 2002 06:14:54 -0500
Date: Sun, 17 Nov 2002 09:21:37 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] pci_hotplug_core: fix up header file cleanups
Message-ID: <20021117112137.GA28051@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@debian.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	Please pull from:

master.kernel.org:/home/acme/BK/includes-2.5

	In this tree there will be several similar changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.851, 2002-11-17 09:19:14-02:00, acme@conectiva.com.br
  Fix up after header file cleanups: add <linux/mount.h> to
  pci_hotplug_core that got it implicitly before.


 pci_hotplug_core.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Sun Nov 17 09:20:20 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Sun Nov 17 09:20:20 2002
@@ -36,6 +36,7 @@
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
+#include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/pci.h>
 #include <linux/dnotify.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.851
## Wrapped with gzip_uu ##


begin 664 bkpatch19258
M'XL(`'1[UST``^6476O;,!2&KZ-?<2"7(_8YMA1_L)2LW2<=+&3TNBBR')O:
MEK'EK`7_^"I922$+K!UC-[..9?"QCM^C]T%3N.EUETZDJC6;PF?3VW2B3*.5
M+7?24Z;V-IU+K(UQ";\PM?8OK_VR4=60Z7X6>(*Y]$I:5<!.=WTZ(2\\OK$/
MK4XGZP^?;KZ^6S.V6,!5(9NM_JXM+!;,FFXGJZQ?2EM4IO%L)YN^UO;PX_'X
MZ1@@!FX(BD(4\Y'FR*-1448D.>D,`Q[/.=OWL#S5?E*%B"),!(9BQ"1*B+T'
M\F)!@(%/Y%,$F*3D@L\P2!'A;%%X0S!#=@E_MX$KIN!C>0]#"S*WNH-"R\P]
M\K+2H"HMFZ'M4Y!9!F^KLAGN_=H,C?6*"R?$K6U5>5L8VU;#]E:93H,MI(6M
ML5"ZJ-NJ5*6M'F"C<Y?UV#40<I&PU;,K;/;*BS&4R"Z@W?M]?ANRKMR3X3])
M\T]E>NJX/P&&01B/&"+R4<H@#T449Y0'F[G*SWOQTO)[Y]V=$(X\BA)^H/'W
M:_>8_H/>V+;3V^5=9V3QJKJ)FQU+G(]<B%`<<`[$+S3C?T'S3U^_P:S[<0A'
JY^H%%O\!\U_"&(A-GX[!4_W/)Z(JM+KKAWH1)6&6B)C8(RH<TZ=Q!0``
`
end
