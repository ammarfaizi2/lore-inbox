Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277639AbRJIACY>; Mon, 8 Oct 2001 20:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277648AbRJIACQ>; Mon, 8 Oct 2001 20:02:16 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:6670 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S277639AbRJIACD>;
	Mon, 8 Oct 2001 20:02:03 -0400
Message-ID: <3BC23ED4.8050001@si.rr.com>
Date: Mon, 08 Oct 2001 20:03:32 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, alan <alan@redhat.com>
Subject: [PATCH] 2.4.10-ac10: more MODULE_LICENSE tags, mostly ISDN
Content-Type: multipart/mixed;
 boundary="------------000103070906080802070806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000103070906080802070806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
   I have attached more MODULE_LICENSE patches. Please review.
Regards,
Frank

--------------000103070906080802070806
Content-Type: text/plain;
 name="AMD7930"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="AMD7930"

--- drivers/sbus/audio/amd7930.c.old	Mon Jun 11 22:15:27 2001
+++ drivers/sbus/audio/amd7930.c	Mon Oct  8 18:57:25 2001
@@ -1716,6 +1716,7 @@
 
 module_init(amd7930_init);
 module_exit(amd7930_exit);
+MODULE_LICENSE("GPL");
 
 /*************************************************************/
 /*                 Audio format conversion                   */

--------------000103070906080802070806
Content-Type: text/plain;
 name="CALLC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CALLC"

--- drivers/isdn/hisax/callc.c.old	Mon Oct  8 18:24:13 2001
+++ drivers/isdn/hisax/callc.c	Mon Oct  8 19:16:54 2001
@@ -24,6 +24,7 @@
 
 #ifdef MODULE
 #define MOD_USE_COUNT ( GET_USE_COUNT (&__this_module))
+MODULE_LICENSE("GPL");
 #endif	/* MODULE */
 
 const char *lli_revision = "$Revision: 2.51.6.6 $";

--------------000103070906080802070806
Content-Type: text/plain;
 name="HYCAPI"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HYCAPI"

--- drivers/isdn/hysdn/hycapi.c.old	Mon Oct  8 18:24:19 2001
+++ drivers/isdn/hysdn/hycapi.c	Mon Oct  8 19:19:30 2001
@@ -33,6 +33,7 @@
 
 unsigned int hycapi_enable = 0xffffffff; 
 MODULE_PARM(hycapi_enable, "i");
+MODULE_LICENSE("GPL");
 
 typedef struct _hycapi_appl {
 	unsigned int ctrl_mask;

--------------000103070906080802070806
Content-Type: text/plain;
 name="HYSDN1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HYSDN1"

--- drivers/isdn/hysdn/hysdn_net.c.old	Mon Oct  8 18:24:19 2001
+++ drivers/isdn/hysdn/hysdn_net.c	Mon Oct  8 19:27:04 2001
@@ -27,6 +27,7 @@
 
 unsigned int hynet_enable = 0xffffffff; 
 MODULE_PARM(hynet_enable, "i");
+MODULE_LICENSE("GPL");
 
 /* store the actual version for log reporting */
 char *hysdn_net_revision = "$Revision: 1.8.6.4 $";

--------------000103070906080802070806
Content-Type: text/plain;
 name="HYSDN2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HYSDN2"

--- drivers/isdn/hysdn/hysdn_procconf.c.old	Mon Oct  8 18:24:19 2001
+++ drivers/isdn/hysdn/hysdn_procconf.c	Mon Oct  8 19:28:48 2001
@@ -24,6 +24,7 @@
 static char *hysdn_procconf_revision = "$Revision: 1.8.6.4 $";
 
 #define INFO_OUT_LEN 80		/* length of info line including lf */
+MODULE_LICENSE("GPL");
 
 /********************************************************/
 /* defines and data structure for conf write operations */

--------------000103070906080802070806
Content-Type: text/plain;
 name="HYSDN3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HYSDN3"

--- drivers/isdn/hysdn/hysdn_procfs.c.old	Mon Aug 27 11:53:04 2001
+++ drivers/isdn/hysdn/hysdn_procfs.c	Mon Oct  8 19:25:12 2001
@@ -41,6 +41,7 @@
 
 #define INFO_OUT_LEN 80		/* length of info line including lf */
 
+MODULE_LICENSE("GPL");
 /*************************************************/
 /* structure keeping ascii log for device output */
 /*************************************************/

--------------000103070906080802070806
Content-Type: text/plain;
 name="HYSDN4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HYSDN4"

--- drivers/isdn/hysdn/hysdn_proclog.c.old	Mon Oct  8 18:24:19 2001
+++ drivers/isdn/hysdn/hysdn_proclog.c	Mon Oct  8 19:22:31 2001
@@ -19,6 +19,7 @@
 #include <linux/smp_lock.h>
 
 #include "hysdn_defs.h"
+MODULE_LICENSE("GPL");
 
 /* the proc subdir for the interface is defined in the procconf module */
 extern struct proc_dir_entry *hysdn_proc_entry;

--------------000103070906080802070806
Content-Type: text/plain;
 name="XPRAM"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="XPRAM"

--- drivers/s390/block/xpram.c.old	Sun Sep 30 20:39:16 2001
+++ drivers/s390/block/xpram.c	Mon Oct  8 19:38:13 2001
@@ -175,6 +175,7 @@
 
 
 MODULE_PARM(devs,"i");
+MODULE_LICENSE("GPL");
 MODULE_PARM(sizes,"1-" __MODULE_STRING(XPRAM_MAX_DEVS) "i"); 
 
 MODULE_PARM_DESC(devs, "number of devices (\"partitions\"), " \

--------------000103070906080802070806
Content-Type: text/plain;
 name="LINCHR"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="LINCHR"

--- drivers/isdn/eicon/linchr.c.old	Mon Oct  8 18:24:12 2001
+++ drivers/isdn/eicon/linchr.c	Mon Oct  8 19:12:57 2001
@@ -27,6 +27,11 @@
 int DivasGetMem(mem_block_t *);
 
 #define DIA_IOCTL_UNLOCK 12
+
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+#endif
+
 void UnlockDivas(void);
 
 int do_ioctl(struct inode *pDivasInode, struct file *pDivasFile, 

--------------000103070906080802070806--

