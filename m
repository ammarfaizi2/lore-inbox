Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317430AbSFHTTO>; Sat, 8 Jun 2002 15:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317431AbSFHTTN>; Sat, 8 Jun 2002 15:19:13 -0400
Received: from newman.msbb.uc.edu ([129.137.2.198]:14598 "EHLO smtp.uc.edu")
	by vger.kernel.org with ESMTP id <S317430AbSFHTTN>;
	Sat, 8 Jun 2002 15:19:13 -0400
From: kuebelr@email.uc.edu
Date: Sat, 8 Jun 2002 15:19:05 -0400
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] remove unused label in dnotify.c
Message-Id: <20020608191905.GB21529@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an un-needed label in __inode_dir_notify().  Patch is
against 2.4.19-pre10.

Rob.

--- linux-clean/fs/dnotify.c	Fri Jun  7 23:42:06 2002
+++ linux-dirty/fs/dnotify.c	Sat Jun  8 11:50:15 2002
@@ -135,7 +135,6 @@
 	}
 	if (changed)
 		redo_inode_mask(inode);
-out:
 	write_unlock(&dn_lock);
 }
 
