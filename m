Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263780AbTCUSq3>; Fri, 21 Mar 2003 13:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263772AbTCUSpC>; Fri, 21 Mar 2003 13:45:02 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19588
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263780AbTCUSoq>; Fri, 21 Mar 2003 13:44:46 -0500
Date: Fri, 21 Mar 2003 20:00:00 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212000.h2LK00Br026169@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove __NO_VERSION__ in mtd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/mtd/nftlmount.c linux-2.5.65-ac2/drivers/mtd/nftlmount.c
--- linux-2.5.65/drivers/mtd/nftlmount.c	2003-02-10 18:37:58.000000000 +0000
+++ linux-2.5.65-ac2/drivers/mtd/nftlmount.c	2003-03-14 00:52:15.000000000 +0000
@@ -21,7 +21,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#define __NO_VERSION__
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <asm/errno.h>
