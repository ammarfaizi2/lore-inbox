Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263135AbVD3DFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbVD3DFM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 23:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbVD3DFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 23:05:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:25501 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263135AbVD3DFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 23:05:04 -0400
Date: Fri, 29 Apr 2005 20:04:53 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: vgoyal@in.ibm.com
Cc: akpm@osdl.org, sharyathi@in.ibm.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: [PATCH] Kdump doc. fix option typo.
Message-Id: <20050429200453.0318e633.rddunlap@osdl.org>
In-Reply-To: <20050429050729.GB3636@in.ibm.com>
References: <1114227003.4269c13be5f8b@imap.linux.ibm.com>
	<OFB57B3D45.D8C338C5-ON65256FEE.0042F961-65256FEE.0043D4CB@in.ibm.com>
	<20050425160925.3a48adc5.rddunlap@osdl.org>
	<20050426085448.GB4234@in.ibm.com>
	<20050427122312.358f5bd6.rddunlap@osdl.org>
	<20050428114416.GA5706@in.ibm.com>
	<20050428091119.73568208.rddunlap@osdl.org>
	<20050428200845.5211ec37.rddunlap@osdl.org>
	<20050429050729.GB3636@in.ibm.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2005 10:37:29 +0530 Vivek Goyal wrote:

| Should above line be as follows.
| "should be same as X (See option d) above."
| 
| This will make clear what is X and what should be the new value of 
| CONFIG_PHYSICAL_START. 


From: Randy Dunlap <rddunlap@osdl.org>

Fix one-letter typo of option b->d.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
---

 Documentation/kdump.txt |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./Documentation/kdump.txt~kdump_doc_fix_optionb ./Documentation/kdump.txt
--- ./Documentation/kdump.txt~kdump_doc_fix_optionb	2005-04-28 19:55:03.000000000 -0700
+++ ./Documentation/kdump.txt	2005-04-29 19:59:32.000000000 -0700
@@ -60,7 +60,7 @@ SETUP
 	CONFIG_CRASH_DUMP=y
    b) Specify a suitable value for "Physical address where the kernel is
       loaded" (in Processor type and features). Typically this value
-      should be same as X (See option b) above, e.g., 16 MB or 0x1000000.
+      should be same as X (See option d) above, e.g., 16 MB or 0x1000000.
 	CONFIG_PHYSICAL_START=0x1000000
    c) Enable "/proc/vmcore support" (Optional, in Pseudo filesystems).
 	CONFIG_PROC_VMCORE=y


---
