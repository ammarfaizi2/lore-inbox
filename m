Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262879AbVFVHSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbVFVHSt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVFVHQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:16:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:63899 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262776AbVFVFVx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:53 -0400
Cc: adobriyan@mail.ru
Subject: [PATCH] I2C: drivers/i2c/*: #include <linux/config.h> cleanup
In-Reply-To: <11194174631273@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:43 -0700
Message-Id: <11194174631518@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 8BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: drivers/i2c/*: #include <linux/config.h> cleanup

Files that don't use CONFIG_* stuff shouldn't include config.h
Files that use CONFIG_* stuff should include config.h

It's that simple. ;-)

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit f0bb60e7b1a0a26c25d8cbf81dda7afbc8bd2982
tree 93dc5302d0299e8167c2affc1d65a705219c0d88
parent da17838c5e7256976c34c5d051dc8fb3c6f364b7
author Alexey Dobriyan <adobriyan@mail.ru> Sat, 16 Apr 2005 18:10:02 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:53 -0700

 drivers/i2c/algos/i2c-algo-sibyte.c    |    1 -
 drivers/i2c/busses/i2c-ali1535.c       |    1 -
 drivers/i2c/busses/i2c-ali15x3.c       |    1 -
 drivers/i2c/busses/i2c-amd756.c        |    1 -
 drivers/i2c/busses/i2c-amd8111.c       |    1 -
 drivers/i2c/busses/i2c-au1550.c        |    1 -
 drivers/i2c/busses/i2c-elektor.c       |    1 -
 drivers/i2c/busses/i2c-frodo.c         |    1 -
 drivers/i2c/busses/i2c-i801.c          |    1 -
 drivers/i2c/busses/i2c-i810.c          |    1 -
 drivers/i2c/busses/i2c-ibm_iic.h       |    1 -
 drivers/i2c/busses/i2c-isa.c           |    1 -
 drivers/i2c/busses/i2c-ite.c           |    1 -
 drivers/i2c/busses/i2c-keywest.c       |    1 -
 drivers/i2c/busses/i2c-nforce2.c       |    1 -
 drivers/i2c/busses/i2c-parport-light.c |    1 -
 drivers/i2c/busses/i2c-parport.c       |    1 -
 drivers/i2c/busses/i2c-pca-isa.c       |    1 -
 drivers/i2c/busses/i2c-piix4.c         |    1 -
 drivers/i2c/busses/i2c-prosavage.c     |    1 -
 drivers/i2c/busses/i2c-rpx.c           |    1 -
 drivers/i2c/busses/i2c-s3c2410.c       |    1 +
 drivers/i2c/busses/i2c-savage4.c       |    1 -
 drivers/i2c/busses/i2c-sibyte.c        |    1 -
 drivers/i2c/busses/i2c-sis5595.c       |    1 -
 drivers/i2c/busses/i2c-sis630.c        |    1 -
 drivers/i2c/busses/i2c-sis96x.c        |    1 -
 drivers/i2c/busses/i2c-stub.c          |    1 -
 drivers/i2c/busses/i2c-via.c           |    1 -
 drivers/i2c/busses/i2c-viapro.c        |    1 -
 drivers/i2c/busses/i2c-voodoo3.c       |    1 -
 drivers/i2c/busses/scx200_acb.c        |    1 -
 drivers/i2c/chips/adm1021.c            |    1 -
 drivers/i2c/chips/adm1025.c            |    1 -
 drivers/i2c/chips/adm1026.c            |    1 -
 drivers/i2c/chips/ds1337.c             |    1 -
 drivers/i2c/chips/eeprom.c             |    1 -
 drivers/i2c/chips/fscher.c             |    1 -
 drivers/i2c/chips/gl518sm.c            |    1 -
 drivers/i2c/chips/it87.c               |    1 -
 drivers/i2c/chips/lm63.c               |    1 -
 drivers/i2c/chips/lm75.c               |    1 -
 drivers/i2c/chips/lm77.c               |    1 -
 drivers/i2c/chips/lm78.c               |    1 -
 drivers/i2c/chips/lm80.c               |    1 -
 drivers/i2c/chips/lm83.c               |    1 -
 drivers/i2c/chips/lm85.c               |    1 -
 drivers/i2c/chips/lm87.c               |    1 -
 drivers/i2c/chips/lm90.c               |    1 -
 drivers/i2c/chips/max1619.c            |    1 -
 drivers/i2c/chips/pc87360.c            |    1 -
 drivers/i2c/chips/via686a.c            |    1 -
 drivers/i2c/chips/w83781d.c            |    1 -
 drivers/i2c/chips/w83l785ts.c          |    1 -
 drivers/i2c/i2c-core.c                 |    1 -
 drivers/i2c/i2c-dev.c                  |    1 -
 56 files changed, 1 insertions(+), 55 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-sibyte.c b/drivers/i2c/algos/i2c-algo-sibyte.c
--- a/drivers/i2c/algos/i2c-algo-sibyte.c
+++ b/drivers/i2c/algos/i2c-algo-sibyte.c
@@ -24,7 +24,6 @@
 
 /* Ported for SiByte SOCs by Broadcom Corporation.  */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -53,7 +53,6 @@
 
 /* Note: we assume there can only be one ALI1535, with one SMBus interface */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c
