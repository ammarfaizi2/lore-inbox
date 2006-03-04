Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752058AbWCDVSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbWCDVSx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 16:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbWCDVSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 16:18:52 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:20086 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752058AbWCDVSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 16:18:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=H19MPmpO71SoohI22Xnxxrx80GFPaw7uW2pyKgucigt7J5EjyLOoOPQu84BvObm50wpHC5RkB0NTqYN4bdy+qe2q7gznWSXoug2zcEzfsT0vYtulBg2uDK+LnojIHO3szxziUsMDuMXs2BfJK2RjiJBtSwumGvL/pLX27JvQDsw=
Date: Sun, 5 Mar 2006 00:18:47 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] synclink: s/aviod/avoid/
Message-ID: <20060304211847.GA8332@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/synclink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/synclink.c
+++ b/drivers/char/synclink.c
@@ -6025,7 +6025,7 @@ static void usc_set_async_mode( struct m
 	 * <15..8>	?		RxFIFO IRQ Request Level
 	 *
 	 * Note: For async mode the receive FIFO level must be set
-	 * to 0 to aviod the situation where the FIFO contains fewer bytes
+	 * to 0 to avoid the situation where the FIFO contains fewer bytes
 	 * than the trigger level and no more data is expected.
 	 *
 	 * <7>		0		Exited Hunt IA (Interrupt Arm)

