Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263012AbREaEl1>; Thu, 31 May 2001 00:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263015AbREaElR>; Thu, 31 May 2001 00:41:17 -0400
Received: from sv.moemoe.gr.jp ([211.10.15.35]:33038 "HELO mail.moemoe.gr.jp")
	by vger.kernel.org with SMTP id <S263012AbREaElK>;
	Thu, 31 May 2001 00:41:10 -0400
Date: Thu, 31 May 2001 13:41:07 +0900
From: Keitaro Yosimura <ramsy@linux.or.jp>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] ip_masq_vdolive.c typo fix
Cc: Nigel.Metheringham@ThePLAnet.net
Message-Id: <20010531133416.832F.RAMSY@linux.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I found typo at ip_masq_vdolive.c.

2.2.{19,20-pre2} typo fix

--- linux.orig/net/ipv4/ip_masq_vdolive.c	Thu May 31 13:29:14 2001
+++ linux/net/ipv4/ip_masq_vdolive.c	Thu May 31 13:30:47 2001
@@ -242,7 +242,7 @@
 						      ports[i]))) {
 				return j;
 			}
-			IP_MASQ_DEBUG(1-debug, "RealAudio: loaded support on port[%d] = %d\n", i, ports[i]);
+			IP_MASQ_DEBUG(1-debug, "VDOlive: loaded support on port[%d] = %d\n", i, ports[i]);
 		} else {
 			/* To be safe, force the incarnation table entry to NULL */
 			masq_incarnations[i] = NULL;


<|> YOSHIMURA 'ramsy' Keitaro / Japan Linux Association
<|> mailto:ramsy@linux.or.jp
<|> http://jla.linux.or.jp/index.html

