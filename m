Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317939AbSGWAoP>; Mon, 22 Jul 2002 20:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317925AbSGWAlb>; Mon, 22 Jul 2002 20:41:31 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:13060 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317923AbSGWAlR>;
	Mon, 22 Jul 2002 20:41:17 -0400
Date: Mon, 22 Jul 2002 17:44:27 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [BK PATCH] LSM changes for 2.5.27
Message-ID: <20020723004426.GJ660@kroah.com>
References: <20020723003702.GA660@kroah.com> <20020723003806.GB660@kroah.com> <20020723003905.GC660@kroah.com> <20020723003935.GD660@kroah.com> <20020723003952.GE660@kroah.com> <20020723004007.GF660@kroah.com> <20020723004034.GG660@kroah.com> <20020723004051.GH660@kroah.com> <20020723004354.GI660@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020723004354.GI660@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 24 Jun 2002 23:35:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.685   -> 1.686  
#	    security/dummy.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/22	greg@kroah.com	1.686
# LSM: fixed typo that happened in merge
# --------------------------------------------
#
diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Mon Jul 22 17:25:40 2002
+++ b/security/dummy.c	Mon Jul 22 17:25:40 2002
@@ -508,7 +508,7 @@
 	.capget =			dummy_capget,
 	.capset_check =			dummy_capset_check,
 	.capset_set =			dummy_capset_set,
-	.acct =				dummy_act,
+	.acct =				dummy_acct,
 	.capable =			dummy_capable,
 	.sys_security =			dummy_sys_security,
 	.quotactl =			dummy_quotactl,
