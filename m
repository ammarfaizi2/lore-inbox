Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbVITUs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbVITUs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 16:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbVITUs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 16:48:27 -0400
Received: from verein.lst.de ([213.95.11.210]:3284 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S965118AbVITUs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 16:48:26 -0400
Date: Tue, 20 Sep 2005 22:48:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fixup Documentation/DocBook/kernel-hacking.tmpl
Message-ID: <20050920204807.GA8538@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__FUNCTION__ is the prefered kernel idiom, __func__ is not supported by
gcc 2.95 (we actually map __FUNCTION__ to __func__ for more recent
compilers, but it should never be used directly)


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/Documentation/DocBook/kernel-hacking.tmpl
===================================================================
--- linux-2.6.orig/Documentation/DocBook/kernel-hacking.tmpl	2005-09-11 15:19:18.000000000 +0200
+++ linux-2.6/Documentation/DocBook/kernel-hacking.tmpl	2005-09-15 13:38:06.000000000 +0200
@@ -1105,7 +1105,7 @@
     </listitem>
     <listitem>
      <para>
-      Function names as strings (__func__).
+      Function names as strings (__FUNCTION__).
      </para>
     </listitem>
     <listitem>
