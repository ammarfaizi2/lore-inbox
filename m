Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLNUy0>; Thu, 14 Dec 2000 15:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbQLNUyP>; Thu, 14 Dec 2000 15:54:15 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:29002
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129260AbQLNUyC>; Thu, 14 Dec 2000 15:54:02 -0500
Date: Thu, 14 Dec 2000 21:23:28 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] net/802/transit/Makefile (240-test13-pre1)
Message-ID: <20001214212328.A600@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm not quite sure whom this patch belongs to but I hope that it ends up
in the right hands by way of linux-kernel.

In order to get 'make dep' to make it through my tree (240-test13-pre1) I 
need the following patch applied:


diff -Naur linux-240-t13-pre1-clean/net/802/transit/Makefile linux/net/802/transit/Makefile
--- linux-240-t13-pre1-clean/net/802/transit/Makefile	Thu Dec 12 15:54:22 1996
+++ linux/net/802/transit/Makefile	Thu Dec 14 21:07:39 2000
@@ -1,3 +1,5 @@
+include $(TOPDIR)/Rules.make
+
 all:	pdutr.h timertr.h
 
 pdutr.h: pdutr.pre compile.awk			

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Even if you're on the right track, you'll get run over if you just sit there. 
  -- Will Rogers
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
