Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbVFVKmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbVFVKmB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 06:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbVFVG4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:56:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:11420 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262786AbVFVFV5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:57 -0400
Cc: elenstev@mesatop.com
Subject: [PATCH] Spelling fixes for drivers/i2c.
In-Reply-To: <11194174631439@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:44 -0700
Message-Id: <11194174641612@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Spelling fixes for drivers/i2c.

 Here are some spelling corrections for drivers/i2c.

 occured -> occurred
 intialization -> initialization
 Everytime -> Every time
 transfering -> transferring
 relevent -> relevant
 continous -> continuous
 neccessary -> necessary
 explicitely -> explicitly
 Celcius -> Celsius
 differenciate -> differentiate

Signed-off-by: Steven Cole <elenstev@mesatop.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 44bbe87e9017efa050bb1b506c6822f1f3bb94d7
tree 62656712b3707592fb8fb8e152a200e71dbbb150
parent ec5ce552d946a55c1e504054627c9068fb7afb8a
author Steven Cole <elenstev@mesatop.com> Tue, 03 May 2005 18:21:25 -0600
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:55 -0700

 drivers/i2c/algos/i2c-algo-pca.c |    4 ++--
 drivers/i2c/busses/i2c-ibm_iic.c |    2 +-
 drivers/i2c/busses/i2c-iop3xx.c  |    2 +-
 drivers/i2c/busses/i2c-s3c2410.c |    2 +-
 drivers/i2c/chips/adm1031.c      |    2 +-
 drivers/i2c/chips/ds1621.c       |    4 ++--
 drivers/i2c/chips/it87.c         |    4 ++--
 drivers/i2c/chips/lm63.c         |    4 ++--
 drivers/i2c/chips/lm78.c         |    4 ++--
 drivers/i2c/chips/lm83.c         |    2 +-
 drivers/i2c/chips/lm90.c         |    8 ++++----
 11 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -49,7 +49,7 @@ static int i2c_debug=0;
 /*
  * Generate a start condition on the i2c bus.
  *
- * returns after the start condition has occured
+ * returns after the start condition has occurred
  */
 static void pca_start(struct i2c_algo_pca_data *adap)
 {
@@ -64,7 +64,7 @@ static void pca_start(struct i2c_algo_pc
 /*
  * Generate a repeated start condition on the i2c bus 
  *
- * return after the repeated start condition has occured
+ * return after the repeated start condition has occurred
  */
 static void pca_repeated_start(struct i2c_algo_pca_data *adap)
 {
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -695,7 +695,7 @@ static int __devinit iic_probe(struct oc
 
 	dev->irq = iic_force_poll ? -1 : ocp->def->irq;
 	if (dev->irq >= 0){
-		/* Disable interrupts until we finish intialization,
+		/* Disable interrupts until we finish initialization,
 		   assumes level-sensitive IRQ setup...
 		 */
 		iic_interrupt_mode(dev, 0);
diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -85,7 +85,7 @@ iop3xx_i2c_enable(struct i2c_algo_iop3xx
 	u32 cr = IOP3XX_ICR_GCD | IOP3XX_ICR_SCLEN | IOP3XX_ICR_UE;
 
 	/* 
-	 * Everytime unit enable is asserted, GPOD needs to be cleared
+	 * Every time unit enable is asserted, GPOD needs to be cleared
 	 * on IOP321 to avoid data corruption on the bus.
 	 */
 #ifdef CONFIG_ARCH_IOP321
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -534,7 +534,7 @@ static int s3c24xx_i2c_doxfer(struct s3c
 /* s3c24xx_i2c_xfer
  *
  * first port of call from the i2c bus code when an message needs
- * transfering across the i2c bus.
+ * transferring across the i2c bus.
 */
 
 static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
diff --git a/drivers/i2c/chips/adm1031.c b/drivers/i2c/chips/adm1031.c
--- a/drivers/i2c/chips/adm1031.c
+++ b/drivers/i2c/chips/adm1031.c
@@ -440,7 +440,7 @@ pwm_reg(2);
 
 /*
  * That function checks the cases where the fan reading is not
- * relevent.  It is used to provide 0 as fan reading when the fan is
+ * relevant.  It is used to provide 0 as fan reading when the fan is
  * not supposed to run
  */
 static int trust_fan_readings(struct adm1031_data *data, int chan)
diff --git a/drivers/i2c/chips/ds1621.c b/drivers/i2c/chips/ds1621.c
--- a/drivers/i2c/chips/ds1621.c
+++ b/drivers/i2c/chips/ds1621.c
@@ -121,7 +121,7 @@ static int ds1621_write_value(struct i2c
 static void ds1621_init_client(struct i2c_client *client)
 {
 	int reg = ds1621_read_value(client, DS1621_REG_CONF);
-	/* switch to continous conversion mode */
+	/* switch to continuous conversion mode */
 	reg &= ~ DS1621_REG_CONFIG_1SHOT;
 
 	/* setup output polarity */
@@ -303,7 +303,7 @@ static struct ds1621_data *ds1621_update
 		data->temp_max = ds1621_read_value(client,
 						    DS1621_REG_TEMP_MAX);
 
-		/* reset alarms if neccessary */
+		/* reset alarms if necessary */
 		new_conf = data->conf;
 		if (data->temp < data->temp_min)
 			new_conf &= ~DS1621_ALARM_TEMP_LOW;
diff --git a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c
+++ b/drivers/i2c/chips/it87.c
@@ -953,7 +953,7 @@ static int it87_detach_client(struct i2c
 	return 0;
 }
 
-/* The SMBus locks itself, but ISA access must be locked explicitely! 
+/* The SMBus locks itself, but ISA access must be locked explicitly! 
    We don't want to lock the whole ISA bus, so we lock each client
    separately.
    We ignore the IT87 BUSY flag at this moment - it could lead to deadlocks,
@@ -973,7 +973,7 @@ static int it87_read_value(struct i2c_cl
 		return i2c_smbus_read_byte_data(client, reg);
 }
 
-/* The SMBus locks itself, but ISA access muse be locked explicitely! 
+/* The SMBus locks itself, but ISA access muse be locked explicitly! 
    We don't want to lock the whole ISA bus, so we lock each client
    separately.
    We ignore the IT87 BUSY flag at this moment - it could lead to deadlocks,
diff --git a/drivers/i2c/chips/lm63.c b/drivers/i2c/chips/lm63.c
--- a/drivers/i2c/chips/lm63.c
+++ b/drivers/i2c/chips/lm63.c
@@ -98,9 +98,9 @@ SENSORS_INSMOD_1(lm63);
  * Conversions and various macros
  * For tachometer counts, the LM63 uses 16-bit values.
  * For local temperature and high limit, remote critical limit and hysteresis
- * value, it uses signed 8-bit values with LSB = 1 degree Celcius.
+ * value, it uses signed 8-bit values with LSB = 1 degree Celsius.
  * For remote temperature, low and high limits, it uses signed 11-bit values
- * with LSB = 0.125 degree Celcius, left-justified in 16-bit registers.
+ * with LSB = 0.125 degree Celsius, left-justified in 16-bit registers.
  */
 
 #define FAN_FROM_REG(reg)	((reg) == 0xFFFC || (reg) == 0 ? 0 : \
diff --git a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c
+++ b/drivers/i2c/chips/lm78.c
@@ -670,7 +670,7 @@ static int lm78_detach_client(struct i2c
 	return 0;
 }
 
-/* The SMBus locks itself, but ISA access must be locked explicitely! 
+/* The SMBus locks itself, but ISA access must be locked explicitly! 
    We don't want to lock the whole ISA bus, so we lock each client
    separately.
    We ignore the LM78 BUSY flag at this moment - it could lead to deadlocks,
@@ -689,7 +689,7 @@ static int lm78_read_value(struct i2c_cl
 		return i2c_smbus_read_byte_data(client, reg);
 }
 
-/* The SMBus locks itself, but ISA access muse be locked explicitely! 
+/* The SMBus locks itself, but ISA access muse be locked explicitly! 
    We don't want to lock the whole ISA bus, so we lock each client
    separately.
    We ignore the LM78 BUSY flag at this moment - it could lead to deadlocks,
diff --git a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c
+++ b/drivers/i2c/chips/lm83.c
@@ -80,7 +80,7 @@ SENSORS_INSMOD_1(lm83);
 
 /*
  * Conversions and various macros
- * The LM83 uses signed 8-bit values with LSB = 1 degree Celcius.
+ * The LM83 uses signed 8-bit values with LSB = 1 degree Celsius.
  */
 
 #define TEMP_FROM_REG(val)	((val) * 1000)
diff --git a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c
+++ b/drivers/i2c/chips/lm90.c
@@ -19,7 +19,7 @@
  * Complete datasheets can be obtained from National's website at:
  *   http://www.national.com/pf/LM/LM89.html
  *   http://www.national.com/pf/LM/LM99.html
- * Note that there is no way to differenciate between both chips.
+ * Note that there is no way to differentiate between both chips.
  *
  * This driver also supports the LM86, another sensor chip made by
  * National Semiconductor. It is exactly similar to the LM90 except it
@@ -39,7 +39,7 @@
  * chips made by Maxim. These chips are similar to the LM86. Complete
  * datasheet can be obtained at Maxim's website at:
  *   http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
- * Note that there is no easy way to differenciate between the three
+ * Note that there is no easy way to differentiate between the three
  * variants. The extra address and features of the MAX6659 are not
  * supported by this driver.
  *
@@ -138,9 +138,9 @@ SENSORS_INSMOD_6(lm90, adm1032, lm99, lm
 /*
  * Conversions and various macros
  * For local temperatures and limits, critical limits and the hysteresis
- * value, the LM90 uses signed 8-bit values with LSB = 1 degree Celcius.
+ * value, the LM90 uses signed 8-bit values with LSB = 1 degree Celsius.
  * For remote temperatures and limits, it uses signed 11-bit values with
- * LSB = 0.125 degree Celcius, left-justified in 16-bit registers.
+ * LSB = 0.125 degree Celsius, left-justified in 16-bit registers.
  */
 
 #define TEMP1_FROM_REG(val)	((val) * 1000)

