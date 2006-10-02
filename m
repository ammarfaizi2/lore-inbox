Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWJBUhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWJBUhX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWJBUhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:37:23 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:56669 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S965003AbWJBUhV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:37:21 -0400
From: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
To: rolandd@cisco.com
Subject: [PATCH 2.6.19-rc1 2/2] ehca: improved ehca debug format
Date: Mon, 2 Oct 2006 22:33:50 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openib-general@openib.org, openfabrics-ewg@openib.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ueXIFIJcvA+6/M1"
Message-Id: <200610022233.50497.hnguyen@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ueXIFIJcvA+6/M1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
here is the 2nd patch of ehca with a small format improvement in ehca debug function.
Thanks!
Nam Nguyen


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_tools.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_tools.h infiniband_work/drivers/infiniband/hw/ehca/ehca_tools.h
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_tools.h 2006-10-02 22:08:57.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_tools.h 2006-10-02 18:29:53.000000000 +0200
@@ -117,7 +117,7 @@ extern int ehca_debug_level;
   unsigned int l = (unsigned int)(len); \
   unsigned char *deb = (unsigned char*)(adr); \
   for (x = 0; x < l; x += 16) { \
-   printk("EHCA_DMP:%s" format \
+   printk("EHCA_DMP:%s " format \
           " adr=%p ofs=%04x %016lx %016lx\n", \
           __FUNCTION__, ##args, deb, x, \
           *((u64 *)&deb[0]), *((u64 *)&deb[8])); \

--Boundary-00=_ueXIFIJcvA+6/M1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="svnehca_0017_roland_git.patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="svnehca_0017_roland_git.patch2"

diff -Nurp infiniband_orig/drivers/infiniband/hw/ehca/ehca_tools.h infiniband_work/drivers/infiniband/hw/ehca/ehca_tools.h
--- infiniband_orig/drivers/infiniband/hw/ehca/ehca_tools.h	2006-10-02 22:08:57.000000000 +0200
+++ infiniband_work/drivers/infiniband/hw/ehca/ehca_tools.h	2006-10-02 18:29:53.000000000 +0200
@@ -117,7 +117,7 @@ extern int ehca_debug_level;
 		unsigned int l = (unsigned int)(len); \
 		unsigned char *deb = (unsigned char*)(adr);	\
 		for (x = 0; x < l; x += 16) { \
-			printk("EHCA_DMP:%s" format \
+			printk("EHCA_DMP:%s " format \
 			       " adr=%p ofs=%04x %016lx %016lx\n", \
 			       __FUNCTION__, ##args, deb, x, \
 			       *((u64 *)&deb[0]), *((u64 *)&deb[8])); \

--Boundary-00=_ueXIFIJcvA+6/M1--
