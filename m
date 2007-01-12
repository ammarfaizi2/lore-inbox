Return-Path: <linux-kernel-owner+w=401wt.eu-S1161003AbXALGJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbXALGJP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 01:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbXALGJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 01:09:14 -0500
Received: from koto.vergenet.net ([210.128.90.7]:53416 "EHLO koto.vergenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161004AbXALGJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 01:09:11 -0500
Date: Fri, 12 Jan 2007 15:06:19 +0900
From: Horms <horms@verge.net.au>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Mohan Kumar M <mohan@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Nanhai Zou <nanhai.zou@intel.com>, Tony Luck <tony.luck@intel.com>,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       linux-ia64@vger.kernel.org
Subject: [PATCH] Kdump documentation update for 2.6.20: kexec-tools update
Message-ID: <20070112060618.GA17379@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mohan Kumar suggested making kexec-tools-testing.tar.gz a link
to the latest version. I have done this and this patch updates the
documentation accordingly.

This patch requires the documentation patch update that Vivek Goyal has
been circulating, and I believe is currently in mm. Feel free to fold it
into that change if it makes things easier for anyone.

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: linux-2.6/Documentation/kdump/kdump.txt
===================================================================
--- linux-2.6.orig/Documentation/kdump/kdump.txt	2007-01-12 14:37:18.000000000 +0900
+++ linux-2.6/Documentation/kdump/kdump.txt	2007-01-12 14:56:42.000000000 +0900
@@ -61,7 +61,12 @@
 
 2) Download the kexec-tools user-space package from the following URL:
 
-http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/kexec-tools-testing-20061214.tar.gz
+http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/kexec-tools-testing.tar.gz
+
+This is a symlink to the latest version, which at the time of writing is
+20061214, the only release of kexec-tools-testing so far. As other versions
+are made released, the older onese will remain available at
+http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/
 
 Note: Latest kexec-tools-testing git tree is available at
 
@@ -71,11 +76,11 @@
 
 3) Unpack the tarball with the tar command, as follows:
 
-   tar xvpzf kexec-tools-testing-20061214.tar.gz
+   tar xvpzf kexec-tools-testing.tar.gz
 
-4) Change to the kexec-tools-1.101 directory, as follows:
+4) Change to the kexec-tools directory, as follows:
 
-   cd kexec-tools-testing-20061214
+   cd kexec-tools-testing-VERSION
 
 5) Configure the package, as follows:
 
