Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEMWs>; Fri, 5 Jan 2001 07:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEMWi>; Fri, 5 Jan 2001 07:22:38 -0500
Received: from sith.mimuw.edu.pl ([193.0.97.1]:55818 "HELO sith.mimuw.edu.pl")
	by vger.kernel.org with SMTP id <S129183AbRAEMWd>;
	Fri, 5 Jan 2001 07:22:33 -0500
Date: Fri, 5 Jan 2001 13:25:14 +0100
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: torvalds@transmeta.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.0 drivers/atm/Makefile...
Message-ID: <20010105132514.H2665@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.0-prerelease i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...is still broken. It does not build Fore 200e driver.

Jan

--- linux/drivers/atm/Makefile.orig	Tue Jan  2 10:18:25 2001
+++ linux/drivers/atm/Makefile	Tue Jan  2 12:00:05 2001
@@ -46,7 +46,7 @@
   endif
 endif
 
-obj-$(CONFIG_ATM_FORE200E) += fore200e.o $(FORE200E_FW_OBJS)
+obj-$(CONFIG_ATM_FORE200E) += fore_200e.o
 
 include $(TOPDIR)/Rules.make
 
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, MANIAC              |                   -- TROOPS by Kevin Rubio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
