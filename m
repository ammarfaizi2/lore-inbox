Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbUCCEZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbUCCEXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:23:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:35458 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262358AbUCCEVz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:21:55 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4-rc1
In-Reply-To: <10782873982895@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 2 Mar 2004 20:16:38 -0800
Message-Id: <1078287398405@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1612.17.3, 2004/02/27 11:12:02-08:00, greg@kroah.com

kobject: fix kobject hotplug debug message to show more needed info.


 lib/kobject.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Tue Mar  2 19:50:53 2004
+++ b/lib/kobject.c	Tue Mar  2 19:50:53 2004
@@ -185,8 +185,8 @@
 		}
 	}
 
-	pr_debug ("%s: %s %s %s %s %s %s\n", __FUNCTION__, argv[0], argv[1],
-		  envp[0], envp[1], envp[2], envp[3]);
+	pr_debug ("%s: %s %s %s %s %s %s %s\n", __FUNCTION__, argv[0], argv[1],
+		  envp[0], envp[1], envp[2], envp[3], envp[4]);
 	retval = call_usermodehelper (argv[0], argv, envp, 0);
 	if (retval)
 		pr_debug ("%s - call_usermodehelper returned %d\n",