+++ b/drivers/i2c/busses/i2c-ali15x3.c
@@ -60,7 +60,6 @@
 
 /* Note: we assume there can only be one ALI15X3, with one SMBus interface */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c
+++ b/drivers/i2c/busses/i2c-amd756.c
@@ -37,7 +37,6 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c
+++ b/drivers/i2c/busses/i2c-amd8111.c
@@ -8,7 +8,6 @@
  * the Free Software Foundation version 2.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -27,7 +27,6 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
 
-#include <linux/config.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- a/drivers/i2c/busses/i2c-elektor.c
+++ b/drivers/i2c/busses/i2c-elektor.c
@@ -25,7 +25,6 @@
 /* Partialy rewriten by Oleg I. Vdovikin for mmapped support of 
    for Alpha Processor Inc. UP-2000(+) boards */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
diff --git a/drivers/i2c/busses/i2c-frodo.c b/drivers/i2c/busses/i2c-frodo.c
--- a/drivers/i2c/busses/i2c-frodo.c
+++ b/drivers/i2c/busses/i2c-frodo.c
@@ -12,7 +12,6 @@
  * version 2 as published by the Free Software Foundation.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -41,7 +41,6 @@
 
 /* Note: we assume there can only be one I801, with one SMBus interface */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-i810.c b/drivers/i2c/busses/i2c-i810.c
--- a/drivers/i2c/busses/i2c-i810.c
+++ b/drivers/i2c/busses/i2c-i810.c
@@ -34,7 +34,6 @@
    i815			1132           
 */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/i2c/busses/i2c-ibm_iic.h b/drivers/i2c/busses/i2c-ibm_iic.h
--- a/drivers/i2c/busses/i2c-ibm_iic.h
+++ b/drivers/i2c/busses/i2c-ibm_iic.h
@@ -22,7 +22,6 @@
 #ifndef __I2C_IBM_IIC_H_
 #define __I2C_IBM_IIC_H_
 
