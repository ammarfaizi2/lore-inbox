Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315207AbSFITk6>; Sun, 9 Jun 2002 15:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSFITk5>; Sun, 9 Jun 2002 15:40:57 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:1293 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S315207AbSFITk4>;
	Sun, 9 Jun 2002 15:40:56 -0400
Date: Sun, 9 Jun 2002 21:43:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: tim@cyberelk.net, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Get rid of warnings in pd.c and pcd.c
Message-ID: <20020609214329.A13417@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Removed two unused variables in paride/pd.c and paride/pcd.c.
Agains 2.5.21

	Sam

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="paride.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.488   -> 1.489  
#	drivers/block/paride/pcd.c	1.14    -> 1.15   
#	drivers/block/paride/pd.c	1.23    -> 1.24   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/09	sam@mars.ravnborg.org	1.489
# Get rid of two warnings in paride/pd.c and paride/pcd.c
# --------------------------------------------
#
diff -Nru a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
--- a/drivers/block/paride/pcd.c	Sun Jun  9 21:21:50 2002
+++ b/drivers/block/paride/pcd.c	Sun Jun  9 21:21:50 2002
@@ -330,7 +330,7 @@
 
 int pcd_init (void)	/* preliminary initialisation */
 
-{       int 	i, unit;
+{       int 	unit;
 
 	if (disable) return -1;
 
diff -Nru a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
--- a/drivers/block/paride/pd.c	Sun Jun  9 21:21:50 2002
+++ b/drivers/block/paride/pd.c	Sun Jun  9 21:21:50 2002
@@ -382,7 +382,7 @@
 
 int pd_init (void)
 
-{       int i;
+{
 	request_queue_t * q; 
 
 	if (disable) return -1;

--fUYQa+Pmc3FrFX/N--
