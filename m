Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUFGMKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUFGMKP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264648AbUFGMIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:08:49 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:14209 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264627AbUFGL5V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:57:21 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093541162@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093542390@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:54 +0200
Subject: [PATCH 29/39] input: Trailing whitespace fixes in drivers/input/joystick
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1587.27.9, 2004-05-10 01:34:21-05:00, dtor_core@ameritech.net
  Input: trailing whitespace fixes in drivers/input/joystick


 Kconfig                 |   16 ++++++++--------
 a3d.c                   |   14 +++++++-------
 adi.c                   |   30 +++++++++++++++---------------
 amijoy.c                |    2 +-
 analog.c                |   42 +++++++++++++++++++++---------------------
 cobra.c                 |   10 +++++-----
 db9.c                   |   24 ++++++++++++------------
 gamecon.c               |   32 ++++++++++++++++----------------
 gf2k.c                  |   12 ++++++------
 grip.c                  |    6 +++---
 grip_mp.c               |   44 ++++++++++++++++++++++----------------------
 guillemot.c             |    8 ++++----
 iforce/Kconfig          |    2 +-
 iforce/Makefile         |    6 +++---
 iforce/iforce-ff.c      |    4 ++--
 iforce/iforce-main.c    |    4 ++--
 iforce/iforce-packets.c |    4 ++--
 iforce/iforce-serio.c   |    2 +-
 iforce/iforce.h         |    2 +-
 interact.c              |    8 ++++----
 joydump.c               |   10 +++++-----
 magellan.c              |   12 ++++++------
 sidewinder.c            |   20 ++++++++++----------
 spaceball.c             |   20 ++++++++++----------
 spaceorb.c              |   18 +++++++++---------
 stinger.c               |    6 +++---
 tmdc.c                  |   24 ++++++++++++------------
 turbografx.c            |   20 ++++++++++----------
 twidjoy.c               |    6 +++---
 warrior.c               |   32 ++++++++++++++++----------------
 30 files changed, 220 insertions(+), 220 deletions(-)

===================================================================

diff -Nru a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
--- a/drivers/input/joystick/Kconfig	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/Kconfig	2004-06-07 13:11:12 +02:00
@@ -22,7 +22,7 @@
 	  supports many extensions, including joysticks with throttle control,
 	  with rudders, additional hats and buttons compatible with CH
 	  Flightstick Pro, ThrustMaster FCS, 6 and 8 button gamepads, or
-	  Saitek Cyborg joysticks. 
+	  Saitek Cyborg joysticks.
 
 	  Please read the file <file:Documentation/input/joystick.txt> which
 	  contains more information.
@@ -35,7 +35,7 @@
 	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
 	help
 	  Say Y here if you have an FPGaming or MadCatz controller using the
-	  A3D protocol over the PC gameport. 
+	  A3D protocol over the PC gameport.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called a3d.
@@ -45,7 +45,7 @@
 	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
 	help
 	  Say Y here if you have a Logitech controller using the ADI
-	  protocol over the PC gameport. 
+	  protocol over the PC gameport.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called adi.
@@ -74,7 +74,7 @@
 	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
 	help
 	  Say Y here if you have a Gravis controller using the GrIP protocol
-	  over the PC gameport. 
+	  over the PC gameport.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called grip.
@@ -94,7 +94,7 @@
 	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
 	help
 	  Say Y here if you have a Guillemot joystick using a digital
-	  protocol over the PC gameport. 
+	  protocol over the PC gameport.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called guillemot.
@@ -124,7 +124,7 @@
 	depends on INPUT && INPUT_JOYSTICK && GAMEPORT
 	help
 	  Say Y here if you have a ThrustMaster controller using the
-	  DirectConnect (BSP) protocol over the PC gameport. 
+	  DirectConnect (BSP) protocol over the PC gameport.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called tmdc.
@@ -137,7 +137,7 @@
 	select SERIO
 	help
 	  Say Y here if you have a Logitech WingMan Warrior joystick connected
-	  to your computer's serial port. 
+	  to your computer's serial port.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called warrior.
@@ -253,7 +253,7 @@
 	help
 	  Say Y here if you want to dump data from your joystick into the system
 	  log for debugging purposes. Say N if you are making a production
-	  configuration or aren't sure. 
+	  configuration or aren't sure.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called joydump.
diff -Nru a/drivers/input/joystick/a3d.c b/drivers/input/joystick/a3d.c
--- a/drivers/input/joystick/a3d.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/a3d.c	2004-06-07 13:11:12 +02:00
@@ -39,8 +39,8 @@
 MODULE_DESCRIPTION("FP-Gaming Assasin 3D joystick driver");
 MODULE_LICENSE("GPL");
 
-#define A3D_MAX_START		400	/* 400 us */ 
-#define A3D_MAX_STROBE		60	/* 40 us */ 
+#define A3D_MAX_START		400	/* 400 us */
+#define A3D_MAX_STROBE		60	/* 40 us */
 #define A3D_DELAY_READ		3	/* 3 ms */
 #define A3D_MAX_LENGTH		40	/* 40*3 bits */
 #define A3D_REFRESH_TIME	HZ/50	/* 20 ms */
@@ -125,7 +125,7 @@
 
 			input_report_rel(dev, REL_X, ((data[5] << 6) | (data[6] << 3) | data[ 7]) - ((data[5] & 4) << 7));
 			input_report_rel(dev, REL_Y, ((data[8] << 6) | (data[9] << 3) | data[10]) - ((data[8] & 4) << 7));
-			
+
 			input_report_key(dev, BTN_RIGHT,  data[2] & 1);
 			input_report_key(dev, BTN_LEFT,   data[3] & 2);
 			input_report_key(dev, BTN_MIDDLE, data[3] & 4);
@@ -201,7 +201,7 @@
 	int i;
 	for (i = 0; i < 4; i++)
 		axes[i] = (a3d->axes[i] < 254) ? a3d->axes[i] : -1;
-	*buttons = a3d->buttons; 
+	*buttons = a3d->buttons;
 	return 0;
 }
 
@@ -216,7 +216,7 @@
 	if (mode != GAMEPORT_MODE_COOKED)
 		return -1;
 	if (!a3d->used++)
-		mod_timer(&a3d->timer, jiffies + A3D_REFRESH_TIME);	
+		mod_timer(&a3d->timer, jiffies + A3D_REFRESH_TIME);
 	return 0;
 }
 
@@ -239,7 +239,7 @@
 {
 	struct a3d *a3d = dev->private;
 	if (!a3d->used++)
-		mod_timer(&a3d->timer, jiffies + A3D_REFRESH_TIME);	
+		mod_timer(&a3d->timer, jiffies + A3D_REFRESH_TIME);
 	return 0;
 }
 
@@ -340,7 +340,7 @@
 		a3d->adc.open = a3d_adc_open;
 		a3d->adc.close = a3d_adc_close;
 		a3d->adc.cooked_read = a3d_adc_cooked_read;
-		a3d->adc.fuzz = 1; 
+		a3d->adc.fuzz = 1;
 
 		a3d->adc.name = a3d_names[a3d->mode];
 		a3d->adc.phys = a3d->adcphys;
diff -Nru a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
--- a/drivers/input/joystick/adi.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/adi.c	2004-06-07 13:11:12 +02:00
@@ -11,18 +11,18 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  * Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
@@ -72,8 +72,8 @@
  */
 
 static char *adi_names[] = {	"WingMan Extreme Digital", "ThunderPad Digital", "SideCar", "CyberMan 2",
-				"WingMan Interceptor", "WingMan Formula", "WingMan GamePad", 
-				"WingMan Extreme Digital 3D", "WingMan GamePad Extreme", 
+				"WingMan Interceptor", "WingMan Formula", "WingMan GamePad",
+				"WingMan Extreme Digital 3D", "WingMan GamePad Extreme",
 				"WingMan GamePad USB", "Unknown Device %#x" };
 
 static char adi_wmgpe_abs[] =	{ ABS_X, ABS_Y, ABS_HAT0X, ABS_HAT0Y };
