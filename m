Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293722AbSCKMdd>; Mon, 11 Mar 2002 07:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293724AbSCKMdP>; Mon, 11 Mar 2002 07:33:15 -0500
Received: from [213.24.79.7] ([213.24.79.7]:46862 "EHLO despina.msk.mt")
	by vger.kernel.org with ESMTP id <S293722AbSCKMdM>;
	Mon, 11 Mar 2002 07:33:12 -0500
Date: Mon, 11 Mar 2002 15:33:46 +0300
From: Valentin Podlovchenko <valya@vip.pp.ru>
To: Paul Mackerras <paulus@cs.anu.edu.au>,
        "Ben. Herrenschmidt" <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pmac_mb_defs[] for new iBook2 (kernel-2.4.18-ben0)
Message-ID: <20020311123346.GD7449@microtest.ru>
Mail-Followup-To: Valentin Podlovchenko <valya@vip.pp.ru>,
	Paul Mackerras <paulus@cs.anu.edu.au>,
	"Ben. Herrenschmidt" <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Debian GNU/Linux 2.4.17-grsecurity-1.9.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

Hello,

motherboard on the new iBook2 reports to be compatible to "PowerBook4,2"
so to make some things work (such as sleep mode) on this model should be
applied this patch

-- 
  Valentin Podlovchenko,                     ____/|
  <VPodlovchenko@Microtest.ru>               \ o.O|
  Tel: +7(095) 787-2058 (ext. 1245)           =(_)=
  Fax: +7(095) 787-2056                         U

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment; filename="new_ibook2.patch"

diff -urN linux-2.4.18-ben0/arch/ppc/kernel/pmac_feature.c linux-2.4.18-ben0-my/arch/ppc/kernel/pmac_feature.c
--- linux-2.4.18-ben0/arch/ppc/kernel/pmac_feature.c	Tue Feb 26 17:34:34 2002
+++ linux-2.4.18-ben0-my/arch/ppc/kernel/pmac_feature.c	Mon Mar 11 15:16:07 2002
@@ -1640,6 +1640,10 @@
 		PMAC_TYPE_IBOOK2,		pangea_features,
 		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER
 	},
+	{	"PowerBook4,2",			"new iBook 2",
+		PMAC_TYPE_IBOOK2,		pangea_features,
+		PMAC_MB_CAN_SLEEP | PMAC_MB_HAS_FW_POWER
+	},
 	{	"PowerMac4,2",			"Flat panel iMac",
 		PMAC_TYPE_FLAT_PANEL_IMAC,	pangea_features,
 		PMAC_MB_CAN_SLEEP

--cNdxnHkX5QqsyA0e--
