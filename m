Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTLCPNn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264603AbTLCPNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:13:43 -0500
Received: from mailwasher.lanl.gov ([192.16.0.25]:25987 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264582AbTLCPNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:13:41 -0500
Subject: [PATCH] 2.4.23 update Documentation/Changes for quota-tools
From: Steven Cole <elenstev@mesatop.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1070464274.1652.24.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 03 Dec 2003 08:11:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates Documentation/Changes for quota-tools.  

This information may be needed by those wanting to use the new quota
code (CONFIG_QFMT_V2) which went in about 6 months ago.

The patch to update ver_linux for quota-tools was applied 5 months ago,
but this part slipped through the cracks somehow.

Steven

--- linux-2.4.23/Documentation/Changes.orig	Wed Dec  3 07:02:41 2003
+++ linux-2.4.23/Documentation/Changes	Wed Dec  3 07:02:48 2003
@@ -57,6 +57,7 @@
 o  jfsutils               1.0.12                  # fsck.jfs -V
 o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs
 o  pcmcia-cs              3.1.21                  # cardmgr -V
+o  quota-tools            3.09                    # quota -V
 o  PPP                    2.4.0                   # pppd --version
 o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep version
 			  
@@ -197,6 +198,14 @@
 kernel source.  Pay attention when you recompile your kernel ;-).
 Also, be sure to upgrade to the latest pcmcia-cs release.
 
+Quota-tools
+-----------
+
+Support for 32 bit uid's and gid's is required if you want to use
+the newer version 2 quota format.  Quota-tools version 3.07 and
+newer has this support.  Use the recommended version or newer
+from the table above.
+
 Intel IA32 microcode
 --------------------
 
@@ -335,6 +344,10 @@
 ---------
 o  <ftp://pcmcia-cs.sourceforge.net/pub/pcmcia-cs/pcmcia-cs-3.1.21.tar.gz>
 
+Quota-tools
+----------
+o  <http://sourceforge.net/projects/linuxquota/>
+
 Jade
 ----
 o  <ftp://ftp.jclark.com/pub/jade/jade-1.2.1.tar.gz>