@@ -178,7 +178,7 @@
 
 /*
  * adi_move_bits() detects a possible 2-stream mode, and moves
- * the bits accordingly. 
+ * the bits accordingly.
  */
 
 static void adi_move_bits(struct adi_port *port, int length)
@@ -208,7 +208,7 @@
 	int i;
 	if ((adi->idx += count) > adi->ret) return 0;
 	for (i = 0; i < count; i++)
-		bits |= ((adi->data[adi->idx - i] >> 5) & 1) << i; 
+		bits |= ((adi->data[adi->idx - i] >> 5) & 1) << i;
 	return bits;
 }
 
@@ -224,12 +224,12 @@
 	int i, t;
 
 	if (adi->ret < adi->length || adi->id != (adi_get_bits(adi, 4) | (adi_get_bits(adi, 4) << 4)))
-		return -1;	
+		return -1;
 
-	for (i = 0; i < adi->axes10; i++) 
+	for (i = 0; i < adi->axes10; i++)
 		input_report_abs(dev, *abs++, adi_get_bits(adi, 10));
 
-	for (i = 0; i < adi->axes8; i++) 
+	for (i = 0; i < adi->axes8; i++)
 		input_report_abs(dev, *abs++, adi_get_bits(adi, 8));
 
 	for (i = 0; i < adi->buttons && i < 63; i++) {
@@ -249,7 +249,7 @@
 
 	for (i = 63; i < adi->buttons; i++)
 		input_report_key(dev, *key++, adi_get_bits(adi, 1));
-	
+
 	input_sync(dev);
 
 	return 0;
@@ -294,7 +294,7 @@
 {
 	struct adi_port *port = dev->private;
 	if (!port->used++)
-		mod_timer(&port->timer, jiffies + ADI_REFRESH_TIME);	
+		mod_timer(&port->timer, jiffies + ADI_REFRESH_TIME);
 	return 0;
 }
 
@@ -334,7 +334,7 @@
 		return;
 
 	if (adi->ret < (t = adi_get_bits(adi, 10))) {
-		printk(KERN_WARNING "adi: Short ID packet: reported: %d != read: %d\n", t, adi->ret); 
+		printk(KERN_WARNING "adi: Short ID packet: reported: %d != read: %d\n", t, adi->ret);
 		return;
 	}
 
@@ -498,7 +498,7 @@
 
 	adi_init_digital(gameport);
 	adi_read_packet(port);
-	
+
 	if (port->adi[0].ret >= ADI_MIN_LEN_LENGTH)
 		adi_move_bits(port, adi_get_bits(port->adi, 10));
 
diff -Nru a/drivers/input/joystick/amijoy.c b/drivers/input/joystick/amijoy.c
--- a/drivers/input/joystick/amijoy.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/amijoy.c	2004-06-07 13:11:12 +02:00
@@ -46,7 +46,7 @@
 MODULE_LICENSE("GPL");
 
 static int amijoy[2] = { 0, 1 };
-static int amijoy_nargs;  
+static int amijoy_nargs;
 module_param_array_named(map, amijoy, uint, amijoy_nargs, 0);
 MODULE_PARM_DESC(map, "Map of attached joysticks in form of <a>,<b> (default is 0,1)");
 
diff -Nru a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
--- a/drivers/input/joystick/analog.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/analog.c	2004-06-07 13:11:12 +02:00
@@ -11,18 +11,18 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  * Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
@@ -237,7 +237,7 @@
 
 	loopout = (ANALOG_LOOP_TIME * port->loop) / 1000;
 	timeout = ANALOG_MAX_TIME * port->speed;
-	
+
 	local_irq_save(flags);
 	gameport_trigger(gameport);
 	GET_TIME(now);
@@ -284,7 +284,7 @@
 
 	u = gameport_read(port->gameport);
 
-	if (!chf) { 
+	if (!chf) {
 		port->buttons = (~u >> 4) & 0xf;
 		return 0;
 	}
@@ -333,7 +333,7 @@
 		}
 	}
 
-	for (i = 0; i < 2; i++) 
+	for (i = 0; i < 2; i++)
 		if (port->analog[i].mask)
 			analog_decode(port->analog + i, port->axes, port->initial, port->buttons);
 
@@ -348,7 +348,7 @@
 {
 	struct analog_port *port = dev->private;
 	if (!port->used++)
-		mod_timer(&port->timer, jiffies + ANALOG_REFRESH_TIME);	
+		mod_timer(&port->timer, jiffies + ANALOG_REFRESH_TIME);
 	return 0;
 }
 
@@ -408,7 +408,7 @@
 
 static void analog_name(struct analog *analog)
 {
-	sprintf(analog->name, "Analog %d-axis %d-button", 
+	sprintf(analog->name, "Analog %d-axis %d-button",
 		hweight8(analog->mask & ANALOG_AXES_STD),
 		hweight8(analog->mask & ANALOG_BTNS_STD) + !!(analog->mask & ANALOG_BTNS_CHF) * 2 +
 		hweight16(analog->mask & ANALOG_BTNS_GAMEPAD) + !!(analog->mask & ANALOG_HBTN_CHF) * 4);
@@ -450,10 +450,10 @@
 	analog->dev.close = analog_close;
 	analog->dev.private = port;
 	analog->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-	
+
 	for (i = j = 0; i < 4; i++)
 		if (analog->mask & (1 << i)) {
-			
+
 			t = analog_axes[j];
 			x = port->axes[i];
 			y = (port->axes[0] + port->axes[1]) >> 1;
@@ -481,8 +481,8 @@
 			j++;
 		}
 
-	for (i = j = 0; i < 3; i++) 
-		if (analog->mask & analog_exts[i]) 
+	for (i = j = 0; i < 3; i++)
+		if (analog->mask & analog_exts[i])
 			for (x = 0; x < 2; x++) {
 				t = analog_hats[j++];
 				set_bit(t, analog->dev.absbit);
@@ -517,7 +517,7 @@
 	else
 		printk(" [%s timer, %d %sHz clock, %d ns res]\n", TIME_NAME,
 		port->speed > 10000 ? (port->speed + 800) / 1000 : port->speed,
-		port->speed > 10000 ? "M" : "k", 
+		port->speed > 10000 ? "M" : "k",
 		port->speed > 10000 ? (port->loop * 1000) / (port->speed / 1000)
 				    : (port->loop * 1000000) / port->speed);
 }
@@ -580,11 +580,11 @@
 
 		gameport_calibrate(port->gameport, port->axes, max);
 	}
-		
-	for (i = 0; i < 4; i++) 
+
+	for (i = 0; i < 4; i++)
 		port->initial[i] = port->axes[i];
 
-	return -!(analog[0].mask || analog[1].mask);	
+	return -!(analog[0].mask || analog[1].mask);
 }
 
 static int analog_init_port(struct gameport *gameport, struct gameport_dev *dev, struct analog_port *port)
@@ -606,7 +606,7 @@
 		wait_ms(ANALOG_MAX_TIME);
 		port->mask = (gameport_read(gameport) ^ t) & t & 0xf;
 		port->fuzz = (port->speed * ANALOG_FUZZ_MAGIC) / port->loop / 1000 + ANALOG_FUZZ_BITS;
