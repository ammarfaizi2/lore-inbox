Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVAGP5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVAGP5n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVAGP5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:57:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64450 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261475AbVAGP5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:57:38 -0500
Message-ID: <41DEB16E.3030102@sgi.com>
Date: Fri, 07 Jan 2005 10:57:34 -0500
From: Prarit Bhargava <prarit@sgi.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: Missing #include in kernel/sys.c build fix
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Latest bk pull is broken due to missing #include in kernel/sys.c


--- linux-2.5.orig/kernel/sys.c 2005-01-07 09:54:20.505756616 -0500
+++ linux-2.5/kernel/sys.c      2005-01-07 09:43:21.790575604 -0500
@@ -23,6 +23,7 @@
 #include <linux/security.h>
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
+#include <linux/tty.h>

 #include <linux/compat.h>
 #include <linux/syscalls.h>

