Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264659AbTF0PWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 11:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbTF0PSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 11:18:53 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:23474 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id S264493AbTF0O5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:57:14 -0400
Date: Fri, 27 Jun 2003 17:09:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (7/7): tty3215_init.
Message-ID: <20030627150948.GH3591@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add return statement to tty init function of 3215 driver.

diffstat:
 drivers/s390/char/con3215.c |    1 +
 1 files changed, 1 insertion(+)

diff -urN linux-2.5/drivers/s390/char/con3215.c linux-2.5-s390/drivers/s390/char/con3215.c
--- linux-2.5/drivers/s390/char/con3215.c	Sun Jun 22 20:32:58 2003
+++ linux-2.5-s390/drivers/s390/char/con3215.c	Fri Jun 27 16:04:41 2003
@@ -1215,6 +1215,7 @@
 		return ret;
 	}
 	tty3215_driver = driver;
+	return 0;
 }
 
 static void __exit
