Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbTBTLgl>; Thu, 20 Feb 2003 06:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbTBTLgl>; Thu, 20 Feb 2003 06:36:41 -0500
Received: from 237.redhat.com ([213.86.99.237]:33508 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265177AbTBTLgk>; Thu, 20 Feb 2003 06:36:40 -0500
Subject: [PATCH] Export skb_pad() in 2.4.21-pre4
From: David Woodhouse <dwmw2@infradead.org>
To: marcelo@conectiva.com.br
Cc: jgarzik@redhat.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045741592.2230.4.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 20 Feb 2003 11:46:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===== net/netsyms.c 1.30 vs edited =====
--- 1.30/net/netsyms.c	Mon Jan 27 23:49:26 2003
+++ edited/net/netsyms.c	Thu Feb 20 10:15:49 2003
@@ -93,6 +93,7 @@
 /* Skbuff symbols. */
 EXPORT_SYMBOL(skb_over_panic);
 EXPORT_SYMBOL(skb_under_panic);
+EXPORT_SYMBOL(skb_pad);
 
 /* Socket layer registration */
 EXPORT_SYMBOL(sock_register);



-- 
dwmw2
