Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266192AbUAGP7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 10:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266210AbUAGP7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 10:59:50 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:61934 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266192AbUAGP7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 10:59:49 -0500
Date: Wed, 7 Jan 2004 16:59:40 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] fix CONFIG_QFMT_V2 description
Message-ID: <20040107155940.GB11523@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2,4, the CONFIG_QFMT_V2 short description talks about a
"VFS v0 quota format". Is this really correct, or is the patch below 
that uses the "Quota format v2 support" text from 2.6 instead correct?

cu
Adrian

--- linux-2.4.25-pre4-full/fs/Config.in.old	2004-01-07 16:46:06.000000000 +0100
+++ linux-2.4.25-pre4-full/fs/Config.in	2004-01-07 16:49:29.000000000 +0100
@@ -5,7 +5,7 @@
 comment 'File systems'
 
 bool 'Quota support' CONFIG_QUOTA
-dep_tristate '  VFS v0 quota format support' CONFIG_QFMT_V2 $CONFIG_QUOTA
+dep_tristate '  Quota format v2 support' CONFIG_QFMT_V2 $CONFIG_QUOTA
 
 tristate 'Kernel automounter support' CONFIG_AUTOFS_FS
 tristate 'Kernel automounter version 4 support (also supports v3)' CONFIG_AUTOFS4_FS
--- linux-2.4.25-pre4-full/Documentation/Configure.help.old	2004-01-07 16:50:05.000000000 +0100
+++ linux-2.4.25-pre4-full/Documentation/Configure.help	2004-01-07 16:50:37.000000000 +0100
@@ -13628,7 +13628,7 @@
   <http://www.tldp.org/docs.html#howto>. Probably the quota
   support is only useful for multi user systems. If unsure, say N.
 
-VFS v0 quota format support
+Quota format v2 support
 CONFIG_QFMT_V2
   This quota format allows using quotas with 32-bit UIDs/GIDs. If you
   need this functionality say Y here. Note that you will need latest
