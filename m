Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbVKHQFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbVKHQFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbVKHQFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:05:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12816 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030226AbVKHQFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:05:05 -0500
Date: Tue, 8 Nov 2005 17:05:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: starvik@axis.com
Cc: dev-etrax@axis.com, linux-kernel@vger.kernel.org,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: [2.6 patch] cris: kgdb: remove double_this()
Message-ID: <20051108160504.GV3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>

Doesn't make much sense and unused.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/cris/arch-v10/kernel/kgdb.c |    6 ------
 1 file changed, 6 deletions(-)

--- ./arch/cris/arch-v10/kernel/kgdb.c
+++ ./arch/cris/arch-v10/kernel/kgdb.c
@@ -569,12 +569,6 @@ gdb_cris_strtol (const char *s, char **e
 	return x;
 }
 
-int
-double_this(int x)
-{
-        return 2 * x;
-}
-
 /********************************* Register image ****************************/
 /* Copy the content of a register image into another. The size n is
    the size of the register image. Due to struct assignment generation of


