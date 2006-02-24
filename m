Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWBXUux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWBXUux (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWBXUuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:50:04 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:16434 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932437AbWBXUt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:49:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=W+G5P1h8zVZClKHc9rualcFLuf72TJD6ac4/Zi/hjXds/a/hKKYRlRoo2Ufpn1W0AWeaBgRk5nIBtqVi6t1YwxfP4oSAzUdednIhFJ/Brn2IdLPm/kxx8axAyc1nskfr+kqsBHDQuuzTArt94UYERmf+HvVsz9ZjkUgnD+tGtjI=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 13/13] trivial typos in Documentation/cputopology.txt
Date: Fri, 24 Feb 2006 21:50:16 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Trivial Patch Monkey <trivial@kernel.org>,
       Zhang Yanmin <yanmin.zhang@intel.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602242150.16838.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix a few trivial mistakes in Documentation/cputopology.txt


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/cputopology.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc4-mm2-orig/Documentation/cputopology.txt	2006-02-18 02:08:36.000000000 +0100
+++ linux-2.6.16-rc4-mm2/Documentation/cputopology.txt	2006-02-24 19:42:46.000000000 +0100
@@ -1,5 +1,5 @@
 
-Export cpu topology info by sysfs. Items (attributes) are similar
+Export cpu topology info via sysfs. Items (attributes) are similar
 to /proc/cpuinfo.
 
 1) /sys/devices/system/cpu/cpuX/topology/physical_package_id:
@@ -12,7 +12,7 @@ represent the thread siblings to cpu X i
 represent the thread siblings to cpu X in the same physical package;
 
 To implement it in an architecture-neutral way, a new source file,
-driver/base/topology.c, is to export the 5 attributes.
+drivers/base/topology.c, is to export the 4 attributes.
 
 If one architecture wants to support this feature, it just needs to
 implement 4 defines, typically in file include/asm-XXX/topology.h.


