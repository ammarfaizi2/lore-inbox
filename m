Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281102AbRKPFQm>; Fri, 16 Nov 2001 00:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281129AbRKPFQb>; Fri, 16 Nov 2001 00:16:31 -0500
Received: from shell7.ba.best.com ([206.184.139.138]:2056 "EHLO
	shell7.ba.best.com") by vger.kernel.org with ESMTP
	id <S281102AbRKPFQZ>; Fri, 16 Nov 2001 00:16:25 -0500
Date: Thu, 15 Nov 2001 21:15:52 -0800
From: Nathan Myers <ncm@nospam.cantrip.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, alan@redhat.com
Subject: [PATCH] omnibus NON-include/ cleanup (less big)
Message-ID: <20011115211552.A1867@shell7.ba.best.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small fix to be applied after the patch in

  http://marc.theaimsgroup.com/?l=linux-kernel&m=100588649623663&w=2

Apologies for the mess.
For reference, the two (correct) patches are archived at

  http://ncm.best.vwh.net/patch-linux.diff
  http://ncm.best.vwh.net/patch-includes.diff

Nathan Myers
ncm at cantrip dot org

--- linux-wrong/drivers/net/de4x5.h	Thu Nov 15 20:55:15 2001
+++ linux/drivers/net/de4x5.h	Thu Nov 15 20:55:24 2001
@@ -25,7 +25,7 @@
 #define DE4X5_APROM  (iobase+(0x048 << lp->bus)) /* Ethernet Address PROM */
 #define DE4X5_BROM   (iobase+(0x048 << lp->bus)) /* Boot ROM Register */
 #define DE4X5_SROM   (iobase+(0x048 << lp->bus)) /* Serial ROM Register */
-#define DE4X5_MII    ((iobase+(0x048 << lp->bus)) /* MII Interface Register */
+#define DE4X5_MII    (iobase+(0x048 << lp->bus)) /* MII Interface Register */
 #define DE4X5_DDR    (iobase+(0x050 << lp->bus)) /* Data Diagnostic Register */
 #define DE4X5_FDR    (iobase+(0x058 << lp->bus)) /* Full Duplex Register */
 #define DE4X5_GPT    (iobase+(0x058 << lp->bus)) /* General Purpose Timer Reg.*/
