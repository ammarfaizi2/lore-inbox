Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWBXUs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWBXUs2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWBXUs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:48:27 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:28256 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932480AbWBXUsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:48:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=Ke9fhiVd/g4IxQxULoMhiY4lU1EUqWaHjBSk0wKseczX0aIEAiXX6fzw8+VwmdWEne/m0aNgkMJlcKIdUxzjQcxIYhvHyu6IrOzCTdoei0vWv+O9prKlPNUobMg3rLelDhmu7X64vlx5bVJSKqfKFoDEdEVatuxevUnL+15qS3c=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 08/13] NE2000 Kconfig help entry improvement
Date: Fri, 24 Feb 2006 21:48:35 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Ged Haywood <ged@jubileegroup.co.uk>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602242148.36075.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Improve reference to PCI NE2K support in ISA NE2K documentation.
  Original 2.4 patch From: Ged Haywood <ged@jubileegroup.co.uk>


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/net/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.16-rc4-mm2-orig/drivers/net/Kconfig	2006-02-24 19:25:37.000000000 +0100
+++ linux-2.6.16-rc4-mm2/drivers/net/Kconfig	2006-02-24 20:44:41.000000000 +0100
@@ -1087,7 +1087,8 @@ config NE2000
 	  without a specific driver are compatible with NE2000.
 
 	  If you have a PCI NE2000 card however, say N here and Y to "PCI
-	  NE2000 support", above. If you have a NE2000 card and are running on
+	  NE2000 and clone support" under "EISA, VLB, PCI and on board
+	  controllers" below. If you have a NE2000 card and are running on
 	  an MCA system (a bus system used on some IBM PS/2 computers and
 	  laptops), say N here and Y to "NE/2 (ne2000 MCA version) support",
 	  below.



