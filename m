Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbUK3D1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbUK3D1E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 22:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbUK3D1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 22:27:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48144 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261964AbUK3D0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 22:26:30 -0500
Date: Tue, 30 Nov 2004 04:26:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: James.Bottomley@SteelEye.com,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch] remove bouncing email address of Deanna Bonds
Message-ID: <20041130032624.GE19821@stusta.de>
References: <60807403EABEB443939A5A7AA8A7458B7661DC@otce2k01.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60807403EABEB443939A5A7AA8A7458B7661DC@otce2k01.adaptec.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 08:27:39AM -0500, Salyzyn, Mark wrote:

> That address should instead become aacraid@adaptec.com to capture
> engineers at Adaptec.

Sounds reasonable.
Updated patch below.

> Sincerely -- Mark Salyzyn


diffstat output:
 drivers/scsi/aacraid/README   |    2 +-
 drivers/scsi/dpt/dpti_ioctl.h |    2 +-
 drivers/scsi/dpt_i2o.c        |    2 +-
 drivers/scsi/dpti.h           |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/drivers/scsi/aacraid/README.old	2004-11-24 19:24:05.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/scsi/aacraid/README	2004-11-24 19:24:16.000000000 +0100
@@ -42,7 +42,7 @@
 Christoph Hellwig <hch@infradead.org>	(updates for new-style PCI probing and SCSI host registration,
 					 small cleanups/fixes)
 Matt Domsch <matt_domsch@dell.com>	(revision ioctl, adapter messages)
-Deanna Bonds <deanna_bonds@adaptec.com> (non-DASD support, PAE fibs and 64 bit, added new adaptec controllers
+Deanna Bonds                            (non-DASD support, PAE fibs and 64 bit, added new adaptec controllers
 					 added new ioctls, changed scsi interface to use new error handler,
 					 increased the number of fibs and outstanding commands to a container)
 
--- linux-2.6.10-rc2-mm3-full/drivers/scsi/dpti.h.old	2004-11-30 04:22:35.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/scsi/dpti.h	2004-11-30 04:23:47.000000000 +0100
@@ -3,7 +3,7 @@
                              -------------------
     begin                : Thu Sep 7 2000
     copyright            : (C) 2001 by Adaptec
-    email                : deanna_bonds@adaptec.com
+    email                : aacraid@adaptec.com
 
     See Documentation/scsi/dpti.txt for history, notes, license info
     and credits
--- linux-2.6.10-rc2-mm3-full/drivers/scsi/dpt/dpti_ioctl.h.old	2004-11-30 04:22:35.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/scsi/dpt/dpti_ioctl.h	2004-11-30 04:23:53.000000000 +0100
@@ -3,7 +3,7 @@
                              -------------------
     begin                : Thu Sep 7 2000
     copyright            : (C) 2001 by Adaptec
-    email                : deanna_bonds@adaptec.com
+    email                : aacraid@adaptec.com
 
     See Documentation/scsi/dpti.txt for history, notes, license info
     and credits
--- linux-2.6.10-rc2-mm3-full/drivers/scsi/dpt_i2o.c.old	2004-11-30 04:22:35.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/scsi/dpt_i2o.c	2004-11-30 04:23:59.000000000 +0100
@@ -3,7 +3,7 @@
                              -------------------
     begin                : Thu Sep 7 2000
     copyright            : (C) 2000 by Adaptec
-    email                : deanna_bonds@adaptec.com
+    email                : aacraid@adaptec.com
 
 			   July 30, 2001 First version being submitted
 			   for inclusion in the kernel.  V2.4
