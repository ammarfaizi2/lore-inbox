Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSHaLIG>; Sat, 31 Aug 2002 07:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316792AbSHaLIG>; Sat, 31 Aug 2002 07:08:06 -0400
Received: from ns2.sea.interquest.net ([66.135.144.2]:8141 "EHLO ns2.sea")
	by vger.kernel.org with ESMTP id <S314459AbSHaLIF>;
	Sat, 31 Aug 2002 07:08:05 -0400
Date: Sat, 31 Aug 2002 04:18:15 -0700
From: silvio@big.net.au
To: linux-kernel@vger.kernel.org
Subject: [PATCH TRIVIAL]: 2.4.19/drivers/tc/tc.c
Message-ID: <20020831041815.A2245@hamsec.aurora.sfo.interquest.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

trivial patch to use const char * instead of char * (this will also make it
match up the prototype in header)

--
Silvio

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch_tc_2_4_19

diff -u linux-2.4.19/drivers/tc/tc.c linux-2.4.19-dev/drivers/tc/tc.c
--- linux-2.4.19/drivers/tc/tc.c	Sat Aug 31 04:07:28 2002
+++ linux-2.4.19-dev/drivers/tc/tc.c	Sat Aug 31 04:07:52 2002
@@ -40,7 +40,7 @@
  * Interface to the world. Read comment in include/asm-mips/tc.h.
  */
 
-int search_tc_card(char *name)
+int search_tc_card(const char *name)
 {
 	int slot;
 	slot_info *sip;

--WIyZ46R2i8wDzkSu--