-#include <linux/config.h>
 #include <linux/i2c.h> 
 
 struct iic_regs {
diff --git a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
--- a/drivers/i2c/busses/i2c-isa.c
+++ b/drivers/i2c/busses/i2c-isa.c
@@ -24,7 +24,6 @@
    the SMBus and the ISA bus very much easier. See lm78.c for an example
    of this. */
 
-#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-ite.c b/drivers/i2c/busses/i2c-ite.c
--- a/drivers/i2c/busses/i2c-ite.c
+++ b/drivers/i2c/busses/i2c-ite.c
@@ -33,7 +33,6 @@
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
diff --git a/drivers/i2c/busses/i2c-keywest.c b/drivers/i2c/busses/i2c-keywest.c
--- a/drivers/i2c/busses/i2c-keywest.c
+++ b/drivers/i2c/busses/i2c-keywest.c
@@ -46,7 +46,6 @@
     sound driver to be happy
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -37,7 +37,6 @@
 
 /* Note: we assume there can only be one nForce2, with two SMBus interfaces */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/i2c-parport-light.c
--- a/drivers/i2c/busses/i2c-parport-light.c
+++ b/drivers/i2c/busses/i2c-parport-light.c
@@ -24,7 +24,6 @@
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * ------------------------------------------------------------------------ */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
--- a/drivers/i2c/busses/i2c-parport.c
+++ b/drivers/i2c/busses/i2c-parport.c
@@ -24,7 +24,6 @@
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * ------------------------------------------------------------------------ */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-pca-isa.c
--- a/drivers/i2c/busses/i2c-pca-isa.c
+++ b/drivers/i2c/busses/i2c-pca-isa.c
@@ -17,7 +17,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -28,7 +28,6 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/pci.h>
diff --git a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
--- a/drivers/i2c/busses/i2c-prosavage.c
+++ b/drivers/i2c/busses/i2c-prosavage.c
@@ -54,7 +54,6 @@
  *    (Additional documentation needed :(
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
diff --git a/drivers/i2c/busses/i2c-rpx.c b/drivers/i2c/busses/i2c-rpx.c
--- a/drivers/i2c/busses/i2c-rpx.c
+++ b/drivers/i2c/busses/i2c-rpx.c
@@ -11,7 +11,6 @@
  * changed to eliminate RPXLite references.
  */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -20,6 +20,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
 
+#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 
diff --git a/drivers/i2c/busses/i2c-savage4.c b/drivers/i2c/busses/i2c-savage4.c
--- a/drivers/i2c/busses/i2c-savage4.c
+++ b/drivers/i2c/busses/i2c-savage4.c
@@ -29,7 +29,6 @@
    it easier to add later.
 */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/i2c/busses/i2c-sibyte.c b/drivers/i2c/busses/i2c-sibyte.c
--- a/drivers/i2c/busses/i2c-sibyte.c
+++ b/drivers/i2c/busses/i2c-sibyte.c
@@ -17,7 +17,6 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/i2c-algo-sibyte.h>
 #include <asm/sibyte/sb1250_regs.h>
diff --git a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c
+++ b/drivers/i2c/busses/i2c-sis5595.c
@@ -55,7 +55,6 @@
  * Add adapter resets
  */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -48,7 +48,6 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
diff --git a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
--- a/drivers/i2c/busses/i2c-sis96x.c
+++ b/drivers/i2c/busses/i2c-sis96x.c
@@ -32,7 +32,6 @@
     We assume there can only be one SiS96x with one SMBus interface.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-stub.c b/drivers/i2c/busses/i2c-stub.c
--- a/drivers/i2c/busses/i2c-stub.c
+++ b/drivers/i2c/busses/i2c-stub.c
@@ -21,7 +21,6 @@
 
 #define DEBUG 1
 
-#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
--- a/drivers/i2c/busses/i2c-via.c
+++ b/drivers/i2c/busses/i2c-via.c
@@ -21,7 +21,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c
+++ b/drivers/i2c/busses/i2c-viapro.c
@@ -33,7 +33,6 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
diff --git a/drivers/i2c/busses/i2c-voodoo3.c b/drivers/i2c/busses/i2c-voodoo3.c
--- a/drivers/i2c/busses/i2c-voodoo3.c
+++ b/drivers/i2c/busses/i2c-voodoo3.c
@@ -27,7 +27,6 @@
 /* This interfaces to the I2C bus of the Voodoo3 to gain access to
     the BT869 and possibly other I2C devices. */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -24,7 +24,6 @@
 
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
diff --git a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c
+++ b/drivers/i2c/chips/adm1021.c
@@ -19,7 +19,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/adm1025.c b/drivers/i2c/chips/adm1025.c
--- a/drivers/i2c/chips/adm1025.c
+++ b/drivers/i2c/chips/adm1025.c
@@ -45,7 +45,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/adm1026.c b/drivers/i2c/chips/adm1026.c
--- a/drivers/i2c/chips/adm1026.c
+++ b/drivers/i2c/chips/adm1026.c
@@ -23,7 +23,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -13,7 +13,6 @@
  * Driver for Dallas Semiconductor DS1337 and DS1339 real time clock chip
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c
+++ b/drivers/i2c/chips/eeprom.c
@@ -26,7 +26,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c
+++ b/drivers/i2c/chips/fscher.c
@@ -26,7 +26,6 @@
  *  and Philip Edelbrock <phil@netroedge.com>
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/gl518sm.c b/drivers/i2c/chips/gl518sm.c
--- a/drivers/i2c/chips/gl518sm.c
+++ b/drivers/i2c/chips/gl518sm.c
@@ -36,7 +36,6 @@
  * 2004-01-31  Code review and approval. (Jean Delvare)
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c
+++ b/drivers/i2c/chips/it87.c
@@ -31,7 +31,6 @@
     type at module load time.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/lm63.c b/drivers/i2c/chips/lm63.c
--- a/drivers/i2c/chips/lm63.c
+++ b/drivers/i2c/chips/lm63.c
@@ -37,7 +37,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c
+++ b/drivers/i2c/chips/lm75.c
@@ -18,7 +18,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/lm77.c b/drivers/i2c/chips/lm77.c
--- a/drivers/i2c/chips/lm77.c
+++ b/drivers/i2c/chips/lm77.c
@@ -25,7 +25,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c
+++ b/drivers/i2c/chips/lm78.c
@@ -18,7 +18,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/lm80.c b/drivers/i2c/chips/lm80.c
--- a/drivers/i2c/chips/lm80.c
+++ b/drivers/i2c/chips/lm80.c
@@ -21,7 +21,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c
+++ b/drivers/i2c/chips/lm83.c
@@ -27,7 +27,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c
+++ b/drivers/i2c/chips/lm85.c
@@ -23,7 +23,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/lm87.c b/drivers/i2c/chips/lm87.c
--- a/drivers/i2c/chips/lm87.c
+++ b/drivers/i2c/chips/lm87.c
@@ -52,7 +52,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c
+++ b/drivers/i2c/chips/lm90.c
@@ -70,7 +70,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/max1619.c b/drivers/i2c/chips/max1619.c
--- a/drivers/i2c/chips/max1619.c
+++ b/drivers/i2c/chips/max1619.c
@@ -26,7 +26,6 @@
  */
 
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/pc87360.c b/drivers/i2c/chips/pc87360.c
--- a/drivers/i2c/chips/pc87360.c
+++ b/drivers/i2c/chips/pc87360.c
@@ -33,7 +33,6 @@
  *  the standard Super-I/O addresses is used (0x2E/0x2F or 0x4E/0x4F).
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c
+++ b/drivers/i2c/chips/via686a.c
@@ -30,7 +30,6 @@
     Warning - only supports a single device.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
diff --git a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c
+++ b/drivers/i2c/chips/w83781d.c
@@ -35,7 +35,6 @@
 
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c
+++ b/drivers/i2c/chips/w83l785ts.c
@@ -30,7 +30,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -21,7 +21,6 @@
    All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl>
    SMBus 2.0 support by Mark Studebaker <mdsxyz123@yahoo.com>                */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -29,7 +29,6 @@
 /* The devfs code is contributed by Philipp Matthias Hahn 
    <pmhahn@titan.lahn.de> */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/fs.h>

