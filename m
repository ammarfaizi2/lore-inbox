Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWBKWmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWBKWmr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 17:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWBKWmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 17:42:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22030 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750775AbWBKWmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 17:42:47 -0500
Date: Sat, 11 Feb 2006 23:42:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "V. Ananda Krishnan" <mansarov@us.ibm.com>
Cc: Scott_Kilau@digi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove the no longer valid contact information for Wendy Xiong
Message-ID: <20060211224245.GG30922@stusta.de>
References: <20060211164504.GC30922@stusta.de> <43EE5D4C.3040203@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EE5D4C.3040203@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 03:55:24PM -0600, V. Ananda Krishnan wrote:
> Adrian Bunk wrote:
> >The email address wendyx@us.ltcfwd.linux.ibm.com of Wendy Xiong present 
> >in three files under drivers/serial/jsm/ is bouncing.
> >
> >Is there a new address, or should the old one simply be removed?
> >
> Thanks Adrian. Please remove Wendy's name for now.
>...

Patch below.

> Regards,
> V. Ananda Krishnan

cu
Adrian


<--  snip  -->


This patch removes the no longer valid contact information for 
Wendy Xiong.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/serial/jsm/jsm.h        |    1 -
 drivers/serial/jsm/jsm_driver.c |    1 -
 drivers/serial/jsm/jsm_neo.c    |    1 -
 3 files changed, 3 deletions(-)

--- linux-2.6.16-rc2-mm1-full/drivers/serial/jsm/jsm.h.old	2006-02-11 17:42:10.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/drivers/serial/jsm/jsm.h	2006-02-11 23:22:35.000000000 +0100
@@ -20,7 +20,6 @@
  *
  * Contact Information:
  * Scott H Kilau <Scott_Kilau@digi.com>
- * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
  *
  ***********************************************************************/
 
--- linux-2.6.16-rc2-mm1-full/drivers/serial/jsm/jsm_driver.c.old	2006-02-11 17:42:29.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/drivers/serial/jsm/jsm_driver.c	2006-02-11 23:22:50.000000000 +0100
@@ -20,7 +20,6 @@
  *
  * Contact Information:
  * Scott H Kilau <Scott_Kilau@digi.com>
- * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
  *
  *
  ***********************************************************************/
--- linux-2.6.16-rc2-mm1-full/drivers/serial/jsm/jsm_neo.c.old	2006-02-11 23:23:10.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/drivers/serial/jsm/jsm_neo.c	2006-02-11 23:23:13.000000000 +0100
@@ -20,7 +20,6 @@
  *
  * Contact Information:
  * Scott H Kilau <Scott_Kilau@digi.com>
- * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
  *
  ***********************************************************************/
 #include <linux/delay.h>	/* For udelay */

