Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318107AbSGROyt>; Thu, 18 Jul 2002 10:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318111AbSGROyt>; Thu, 18 Jul 2002 10:54:49 -0400
Received: from fep01.tuttopmi.it ([212.131.248.100]:1934 "EHLO
	fep01-svc.flexmail.it") by vger.kernel.org with ESMTP
	id <S318107AbSGROyt> convert rfc822-to-8bit; Thu, 18 Jul 2002 10:54:49 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Frederik Nosi <fredi@e-salute.it>
Reply-To: fredi@e-salute.it
To: linux-kernel@vger.kernel.org
Subject: [TRIVIAL][Patch 2.4] kill a warning
Date: Thu, 18 Jul 2002 17:07:04 +0200
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207181707.04813.fredi@e-salute.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This kills a compiler warning and touches only one file. Checked on both 
2.4.19-rc[12]



--- linux-2.4.19-rc1/fs/dnotify.c	Sat Jul  6 19:58:52 2002
+++ linux/fs/dnotify.c	Mon Jul  8 21:58:10 2002
@@ -135,7 +135,7 @@
 	}
 	if (changed)
 		redo_inode_mask(inode);
-out:
+
 	write_unlock(&dn_lock);
 }
 

