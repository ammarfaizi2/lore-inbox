Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936054AbWK1TfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936054AbWK1TfJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936064AbWK1TfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:35:08 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:4199 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S936054AbWK1TfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:35:07 -0500
Date: Tue, 28 Nov 2006 11:35:22 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] REPORTING-BUGS: request .config file
Message-Id: <20061128113522.432889b7.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Add kernel .config file to REPORTING-BUGS.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 REPORTING-BUGS |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.19-rc6-git10.orig/REPORTING-BUGS
+++ linux-2.6.19-rc6-git10/REPORTING-BUGS
@@ -40,7 +40,9 @@ summary from [1.]>" for easy identificat
 [1.] One line summary of the problem:
 [2.] Full description of the problem/report:
 [3.] Keywords (i.e., modules, networking, kernel):
-[4.] Kernel version (from /proc/version):
+[4.] Kernel information
+[4.1.] Kernel version (from /proc/version):
+[4.2.] Kernel .config file:
 [5.] Most recent kernel version which did not have the bug:
 [6.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)


---
