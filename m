Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUEVAXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUEVAXV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUEVAEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:04:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62148 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264562AbUEUXpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:45:42 -0400
Date: Wed, 19 May 2004 19:58:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Oliver Feiler <kiza@gmx.net>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>
Subject: [2.4 patch] net/802/{p8022,psnap}.c: add MODULE_LICENSE
Message-ID: <20040519175841.GH22742@fs.tum.de>
References: <20040510235343.GD18093@fs.tum.de> <200405191227.58002.kiza@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405191227.58002.kiza@gmx.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 12:27:42PM +0200, Oliver Feiler wrote:

> Hi Adrian,

Hi Oliver,

>...
> Yes, works fine. No unresolved symbols.

thanks for the confirmation, and also thanks for this report.

> FWIW, the modules psnap.o and p8022.o don't export a license and taint the 
> kernel:
>...

A fix is below (stolen from 2.6 ;-) ).

> 	Oliver

cu
Adrian

--- linux-2.4.27-pre2-full/net/802/p8022.c.old	2004-05-19 19:47:59.000000000 +0200
+++ linux-2.4.27-pre2-full/net/802/p8022.c	2004-05-19 19:51:42.000000000 +0200
@@ -142,3 +142,5 @@
 
 	restore_flags(flags);
 }
+
+MODULE_LICENSE("GPL");
--- linux-2.4.27-pre2-full/net/802/psnap.c.old	2004-05-19 19:52:22.000000000 +0200
+++ linux-2.4.27-pre2-full/net/802/psnap.c	2004-05-19 19:52:33.000000000 +0200
@@ -152,3 +152,5 @@
 
 	restore_flags(flags);
 }
+
+MODULE_LICENSE("GPL");
