Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314288AbSEBIxq>; Thu, 2 May 2002 04:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314287AbSEBIxp>; Thu, 2 May 2002 04:53:45 -0400
Received: from theirongiant.weebeastie.net ([203.62.148.50]:21159 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S314285AbSEBIxo>; Thu, 2 May 2002 04:53:44 -0400
Date: Thu, 2 May 2002 18:51:37 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: AMD PowerNow booboo in 2.4.19-pre7-ac3
Message-ID: <20020502085137.GP14678@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- arch/i386/kernel/amdk6plus.c.old    Thu May  2 18:51:13 2002
+++ arch/i386/kernel/amdk6plus.c        Thu May  2 18:51:17 2002
@@ -117,4 +117,4 @@
 MODULE_LICENSE ("GPL");
 module_init(PowerNow_k6plus_init);
 module_exit(PowerNow_k6plus_exit);
-__initcall (PowerNOW_k6plus_init);
+__initcall (PowerNow_k6plus_init);

-- 
CORUSCANT-Presiding over a memorial service commemorating the victims
of the attack on the Death Star, the Emperor declared that while recent
victories over the Rebel Alliance were "encouraging, the War on Terror
is not over yet."
	- http://www.zip.com.au/~cat/misc/txt/waronterror.txt
