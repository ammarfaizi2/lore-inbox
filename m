Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbUJaVpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbUJaVpb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 16:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbUJaVoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 16:44:25 -0500
Received: from f29.mail.ru ([194.67.57.22]:16658 "EHLO f29.mail.ru")
	by vger.kernel.org with ESMTP id S261657AbUJaViT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 16:38:19 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kernel-doc: don't print =?koi8-r?Q?=22?=...=?koi8-r?Q?=22=20?=twice in variadic functions.
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.222.68.89]
Date: Mon, 01 Nov 2004 00:38:10 +0300
Reply-To: Alexey Dobriyan <adobriyan@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1CONOs-00009g-00.adobriyan-mail-ru@f29.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- a/scripts/kernel-doc	2004-10-31 20:25:16.000000000 +0000
+++ b/scripts/kernel-doc	2004-10-31 22:57:20.061852472 +0000
@@ -1398,7 +1398,7 @@
 
 	if ($type eq "" && $param eq "...")
 	{
-	    $type="...";
+	    $type="";
 	    $param="...";
 	    $parameterdescs{"..."} = "variable arguments";
 	}

