Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbUCPQYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbUCPQYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:24:10 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:6162 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264011AbUCPQXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:23:42 -0500
Date: Tue, 16 Mar 2004 10:34:55 -0600
From: mikem@beardog.cca.cpqcorp.net
To: axboe@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: cpqarray patches for 2.6 [1 of 5]
Message-ID: <20040316163455.GA21377@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch bumps the driver version to 2.6.0. Please apply in order. 

Thanks,
mikem
-------------------------------------------------------------------------------
 drivers/block/cpqarray.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.1/drivers/block/cpqarray.c~cpqarray_version_2.6.x	2004-02-11 17:55:04.593834216 -0600
+++ linux-2.6.1-root/drivers/block/cpqarray.c	2004-02-11 17:57:28.923892712 -0600
@@ -16,7 +16,7 @@
  *    along with this program; if not, write to the Free Software
  *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- *    Questions/Comments/Bugfixes to arrays@compaq.com
+ *    Questions/Comments/Bugfixes to Cpqarray-discuss@lists.sourceforge.net
  *
  */
 #include <linux/config.h>	/* CONFIG_PROC_FS */
@@ -46,13 +46,13 @@
 
 #define SMART2_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
 
-#define DRIVER_NAME "Compaq SMART2 Driver (v 2.4.5)"
-#define DRIVER_VERSION SMART2_DRIVER_VERSION(2,4,5)
+#define DRIVER_NAME "Compaq SMART2 Driver (v 2.6.0)"
+#define DRIVER_VERSION SMART2_DRIVER_VERSION(2,6,0)
 
 /* Embedded module documentation macros - see modules.h */
 /* Original author Chris Frantz - Compaq Computer Corporation */
 MODULE_AUTHOR("Compaq Computer Corporation");
-MODULE_DESCRIPTION("Driver for Compaq Smart2 Array Controllers");
+MODULE_DESCRIPTION("Driver for Compaq Smart2 Array Controllers version 2.6.0");
 MODULE_LICENSE("GPL");
 
 #include "cpqarray.h"

_
