Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759264AbWLAOZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759264AbWLAOZQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759290AbWLAOZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:25:15 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:63244 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759264AbWLAOZO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:25:14 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] rio parenthesis fix
Date: Fri, 1 Dec 2006 15:24:49 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011524.49653.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing parenthesis in RIOMCAinit() code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/char/rio/rioinit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/drivers/char/rio/rioinit.c	2001-07-04 23:41:33.000000000 +0200
+++ linux-2.4.34-pre6-b/drivers/char/rio/rioinit.c	2006-12-01 12:20:02.000000000 +0100
@@ -478,7 +478,7 @@ int RIOMCAinit(int Mode)
 		Handle = RIOMapin( Paddr, RIO_MCA_MEM_SIZE, &Caddr );
 
 		if ( Handle == -1 ) {
-			rio_dprintk (RIO_DEBUG_INIT, "Couldn't map %d bytes at %x\n", RIO_MCA_MEM_SIZE, Paddr;
+			rio_dprintk (RIO_DEBUG_INIT, "Couldn't map %d bytes at %x\n", RIO_MCA_MEM_SIZE, Paddr);
 			continue;
 		}
 


-- 
Regards,

	Mariusz Kozlowski
