Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268314AbUHTQdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268314AbUHTQdL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267171AbUHTQdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:33:10 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:13115 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266498AbUHTQdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:33:00 -0400
Message-ID: <30a4d01b0408200932fa581cb@mail.gmail.com>
Date: Fri, 20 Aug 2004 19:32:58 +0300
From: Genady Okrain <mafteah@gmail.com>
Reply-To: Genady Okrain <mafteah@gmail.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 2.6.8.1-mm3 fix nvidia to compile
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the patch to make nvidia to compile.
Maybe you have other ways but that fixed my nvidia :)


Have fun

--- linux/include/linux/pm.h~   2004-08-20 19:23:04.844231272 +0300
+++ linux/include/linux/pm.h    2004-08-20 19:23:34.778680544 +0300
@@ -36,6 +36,7 @@
 {
        PM_SUSPEND, /* enter D1-D3 */
        PM_RESUME,  /* enter D0 */
+       PM_SAVE_STATE,  /* save device's state */
 } pm_request_t;
 
 /*

-- 
Genady Okrain AKA Mafteah