-	
+
 		for (i = 0; i < ANALOG_INIT_RETRIES; i++) {
 			if (!analog_cooked_read(port)) break;
 			wait_ms(ANALOG_MAX_TIME);
@@ -617,11 +617,11 @@
 		wait_ms(ANALOG_MAX_TIME);
 		t = gameport_time(gameport, ANALOG_MAX_TIME * 1000);
 		gameport_trigger(gameport);
-		while ((gameport_read(port->gameport) & port->mask) && (u < t)) u++; 
+		while ((gameport_read(port->gameport) & port->mask) && (u < t)) u++;
 		udelay(ANALOG_SAITEK_DELAY);
 		t = gameport_time(gameport, ANALOG_SAITEK_TIME);
 		gameport_trigger(gameport);
-		while ((gameport_read(port->gameport) & port->mask) && (v < t)) v++; 
+		while ((gameport_read(port->gameport) & port->mask) && (v < t)) v++;
 
 		if (v < (u >> 1)) { /* FIXME - more than one port */
 			analog_options[0] |= /* FIXME - more than one port */
@@ -721,7 +721,7 @@
 			if (!strcmp(analog_types[j].name, js[i])) {
 				analog_options[i] = analog_types[j].value;
 				break;
-			} 
+			}
 		if (analog_types[j].name) continue;
 
 		analog_options[i] = simple_strtoul(js[i], &end, 0);
diff -Nru a/drivers/input/joystick/cobra.c b/drivers/input/joystick/cobra.c
--- a/drivers/input/joystick/cobra.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/cobra.c	2004-06-07 13:11:12 +02:00
@@ -72,7 +72,7 @@
 		r[i] = buf[i] = 0;
 		t[i] = COBRA_MAX_STROBE;
 	}
-	
+
 	local_irq_save(flags);
 
 	u = gameport_read(gameport);
@@ -140,14 +140,14 @@
 
 		}
 
-	mod_timer(&cobra->timer, jiffies + COBRA_REFRESH_TIME);	
+	mod_timer(&cobra->timer, jiffies + COBRA_REFRESH_TIME);
 }
 
 static int cobra_open(struct input_dev *dev)
 {
 	struct cobra *cobra = dev->private;
 	if (!cobra->used++)
-		mod_timer(&cobra->timer, jiffies + COBRA_REFRESH_TIME);	
+		mod_timer(&cobra->timer, jiffies + COBRA_REFRESH_TIME);
 	return 0;
 }
 
@@ -180,7 +180,7 @@
 
 	cobra->exists = cobra_read_packet(gameport, data);
 
