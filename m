Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbSKRCZi>; Sun, 17 Nov 2002 21:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSKRCZi>; Sun, 17 Nov 2002 21:25:38 -0500
Received: from 2-023.ctame701-2.telepar.net.br ([200.181.170.23]:48401 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261333AbSKRCZg>; Sun, 17 Nov 2002 21:25:36 -0500
Date: Mon, 18 Nov 2002 00:32:32 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ncpfs: fixup after header files cleanups: forward declare struct sock
Message-ID: <20021118023232.GE32457@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
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

	Now there are two outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.887, 2002-11-18 00:29:22-02:00, acme@conectiva.com.br
  o ncpfs: fix up header cleanup: forward declare struct sock.


 ncp_fs_sb.h |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/include/linux/ncp_fs_sb.h b/include/linux/ncp_fs_sb.h
--- a/include/linux/ncp_fs_sb.h	Mon Nov 18 00:30:12 2002
+++ b/include/linux/ncp_fs_sb.h	Mon Nov 18 00:30:12 2002
@@ -17,6 +17,8 @@
 
 #define NCP_DEFAULT_OPTIONS 0		/* 2 for packet signatures */
 
+struct sock;
+
 struct ncp_server {
 
 	struct ncp_mount_data_kernel m;	/* Nearly all of the mount data is of

===================================================================


This BitKeeper patch contains the following changesets:
1.887
## Wrapped with gzip_uu ##


begin 664 bkpatch29530
M'XL(`+10V#T``\U436O<,!`]KW[%0(YE[1G9ZZ_BLDU:VI)"ERVY%8(BS\9+
M;&N1Y$T*_O%Q34G"DG3IQZ&23C/2FWGS'CJ!"\>VF"G=LCB!C\;Y8J9-Q]IO
M]RK0I@VN[)A8&S,FPMJT')Z>A]M.-WW%;BZ#A1C3*^5U#7NVKIA1$#U$_/<=
M%[/U^P\7G]^NA2A+.*M5=\U?V4-9"F_L7C656RI?-Z8+O%6=:]E/A8>'JX-$
ME.->4!KA(ADHP3@=-%5$*B:N4,99$HL?'):'O1^@$%&&%&>4#N.K7(IW0$&6
MI8`R)`HI`\1"YH64<Y0%(CP+"J\(YBA.X=\2.!,:#'1ZMW$%;+9WT.^@9E6Q
M!=VPZOK=&#;V5MD**M:-L@S.VUY[<$;?!.(<(KE(Q>IQRF+^FTL(5"C>'&'V
M4_^PV7;]73AV?+EQE^XJJ)\RS6,:,)92#C%+BAE18Z2TCO7S4SV".DDG94[9
M$*4R2R<[O?CDN+W^DH-HM]VU67+C.:C[8[TC$N4C7CQ$"2;I9+ODT'24_=IT
M\G\UW23'%YC;V^F,+EJ]K,P?6/(3Y2#%DZJOQ;?';T?7K&]<WY;51FX6><7B
)'G",_W?6!```
`
end
