Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268379AbUH2XID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268379AbUH2XID (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 19:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUH2XID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 19:08:03 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60410 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268379AbUH2XHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 19:07:42 -0400
Date: Mon, 30 Aug 2004 01:07:32 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove bouncing email address of Hennus Bergman
Message-ID: <20040829230732.GE12134@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The email address of Hennus Bergman in the kernel is bouncing.

Aftern asking him whether I should update his email address in the Linux  
kernel, he replied:

<--  snip  -->

I get a lot of spam already and I'd rather avoid getting even more by 
'advertising' my email adres on the internet like that. So I don't want 
my pobox email address in the kernel distribution.
If you want to remove my old cybercomm.nl  email address, that's fine 
by me.

<--  snip  -->


The patch below therefore simply removes his bouncing emal address and 
no longer homepage.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.9-rc1-mm1-full/CREDITS.old	2004-08-30 01:00:57.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/CREDITS	2004-08-30 01:01:10.000000000 +0200
@@ -325,8 +325,6 @@
 S: USA
 
 N: Hennus Bergman
-E: hennus@cybercomm.nl
-W: http://www.cybercomm.nl/~hennus/
 P: 1024/77D50909 76 99 FD 31 91 E1 96 1C  90 BB 22 80 62 F6 BD 63
 D: Author and maintainer of the QIC-02 tape driver
 S: The Netherlands
--- linux-2.6.9-rc1-mm1-full/drivers/char/tpqic02.c.old	2004-08-30 01:01:38.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/char/tpqic02.c	2004-08-30 01:01:49.000000000 +0200
@@ -3,7 +3,6 @@
  * Driver for tape drive support for Linux-i386
  *
  * Copyright (c) 1992--1996 by H. H. Bergman. All rights reserved.
- * Current e-mail address: hennus@cybercomm.nl
  *
  * Distribution of this program in executable form is only allowed if
  * all of the corresponding source files are made available through the same

