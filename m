Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264667AbTFUOaU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 10:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbTFUOaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 10:30:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4848 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264667AbTFUOaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 10:30:16 -0400
Date: Sat, 21 Jun 2003 16:44:10 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] remove an unused function declaration from sym53c416.h
Message-ID: <20030621144410.GX29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes a declaration for a function that is no longer 
present.

I've tested the compilation with 2.5.72-mm2.

--- linux-2.5.72-mm2/drivers/scsi/sym53c416.h.old	2003-06-21 16:38:26.000000000 +0200
+++ linux-2.5.72-mm2/drivers/scsi/sym53c416.h	2003-06-21 16:39:06.000000000 +0200
@@ -25,7 +25,6 @@
 static int sym53c416_detect(Scsi_Host_Template *);
 static const char *sym53c416_info(struct Scsi_Host *);
 static int sym53c416_release(struct Scsi_Host *);
-static int sym53c416_command(Scsi_Cmnd *);
 static int sym53c416_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
 static int sym53c416_abort(Scsi_Cmnd *);
 static int sym53c416_host_reset(Scsi_Cmnd *);


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