-	for (i = 0; i < 2; i++) 
+	for (i = 0; i < 2; i++)
 		if ((cobra->exists >> i) & data[i] & 1) {
 			printk(KERN_WARNING "cobra.c: Device %d on %s has the Ext bit set. ID is: %d"
 				" Contact vojtech@ucw.cz\n", i, gameport->phys, (data[i] >> 2) & 7);
@@ -205,7 +205,7 @@
 			cobra->dev[i].id.vendor = GAMEPORT_ID_VENDOR_CREATIVE;
 			cobra->dev[i].id.product = 0x0008;
 			cobra->dev[i].id.version = 0x0100;
-		
+
 			cobra->dev[i].evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 			cobra->dev[i].absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
 
diff -Nru a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
--- a/drivers/input/joystick/db9.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/db9.c	2004-06-07 13:11:12 +02:00
@@ -14,14 +14,14 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
@@ -95,7 +95,7 @@
 struct db9 {
 	struct input_dev dev[DB9_MAX_DEVICES];
 	struct timer_list timer;
-	struct pardevice *pd;	
+	struct pardevice *pd;
 	int mode;
 	int used;
 	char phys[2][32];
@@ -188,7 +188,7 @@
 }
 
 /*
- * db9_saturn_read_packet() reads whole saturn packet at connector 
+ * db9_saturn_read_packet() reads whole saturn packet at connector
  * and returns device identifier code.
  */
 static unsigned char db9_saturn_read_packet(struct parport *port, unsigned char *data, int type, int powered)
@@ -481,16 +481,16 @@
 			input_report_abs(dev, ABS_X, (data & DB9_RIGHT ? 0 : 1) - (data & DB9_LEFT ? 0 : 1));
 			input_report_abs(dev, ABS_Y, (data & DB9_DOWN  ? 0 : 1) - (data & DB9_UP   ? 0 : 1));
 
-			parport_write_control(port, 0x0a); 
+			parport_write_control(port, 0x0a);
 
-			for (i = 0; i < 7; i++) { 
+			for (i = 0; i < 7; i++) {
 				data = parport_read_data(port);
-				parport_write_control(port, 0x02); 
-				parport_write_control(port, 0x0a); 
+				parport_write_control(port, 0x02);
+				parport_write_control(port, 0x0a);
 				input_report_key(dev, db9_cd32_btn[i], ~data & DB9_FIRE2);
 				}
 
-			parport_write_control(port, 0x00); 
+			parport_write_control(port, 0x00);
 			break;
 		}
 
@@ -600,7 +600,7 @@
 
 		db9->dev[i].evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 		for (j = 0; j < db9_buttons[db9->mode]; j++)
-			set_bit(db9_btn[db9->mode][j], db9->dev[i].keybit); 
+			set_bit(db9_btn[db9->mode][j], db9->dev[i].keybit);
 		for (j = 0; j < db9_num_axis[db9->mode]; j++) {
 			set_bit(db9_abs[j], db9->dev[i].absbit);
 			if (j < 2) {
@@ -635,7 +635,7 @@
 {
 	int i, j;
 
-	for (i = 0; i < 3; i++) 
+	for (i = 0; i < 3; i++)
 		if (db9_base[i]) {
 			for (j = 0; j < min(db9_max_pads[db9_base[i]->mode], DB9_MAX_DEVICES); j++)
 				input_unregister_device(db9_base[i]->dev + j);
diff -Nru a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
--- a/drivers/input/joystick/gamecon.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/gamecon.c	2004-06-07 13:11:12 +02:00
@@ -15,14 +15,14 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
@@ -70,13 +70,13 @@
 #define GC_NES4		3
 #define GC_MULTI	4
 #define GC_MULTI2	5
-#define GC_N64		6	
+#define GC_N64		6
 #define GC_PSX		7
 
 #define GC_MAX		7
 
 #define GC_REFRESH_TIME	HZ/100
- 
+
 struct gc {
 	struct pardevice *pd;
 	struct input_dev dev[5];
@@ -104,7 +104,7 @@
 #define GC_N64_DELAY		133		/* delay between transmit request, and response ready (us) */
 #define GC_N64_REQUEST		0x1dd1111111ULL /* the request data command (encoded for 000000011) */
 #define GC_N64_DWS		3		/* delay between write segments (required for sound playback because of ISA DMA) */
-						/* GC_N64_DWS > 24 is known to fail */ 
+						/* GC_N64_DWS > 24 is known to fail */
 #define GC_N64_POWER_W		0xe2		/* power during write (transmit request) */
 #define GC_N64_POWER_R		0xfd		/* power during read */
 #define GC_N64_OUT		0x1d		/* output bits to the 4 pads */
@@ -113,8 +113,8 @@
 						/* than 123 us */
 #define GC_N64_CLOCK		0x02		/* clock bits for read */
 
-/* 
- * gc_n64_read_packet() reads an N64 packet. 
+/*
+ * gc_n64_read_packet() reads an N64 packet.
  * Each pad uses one bit per byte. So all pads connected to this port are read in parallel.
  */
 
@@ -224,7 +224,7 @@
  *	http://www.dim.com/~mackys/psxmemcard/ps-eng2.txt
  *	http://www.gamesx.com/controldata/psxcont/psxcont.htm
  *	ftp://milano.usal.es/pablo/
- *	
+ *
  */
 
 #define GC_PSX_DELAY	25		/* 25 usec */
@@ -331,13 +331,13 @@
 			s = gc_status_bit[i];
 
 			if (s & gc->pads[GC_N64] & ~(data[8] | data[9])) {
-	
+
 				signed char axes[2];
 				axes[0] = axes[1] = 0;
 
 				for (j = 0; j < 8; j++) {
-					if (data[23 - j] & s) axes[0] |= 1 << j; 
-					if (data[31 - j] & s) axes[1] |= 1 << j; 
+					if (data[23 - j] & s) axes[0] |= 1 << j;
+					if (data[31 - j] & s) axes[1] |= 1 << j;
 				}
 
 				input_report_abs(dev + i, ABS_X,  axes[0]);
@@ -588,7 +588,7 @@
 				break;
 
 			case GC_PSX:
-				
+
 				psx = gc_psx_read_packet(gc, data);
 
 				switch(psx) {
@@ -629,7 +629,7 @@
 		}
 
 		sprintf(gc->phys[i], "%s/input%d", gc->pd->port->name, i);
-		
+
                 gc->dev[i].name = gc_names[config[i + 1]];
 		gc->dev[i].phys = gc->phys[i];
                 gc->dev[i].id.bustype = BUS_PARPORT;
@@ -646,7 +646,7 @@
 		return NULL;
 	}
 
-	for (i = 0; i < 5; i++) 
+	for (i = 0; i < 5; i++)
 		if (gc->pads[0] & gc_status_bit[i]) {
 			input_register_device(gc->dev + i);
 			printk(KERN_INFO "input: %s on %s\n", gc->dev[i].name, gc->pd->port->name);
@@ -675,7 +675,7 @@
 		if (gc_base[i]) {
 			for (j = 0; j < 5; j++)
 				if (gc_base[i]->pads[0] & gc_status_bit[j])
-					input_unregister_device(gc_base[i]->dev + j); 
+					input_unregister_device(gc_base[i]->dev + j);
 			parport_unregister_device(gc_base[i]->pd);
 		}
 }
diff -Nru a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
--- a/drivers/input/joystick/gf2k.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/gf2k.c	2004-06-07 13:11:12 +02:00
@@ -11,18 +11,18 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  * Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
@@ -223,7 +223,7 @@
 {
 	struct gf2k *gf2k = dev->private;
 	if (!gf2k->used++)
-		mod_timer(&gf2k->timer, jiffies + GF2K_REFRESH);	
+		mod_timer(&gf2k->timer, jiffies + GF2K_REFRESH);
 	return 0;
 }
 
@@ -324,7 +324,7 @@
 
 	for (i = 0; i < gf2k_axes[gf2k->id]; i++) {
 		gf2k->dev.absmax[gf2k_abs[i]] = (i < 2) ? gf2k->dev.abs[gf2k_abs[i]] * 2 - 32 :
-	      		  gf2k->dev.abs[gf2k_abs[0]] + gf2k->dev.abs[gf2k_abs[1]] - 32; 
+	      		  gf2k->dev.abs[gf2k_abs[0]] + gf2k->dev.abs[gf2k_abs[1]] - 32;
 		gf2k->dev.absmin[gf2k_abs[i]] = 32;
 		gf2k->dev.absfuzz[gf2k_abs[i]] = 8;
 		gf2k->dev.absflat[gf2k_abs[i]] = (i < 2) ? 24 : 0;
diff -Nru a/drivers/input/joystick/grip.c b/drivers/input/joystick/grip.c
--- a/drivers/input/joystick/grip.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/grip.c	2004-06-07 13:11:12 +02:00
@@ -48,8 +48,8 @@
 #define GRIP_STROBE_GPP		200	/* 200 us */
 #define GRIP_LENGTH_XT		4
 #define GRIP_STROBE_XT		64	/* 64 us */
-#define GRIP_MAX_CHUNKS_XT	10	
-#define GRIP_MAX_BITS_XT	30	
+#define GRIP_MAX_CHUNKS_XT	10
+#define GRIP_MAX_BITS_XT	30
 
 #define GRIP_REFRESH_TIME	HZ/50	/* 20 ms */
 
@@ -153,7 +153,7 @@
 				buf = (buf << 1) | (u >> 1);
 				t = strobe;
 				i++;
-			} else 
+			} else
 
 			if ((((u ^ v) & (v ^ w)) >> 1) & ~(u | v | w) & 1) {
 				if (i == 20) {
diff -Nru a/drivers/input/joystick/grip_mp.c b/drivers/input/joystick/grip_mp.c
--- a/drivers/input/joystick/grip_mp.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/grip_mp.c	2004-06-07 13:11:12 +02:00
@@ -69,7 +69,7 @@
 #define IO_MODE_FAST         0x0200           /* Used 3 data bits per gameport read     */
 #define IO_SLOT_CHANGE       0x0800           /* Multiport physical slot status changed */
 #define IO_DONE              0x1000           /* Multiport is done sending packets      */
-#define IO_RETRY             0x4000           /* Try again later to get packet          */ 
+#define IO_RETRY             0x4000           /* Try again later to get packet          */
 #define IO_RESET             0x8000           /* Force multiport to resend all packets  */
 
 /*
@@ -144,8 +144,8 @@
 /*
  * Gets a 28-bit packet from the multiport.
  *
- * After getting a packet successfully, commands encoded by sendcode may 
- * be sent to the multiport.  
+ * After getting a packet successfully, commands encoded by sendcode may
+ * be sent to the multiport.
  *
  * The multiport clock value is reflected in gameport bit B4.
  *
@@ -169,7 +169,7 @@
 
 	*packet = 0;
 	raw_data = gameport_read(gameport);
-	if (raw_data & 1)                          
+	if (raw_data & 1)
  		return IO_RETRY;
 
 	for (i = 0; i < 64; i++) {
@@ -183,11 +183,11 @@
 
 		if (raw_data & 0x31)
 			return IO_RESET;
-		gameport_trigger(gameport); 
+		gameport_trigger(gameport);
 
 		if (!poll_until(0x10, 0, 308, gameport, &raw_data))
 			return IO_RESET;
-	} else 
+	} else
 		return IO_RETRY;
 
 	/* Determine packet transfer mode and prepare for packet construction. */
@@ -195,7 +195,7 @@
 	if (raw_data & 0x20) {                 /* 3 data bits/read */
 		portvals |= raw_data >> 4;     /* Compare B4-B7 before & after trigger */
 
-		if (portvals != 0xb)           
+		if (portvals != 0xb)
 			return 0;
 		data_mask = 7;
 		bits_per_read = 3;
@@ -221,7 +221,7 @@
 			return IO_RESET;
 	}
 
-	if (raw_data)                            
+	if (raw_data)
 		return IO_RESET;
 
 	/* If 3 bits/read used, drop from 30 bits to 28. */
@@ -231,7 +231,7 @@
 		pkt = (pkt >> 2) | 0xf0000000;
 	}
 
-	if (bit_parity(pkt) == 1) 
+	if (bit_parity(pkt) == 1)
 		return IO_RESET;
 
 	/* Acknowledge packet receipt */
@@ -251,10 +251,10 @@
 
         /* Return if we just wanted the packet or multiport wants to send more */
 
-	*packet = pkt;	                             
+	*packet = pkt;
 	if ((sendflags == 0) || ((sendflags & IO_RETRY) && !(pkt & PACKET_MP_DONE)))
 		return IO_GOT_PACKET;
-	
+
 	if (pkt & PACKET_MP_MORE)
 		return IO_GOT_PACKET | IO_RETRY;
 
@@ -277,7 +277,7 @@
 		if (!poll_until(0x30, 0, 193, gameport, &raw_data))
 			return IO_GOT_PACKET | IO_RESET;
 
-		if (raw_data & 1)   
+		if (raw_data & 1)
 			return IO_GOT_PACKET | IO_RESET;
 
 		if (sendcode & 1)
@@ -429,19 +429,19 @@
 			strange_code = joytype;
 		}
 	}
-	return flags;  
+	return flags;
 }
 
 /*
  * Returns true if all multiport slot states appear valid.
  */
- 
+
 static int slots_valid(struct grip_mp *grip)
 {
 	int flags, slot, invalid = 0, active = 0;
 
 	flags = get_and_decode_packet(grip, 0);
-	if (!(flags & IO_GOT_PACKET))          
+	if (!(flags & IO_GOT_PACKET))
 		return 0;
 
 	for (slot = 0; slot < 4; slot++) {
@@ -463,7 +463,7 @@
  * Returns whether the multiport was placed into digital mode and
  * able to communicate its state successfully.
  */
- 
+
 static int multiport_init(struct grip_mp *grip)
 {
 	int dig_mode, initialized = 0, tries = 0;
@@ -481,7 +481,7 @@
 		dbg("multiport_init(): unable to achieve digital mode.\n");
 		return 0;
 	}
-	
+
 	/* Get packets, store multiport state, and check state's validity */
 	for (tries = 0; tries < 4096; tries++) {
 		if ( slots_valid(grip) ) {
@@ -520,9 +520,9 @@
 }
 
 /*
- * Get the multiport state.  
+ * Get the multiport state.
  */
- 
+
 static void get_and_report_mp_state(struct grip_mp *grip)
 {
 	int i, npkts, flags;
@@ -538,7 +538,7 @@
 			break;
 	}
 
-	for (i = 0; i < 4; i++)      
+	for (i = 0; i < 4; i++)
 		if (grip->dirty[i])
 			report_slot(grip, i);
 }
@@ -546,7 +546,7 @@
 /*
  * Called when a joystick device file is opened
  */
- 
+
 static int grip_open(struct input_dev *dev)
 {
 	struct grip_mp *grip = dev->private;
@@ -607,7 +607,7 @@
 /*
  * Repeatedly polls the multiport and generates events.
  */
- 
+
 static void grip_timer(unsigned long private)
 {
 	struct grip_mp *grip = (void*) private;
diff -Nru a/drivers/input/joystick/guillemot.c b/drivers/input/joystick/guillemot.c
--- a/drivers/input/joystick/guillemot.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/guillemot.c	2004-06-07 13:11:12 +02:00
@@ -45,7 +45,7 @@
 #define GUILLEMOT_MAX_LENGTH	17	/* 17 bytes */
 #define GUILLEMOT_REFRESH_TIME	HZ/50	/* 20 ms */
 
-static short guillemot_abs_pad[] = 
+static short guillemot_abs_pad[] =
 	{ ABS_X, ABS_Y, ABS_THROTTLE, ABS_RUDDER, -1 };
 
 static short guillemot_btn_pad[] =
@@ -160,7 +160,7 @@
 {
 	struct guillemot *guillemot = dev->private;
 	if (!guillemot->used++)
-		mod_timer(&guillemot->timer, jiffies + GUILLEMOT_REFRESH_TIME);	
+		mod_timer(&guillemot->timer, jiffies + GUILLEMOT_REFRESH_TIME);
 	return 0;
 }
 
@@ -211,7 +211,7 @@
 	if (!guillemot_type[i].name) {
 		printk(KERN_WARNING "guillemot.c: Unknown joystick on %s. [ %02x%02x:%04x, ver %d.%02d ]\n",
 			gameport->phys, data[12], data[13], data[11], data[14], data[15]);
-		goto fail2;	
+		goto fail2;
 	}
 
 	sprintf(guillemot->phys, "%s/input0", gameport->phys);
@@ -237,7 +237,7 @@
 		guillemot->dev.absmax[t] = 255;
 	}
 
-	if (guillemot->type->hat) 
+	if (guillemot->type->hat)
 		for (i = 0; i < 2; i++) {
 			t = ABS_HAT0X + i;
 			set_bit(t, guillemot->dev.absbit);
diff -Nru a/drivers/input/joystick/iforce/Kconfig b/drivers/input/joystick/iforce/Kconfig
--- a/drivers/input/joystick/iforce/Kconfig	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/iforce/Kconfig	2004-06-07 13:11:12 +02:00
@@ -17,7 +17,7 @@
 	depends on JOYSTICK_IFORCE && (JOYSTICK_IFORCE=m || USB=y) && USB
 	help
 	  Say Y here if you have an I-Force joystick or steering wheel
-	  connected to your USB port. 
+	  connected to your USB port.
 
 config JOYSTICK_IFORCE_232
 	bool "I-Force Serial joysticks and wheels"
diff -Nru a/drivers/input/joystick/iforce/Makefile b/drivers/input/joystick/iforce/Makefile
--- a/drivers/input/joystick/iforce/Makefile	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/iforce/Makefile	2004-06-07 13:11:12 +02:00
@@ -7,14 +7,14 @@
 # Goal definition
 iforce-objs	:= iforce-ff.o iforce-main.o iforce-packets.o
 
-obj-$(CONFIG_JOYSTICK_IFORCE)	+= iforce.o 
+obj-$(CONFIG_JOYSTICK_IFORCE)	+= iforce.o
 
 ifeq ($(CONFIG_JOYSTICK_IFORCE_232),y)
-	iforce-objs += iforce-serio.o 
+	iforce-objs += iforce-serio.o
 endif
 
 ifeq ($(CONFIG_JOYSTICK_IFORCE_USB),y)
-	iforce-objs += iforce-usb.o 
+	iforce-objs += iforce-usb.o
 endif
 
 EXTRA_CFLAGS = -Werror-implicit-function-declaration
diff -Nru a/drivers/input/joystick/iforce/iforce-ff.c b/drivers/input/joystick/iforce/iforce-ff.c
--- a/drivers/input/joystick/iforce/iforce-ff.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/iforce/iforce-ff.c	2004-06-07 13:11:12 +02:00
@@ -195,7 +195,7 @@
 }
 
 /*
- * Analyse the changes in an effect, and tell if we need to send an condition 
+ * Analyse the changes in an effect, and tell if we need to send an condition
  * parameter packet
  */
 static int need_condition_modifier(struct iforce* iforce, struct ff_effect* new)
@@ -372,7 +372,7 @@
 	int core_err = 0;
 
 	if (!is_update || need_period_modifier(iforce, effect)) {
-		param1_err = make_period_modifier(iforce, mod1_chunk, 
+		param1_err = make_period_modifier(iforce, mod1_chunk,
 			is_update,
 			effect->u.periodic.magnitude, effect->u.periodic.offset,
 			effect->u.periodic.period, effect->u.periodic.phase);
diff -Nru a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
--- a/drivers/input/joystick/iforce/iforce-main.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/iforce/iforce-main.c	2004-06-07 13:11:12 +02:00
@@ -166,7 +166,7 @@
 	else {
 		/* We want to update an effect */
 		if (!CHECK_OWNERSHIP(effect->id, iforce)) return -EACCES;
-		
+
 		/* Parameter type cannot be updated */
 		if (effect->type != iforce->core_effects[effect->id].effect.type)
 			return -EINVAL;
@@ -273,7 +273,7 @@
 
 		if (test_bit(FF_CORE_IS_USED, iforce->core_effects[i].flags) &&
 			current->pid == iforce->core_effects[i].owner) {
-			
+
 			/* Stop effect */
 			input_report_ff(dev, i, 0);
 
diff -Nru a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
--- a/drivers/input/joystick/iforce/iforce-packets.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/iforce/iforce-packets.c	2004-06-07 13:11:12 +02:00
@@ -56,7 +56,7 @@
 	int empty;
 	int head, tail;
 	unsigned long flags;
-			
+
 /*
  * Update head and tail of xmit buffer
  */
@@ -108,7 +108,7 @@
 		break;
 #endif
 #ifdef CONFIG_JOYSTICK_IFORCE_USB
-		case IFORCE_USB: 
+		case IFORCE_USB:
 
 		if (iforce->usbdev && empty &&
 			!test_and_set_bit(IFORCE_XMIT_RUNNING, iforce->xmit_flags)) {
diff -Nru a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
--- a/drivers/input/joystick/iforce/iforce-serio.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/iforce/iforce-serio.c	2004-06-07 13:11:12 +02:00
@@ -62,7 +62,7 @@
 		cs ^= iforce->xmit.buf[iforce->xmit.tail];
 		XMIT_INC(iforce->xmit.tail, 1);
 	}
-	
+
 	serio_write(iforce->serio, cs);
 
 	if (test_and_clear_bit(IFORCE_XMIT_AGAIN, iforce->xmit_flags))
diff -Nru a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
--- a/drivers/input/joystick/iforce/iforce.h	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/iforce/iforce.h	2004-06-07 13:11:12 +02:00
@@ -141,7 +141,7 @@
 	struct circ_buf xmit;
 	unsigned char xmit_data[XMIT_SIZE];
 	long xmit_flags[1];
-	
+
 					/* Force Feedback */
 	wait_queue_head_t wait;
 	struct resource device_memory;
diff -Nru a/drivers/input/joystick/interact.c b/drivers/input/joystick/interact.c
--- a/drivers/input/joystick/interact.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/interact.c	2004-06-07 13:11:12 +02:00
@@ -63,7 +63,7 @@
 	char phys[32];
 };
 
-static short interact_abs_hhfx[] = 
+static short interact_abs_hhfx[] =
 	{ ABS_RX, ABS_RY, ABS_X, ABS_Y, ABS_HAT0X, ABS_HAT0Y, -1 };
 static short interact_abs_pp8d[] =
 	{ ABS_X, ABS_Y, -1 };
@@ -166,7 +166,7 @@
 			case INTERACT_TYPE_PP8D:
 
 				for (i = 0; i < 2; i++)
-					input_report_abs(dev, interact_abs_pp8d[i], 
+					input_report_abs(dev, interact_abs_pp8d[i],
 						((data[0] >> ((i << 1) + 20)) & 1)  - ((data[0] >> ((i << 1) + 21)) & 1));
 
 				for (i = 0; i < 8; i++)
@@ -190,7 +190,7 @@
 {
 	struct interact *interact = dev->private;
 	if (!interact->used++)
-		mod_timer(&interact->timer, jiffies + INTERACT_REFRESH_TIME);	
+		mod_timer(&interact->timer, jiffies + INTERACT_REFRESH_TIME);
 	return 0;
 }
 
@@ -242,7 +242,7 @@
 	if (!interact_type[i].length) {
 		printk(KERN_WARNING "interact.c: Unknown joystick on %s. [len %d d0 %08x d1 %08x i2 %08x]\n",
 			gameport->phys, i, data[0], data[1], data[2]);
-		goto fail2;	
+		goto fail2;
 	}
 
 	sprintf(interact->phys, "%s/input0", gameport->phys);
diff -Nru a/drivers/input/joystick/joydump.c b/drivers/input/joystick/joydump.c
--- a/drivers/input/joystick/joydump.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/joydump.c	2004-06-07 13:11:12 +02:00
@@ -12,18 +12,18 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  * Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
@@ -63,7 +63,7 @@
 		printk(KERN_INFO "joydump: | Raw mode not available - trying cooked.    |\n");
 
 		if (gameport_open(gameport, dev, GAMEPORT_MODE_COOKED)) {
-			
+
 			printk(KERN_INFO "joydump: | Cooked not available either. Failing.      |\n");
 			printk(KERN_INFO "joydump: `-------------------- END -------------------'\n");
 			return;
diff -Nru a/drivers/input/joystick/magellan.c b/drivers/input/joystick/magellan.c
--- a/drivers/input/joystick/magellan.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/magellan.c	2004-06-07 13:11:12 +02:00
@@ -11,18 +11,18 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  *  Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
@@ -159,7 +159,7 @@
 
 	memset(magellan, 0, sizeof(struct magellan));
 
-	magellan->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);	
+	magellan->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
 	for (i = 0; i < 9; i++)
 		set_bit(magellan_buttons[i], magellan->dev.keybit);
@@ -181,7 +181,7 @@
 	magellan->dev.id.vendor = SERIO_MAGELLAN;
 	magellan->dev.id.product = 0x0001;
 	magellan->dev.id.version = 0x0100;
-	
+
 	serio->private = magellan;
 
 	if (serio_open(serio, dev)) {
diff -Nru a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
--- a/drivers/input/joystick/sidewinder.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/sidewinder.c	2004-06-07 13:11:12 +02:00
@@ -11,18 +11,18 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  * Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
@@ -176,19 +176,19 @@
 				buf[i] = v >> 5;		/* Store it */
 			i++;					/* Advance index */
 			bitout = strobe;			/* Extend timeout for next bit */
-		} 
+		}
 
 		if (kick && (~v & u & 0x01)) {			/* Falling edge on axis 0 */
 			sched = kick;				/* Schedule second trigger */
 			kick = 0;				/* Don't schedule next time on falling edge */
 			pending = 1;				/* Mark schedule */
-		} 
+		}
 
 		if (pending && sched < 0 && (i > -SW_END)) {	/* Second trigger time */
 			gameport_trigger(gameport);		/* Trigger */
 			bitout = start;				/* Long bit timeout */
 			pending = 0;				/* Unmark schedule */
-			timeout = 0;				/* Switch from global to bit timeouts */ 
+			timeout = 0;				/* Switch from global to bit timeouts */
 		}
 	}
 
@@ -482,14 +482,14 @@
 	sw_read_packet(sw->gameport, buf, SW_LENGTH, i);			/* Read ID packet, this initializes the stick */
 
 	sw->fail = SW_FAIL;
-	
+
 	return -1;
 }
 
 static void sw_timer(unsigned long private)
 {
 	struct sw *sw = (void *) private;
-	
+
 	sw->reads++;
 	if (sw_read(sw)) sw->bads++;
 	mod_timer(&sw->timer, jiffies + SW_REFRESH);
@@ -653,7 +653,7 @@
 				case 60:
 					sw->number++;
 				case 45:				/* Ambiguous packet length */
-					if (j <= 40) {			/* ID length less or eq 40 -> FSP */	
+					if (j <= 40) {			/* ID length less or eq 40 -> FSP */
 				case 43:
 						sw->type = SW_ID_FSP;
 						break;
diff -Nru a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
--- a/drivers/input/joystick/spaceball.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/spaceball.c	2004-06-07 13:11:12 +02:00
@@ -15,18 +15,18 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  *  Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
@@ -59,8 +59,8 @@
 
 static int spaceball_axes[] = { ABS_X, ABS_Z, ABS_Y, ABS_RX, ABS_RZ, ABS_RY };
 static char *spaceball_names[] = {
-	"?", "SpaceTec SpaceBall 1003", "SpaceTec SpaceBall 2003", "SpaceTec SpaceBall 2003B", 
-	"SpaceTec SpaceBall 2003C", "SpaceTec SpaceBall 3003", "SpaceTec SpaceBall SpaceController", 
+	"?", "SpaceTec SpaceBall 1003", "SpaceTec SpaceBall 2003", "SpaceTec SpaceBall 2003B",
+	"SpaceTec SpaceBall 2003C", "SpaceTec SpaceBall 3003", "SpaceTec SpaceBall SpaceController",
 	"SpaceTec SpaceBall 3003C", "SpaceTec SpaceBall 4000FLX", "SpaceTec SpaceBall 4000FLX Lefty" };
 
 /*
@@ -96,7 +96,7 @@
 		case 'D':					/* Ball data */
 			if (spaceball->idx != 15) return;
 			for (i = 0; i < 6; i++)
-				input_report_abs(dev, spaceball_axes[i], 
+				input_report_abs(dev, spaceball_axes[i],
 					(__s16)((data[2 * i + 3] << 8) | data[2 * i + 2]));
 			break;
 
@@ -216,7 +216,7 @@
 		return;
 	memset(spaceball, 0, sizeof(struct spaceball));
 
-	spaceball->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);	
+	spaceball->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
 	switch (id) {
 		case SPACEBALL_4000FLX:
@@ -224,7 +224,7 @@
 			spaceball->dev.keybit[LONG(BTN_0)] |= BIT(BTN_9);
 			spaceball->dev.keybit[LONG(BTN_A)] |= BIT(BTN_A) | BIT(BTN_B) | BIT(BTN_C) | BIT(BTN_MODE);
 		default:
-			spaceball->dev.keybit[LONG(BTN_0)] |= BIT(BTN_2) | BIT(BTN_3) | BIT(BTN_4) 
+			spaceball->dev.keybit[LONG(BTN_0)] |= BIT(BTN_2) | BIT(BTN_3) | BIT(BTN_4)
 				| BIT(BTN_5) | BIT(BTN_6) | BIT(BTN_7) | BIT(BTN_8);
 		case SPACEBALL_3003C:
 			spaceball->dev.keybit[LONG(BTN_0)] |= BIT(BTN_1) | BIT(BTN_8);
@@ -251,7 +251,7 @@
 	spaceball->dev.id.vendor = SERIO_SPACEBALL;
 	spaceball->dev.id.product = id;
 	spaceball->dev.id.version = 0x0100;
-	
+
 	serio->private = spaceball;
 
 	if (serio_open(serio, dev)) {
diff -Nru a/drivers/input/joystick/spaceorb.c b/drivers/input/joystick/spaceorb.c
--- a/drivers/input/joystick/spaceorb.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/spaceorb.c	2004-06-07 13:11:12 +02:00
@@ -2,7 +2,7 @@
  * $Id: spaceorb.c,v 1.15 2002/01/22 20:29:19 vojtech Exp $
  *
  *  Copyright (c) 1999-2001 Vojtech Pavlik
- * 
+ *
  *  Based on the work of:
  *  	David Thompson
  */
@@ -14,18 +14,18 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  *  Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
@@ -67,7 +67,7 @@
 static unsigned char spaceorb_xor[] = "SpaceWare";
 
 static unsigned char *spaceorb_errors[] = { "EEPROM storing 0 failed", "Receive queue overflow", "Transmit queue timeout",
-		"Bad packet", "Power brown-out", "EEPROM checksum error", "Hardware fault" }; 
+		"Bad packet", "Power brown-out", "EEPROM checksum error", "Hardware fault" };
 
 /*
  * spaceorb_process_packet() decodes packets the driver receives from the
@@ -99,7 +99,7 @@
 
 		case 'D':				/* Ball + button data */
 			if (spaceorb->idx != 12) return;
-			for (i = 0; i < 9; i++) spaceorb->data[i+2] ^= spaceorb_xor[i]; 
+			for (i = 0; i < 9; i++) spaceorb->data[i+2] ^= spaceorb_xor[i];
 			axes[0] = ( data[2]	 << 3) | (data[ 3] >> 4);
 			axes[1] = ((data[3] & 0x0f) << 6) | (data[ 4] >> 1);
 			axes[2] = ((data[4] & 0x01) << 9) | (data[ 5] << 2) | (data[4] >> 5);
@@ -174,7 +174,7 @@
 		return;
 	memset(spaceorb, 0, sizeof(struct spaceorb));
 
-	spaceorb->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);	
+	spaceorb->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
 	for (i = 0; i < 6; i++)
 		set_bit(spaceorb_buttons[i], spaceorb->dev.keybit);
@@ -198,7 +198,7 @@
 	spaceorb->dev.id.vendor = SERIO_SPACEORB;
 	spaceorb->dev.id.product = 0x0001;
 	spaceorb->dev.id.version = 0x0100;
-	
+
 	serio->private = spaceorb;
 
 	if (serio_open(serio, dev)) {
diff -Nru a/drivers/input/joystick/stinger.c b/drivers/input/joystick/stinger.c
--- a/drivers/input/joystick/stinger.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/stinger.c	2004-06-07 13:11:12 +02:00
@@ -147,7 +147,7 @@
 
 	memset(stinger, 0, sizeof(struct stinger));
 
-	stinger->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);	
+	stinger->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 	stinger->dev.keybit[LONG(BTN_A)] = BIT(BTN_A) | BIT(BTN_B) | BIT(BTN_C) | BIT(BTN_X) | \
 					   BIT(BTN_Y) | BIT(BTN_Z) | BIT(BTN_TL) | BIT(BTN_TR) | \
 					   BIT(BTN_START) | BIT(BTN_SELECT);
@@ -164,8 +164,8 @@
 	stinger->dev.id.version = 0x0100;
 
 	for (i = 0; i < 2; i++) {
-		stinger->dev.absmax[ABS_X+i] =  64;	
-		stinger->dev.absmin[ABS_X+i] = -64;	
+		stinger->dev.absmax[ABS_X+i] =  64;
+		stinger->dev.absmin[ABS_X+i] = -64;
 		stinger->dev.absflat[ABS_X+i] = 4;
 	}
 
diff -Nru a/drivers/input/joystick/tmdc.c b/drivers/input/joystick/tmdc.c
--- a/drivers/input/joystick/tmdc.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/tmdc.c	2004-06-07 13:11:12 +02:00
@@ -4,7 +4,7 @@
  *  Copyright (c) 1998-2001 Vojtech Pavlik
  *
  *   Based on the work of:
- *	Trystan Larey-Williams 
+ *	Trystan Larey-Williams
  */
 
 /*
@@ -14,18 +14,18 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  * Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
@@ -58,7 +58,7 @@
 #define TMDC_BYTE_REV		11
 #define TMDC_BYTE_DEF		12
 
-#define TMDC_ABS		7	
+#define TMDC_ABS		7
 #define TMDC_ABS_HAT		4
 #define TMDC_BTN		16
 
@@ -104,7 +104,7 @@
 	unsigned char btno[2][4];
 	int used;
 	int reads;
-	int bads;	
+	int bads;
 	unsigned char exists;
 };
 
@@ -127,7 +127,7 @@
 
 	local_irq_save(flags);
 	gameport_trigger(gameport);
-	
+
 	w = gameport_read(gameport) >> 4;
 
 	do {
@@ -148,7 +148,7 @@
 				}
 				data[k][i[k]] |= (~v & 1) << (j[k]++ - 1);	/* Data bit */
 			}
-			t[k]--; 
+			t[k]--;
 		}
 	} while (t[0] > 0 || t[1] > 0);
 
@@ -175,7 +175,7 @@
 		bad = 1;
 	else
 
-	for (j = 0; j < 2; j++) 
+	for (j = 0; j < 2; j++)
 		if (r & (1 << j) & tmdc->exists) {
 
 			if (data[j][TMDC_BYTE_ID] != tmdc->mode[j]) {
@@ -227,7 +227,7 @@
 {
 	struct tmdc *tmdc = dev->private;
 	if (!tmdc->used++)
-		mod_timer(&tmdc->timer, jiffies + TMDC_REFRESH_TIME);	
+		mod_timer(&tmdc->timer, jiffies + TMDC_REFRESH_TIME);
 	return 0;
 }
 
@@ -356,7 +356,7 @@
 	struct tmdc *tmdc = gameport->private;
 	int i;
 	for (i = 0; i < 2; i++)
-		if (tmdc->exists & (1 << i)) 
+		if (tmdc->exists & (1 << i))
 			input_unregister_device(tmdc->dev + i);
 	gameport_close(gameport);
 	kfree(tmdc);
diff -Nru a/drivers/input/joystick/turbografx.c b/drivers/input/joystick/turbografx.c
--- a/drivers/input/joystick/turbografx.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/turbografx.c	2004-06-07 13:11:12 +02:00
@@ -14,18 +14,18 @@
 /*
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  * Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
@@ -65,7 +65,7 @@
 
 #define TGFX_TRIGGER		0x08
 #define TGFX_UP			0x10
-#define TGFX_DOWN		0x20	
+#define TGFX_DOWN		0x20
 #define TGFX_LEFT		0x40
 #define TGFX_RIGHT		0x80
 
@@ -126,7 +126,7 @@
         if (!tgfx->used++) {
 		parport_claim(tgfx->pd);
 		parport_write_control(tgfx->pd->port, 0x04);
-                mod_timer(&tgfx->timer, jiffies + TGFX_REFRESH_TIME); 
+                mod_timer(&tgfx->timer, jiffies + TGFX_REFRESH_TIME);
 	}
         return 0;
 }
@@ -173,7 +173,7 @@
 	memset(tgfx, 0, sizeof(struct tgfx));
 
 	tgfx->pd = parport_register_device(pp, "turbografx", NULL, NULL, NULL, PARPORT_DEV_EXCL, NULL);
-		
+
 	parport_put_port(pp);
 
 	if (!tgfx->pd) {
@@ -210,7 +210,7 @@
 			tgfx->dev[i].absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
 
 			for (j = 0; j < config[i+1]; j++)
-				set_bit(tgfx_buttons[j], tgfx->dev[i].keybit); 
+				set_bit(tgfx_buttons[j], tgfx->dev[i].keybit);
 
 			tgfx->dev[i].absmin[ABS_X] = -1; tgfx->dev[i].absmax[ABS_X] = 1;
 			tgfx->dev[i].absmin[ABS_Y] = -1; tgfx->dev[i].absmax[ABS_Y] = 1;
@@ -225,7 +225,7 @@
 		kfree(tgfx);
 		return NULL;
         }
-		
+
 	return tgfx;
 }
 
@@ -245,7 +245,7 @@
 {
 	int i, j;
 
-	for (i = 0; i < 3; i++) 
+	for (i = 0; i < 3; i++)
 		if (tgfx_base[i]) {
 			for (j = 0; j < 7; j++)
 				if (tgfx_base[i]->sticks & (1 << j))
diff -Nru a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
--- a/drivers/input/joystick/twidjoy.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/twidjoy.c	2004-06-07 13:11:12 +02:00
@@ -211,7 +211,7 @@
 	twidjoy->dev.id.product = 0x0001;
 	twidjoy->dev.id.version = 0x0100;
 
-	twidjoy->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);	
+	twidjoy->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
 	for (bp = twidjoy_buttons; bp->bitmask; bp++) {
 		for (i = 0; i < bp->bitmask; i++)
@@ -221,8 +221,8 @@
 	twidjoy->dev.absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
 
 	for (i = 0; i < 2; i++) {
-		twidjoy->dev.absmax[ABS_X+i] =  50;	
-		twidjoy->dev.absmin[ABS_X+i] = -50;	
+		twidjoy->dev.absmax[ABS_X+i] =  50;
+		twidjoy->dev.absmin[ABS_X+i] = -50;
 
 		/* TODO: arndt 20010708: Are these values appropriate? */
 		twidjoy->dev.absfuzz[ABS_X+i] = 4;
diff -Nru a/drivers/input/joystick/warrior.c b/drivers/input/joystick/warrior.c
--- a/drivers/input/joystick/warrior.c	2004-06-07 13:11:12 +02:00
+++ b/drivers/input/joystick/warrior.c	2004-06-07 13:11:12 +02:00
@@ -11,18 +11,18 @@
 /*
  * This program is free warftware; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
- * 
+ *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- * 
+ *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- * 
+ *
  *  Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
@@ -44,7 +44,7 @@
  */
 
 #define WARRIOR_MAX_LENGTH	16
-static char warrior_lengths[] = { 0, 4, 12, 3, 4, 4, 0, 0 }; 
+static char warrior_lengths[] = { 0, 4, 12, 3, 4, 4, 0, 0 };
 static char *warrior_name = "Logitech WingMan Warrior";
 
 /*
@@ -114,7 +114,7 @@
 		warrior->data[warrior->idx++] = data;
 
 	if (warrior->idx == warrior->len) {
-		if (warrior->idx) warrior_process_packet(warrior, regs);	
+		if (warrior->idx) warrior_process_packet(warrior, regs);
 		warrior->idx = 0;
 		warrior->len = 0;
 	}
@@ -152,7 +152,7 @@
 
 	memset(warrior, 0, sizeof(struct warrior));
 
-	warrior->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL) | BIT(EV_ABS);	
+	warrior->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL) | BIT(EV_ABS);
 	warrior->dev.keybit[LONG(BTN_TRIGGER)] = BIT(BTN_TRIGGER) | BIT(BTN_THUMB) | BIT(BTN_TOP) | BIT(BTN_TOP2);
 	warrior->dev.relbit[0] = BIT(REL_DIAL);
 	warrior->dev.absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_THROTTLE) | BIT(ABS_HAT0X) | BIT(ABS_HAT0Y);
@@ -168,24 +168,24 @@
 	warrior->dev.id.version = 0x0100;
 
 	for (i = 0; i < 2; i++) {
-		warrior->dev.absmax[ABS_X+i] = -64;	
-		warrior->dev.absmin[ABS_X+i] =  64;	
-		warrior->dev.absflat[ABS_X+i] = 8;	
+		warrior->dev.absmax[ABS_X+i] = -64;
+		warrior->dev.absmin[ABS_X+i] =  64;
+		warrior->dev.absflat[ABS_X+i] = 8;
 	}
 
-	warrior->dev.absmax[ABS_THROTTLE] = -112;	
-	warrior->dev.absmin[ABS_THROTTLE] =  112;	
+	warrior->dev.absmax[ABS_THROTTLE] = -112;
+	warrior->dev.absmin[ABS_THROTTLE] =  112;
 
 	for (i = 0; i < 2; i++) {
-		warrior->dev.absmax[ABS_HAT0X+i] = -1;	
-		warrior->dev.absmin[ABS_HAT0X+i] =  1;	
+		warrior->dev.absmax[ABS_HAT0X+i] = -1;
+		warrior->dev.absmin[ABS_HAT0X+i] =  1;
 	}
 
 	warrior->dev.private = warrior;
-	
+
 	serio->private = warrior;
 
-	if (serio_open(serio, dev)) { 
+	if (serio_open(serio, dev)) {
 		kfree(warrior);
 		return;
 	}

