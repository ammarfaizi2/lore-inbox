Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSDDDkU>; Wed, 3 Apr 2002 22:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289815AbSDDDkK>; Wed, 3 Apr 2002 22:40:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45841 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289484AbSDDDj6>;
	Wed, 3 Apr 2002 22:39:58 -0500
Message-ID: <3CABCAD9.69851A0D@zip.com.au>
Date: Wed, 03 Apr 2002 19:39:05 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] aic7xxx compile failure in 2.5.8-pre1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.5.8-pre1/drivers/scsi/aic7xxx/aic7xxx_linux.c	Wed Apr  3 17:49:48 2002
+++ 25/drivers/scsi/aic7xxx/aic7xxx_linux.c	Wed Apr  3 19:36:27 2002
@@ -445,7 +445,7 @@ static void			ahc_linux_free_device(stru
 						      struct ahc_linux_device*);
 static void ahc_linux_run_device_queue(struct ahc_softc*,
 				       struct ahc_linux_device*);
-static void ahc_linux_setup_tag_info(char *p, char *end);
+static void ahc_linux_setup_tag_info(char *p, char *end, char *s);
 static int ahc_linux_next_unit(void);
 static int ahc_linux_halt(struct notifier_block *nb, u_long event, void *buf);
 

-
