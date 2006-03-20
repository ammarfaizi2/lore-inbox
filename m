Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965314AbWCTP1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965314AbWCTP1P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965307AbWCTP0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:26:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39096 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964837AbWCTP0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:26:37 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Alexey Dobriyan <adobriyan@gmail.com>,
       Oliver Endriss <o.endriss@gmx.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 139/141] V4L/DVB (3413): Typos grab bag of the month
Date: Mon, 20 Mar 2006 12:09:00 -0300
Message-id: <20060320150900.PS182658000139@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>
Date: 1141780823 -0300

Typos grab bag of the month.
Eyeballed by jmc@ in OpenBSD.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/dvb-core/demux.h b/drivers/media/dvb/dvb-core/demux.h
diff --git a/drivers/media/dvb/dvb-core/demux.h b/drivers/media/dvb/dvb-core/demux.h
index 9f02582..0c1d87c 100644
--- a/drivers/media/dvb/dvb-core/demux.h
+++ b/drivers/media/dvb/dvb-core/demux.h
@@ -216,7 +216,7 @@ struct dmx_frontend {
 /*--------------------------------------------------------------------------*/
 
 /*
- * Flags OR'ed in the capabilites field of struct dmx_demux.
+ * Flags OR'ed in the capabilities field of struct dmx_demux.
  */
 
 #define DMX_TS_FILTERING                        1
diff --git a/drivers/media/dvb/dvb-usb/dvb-usb-init.c b/drivers/media/dvb/dvb-usb/dvb-usb-init.c
diff --git a/drivers/media/dvb/dvb-usb/dvb-usb-init.c b/drivers/media/dvb/dvb-usb/dvb-usb-init.c
index 4258a99..a1705ec 100644
--- a/drivers/media/dvb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/dvb/dvb-usb/dvb-usb-init.c
@@ -47,7 +47,7 @@ static int dvb_usb_init(struct dvb_usb_d
 
 	d->state = DVB_USB_STATE_INIT;
 
-/* check the capabilites and set appropriate variables */
+/* check the capabilities and set appropriate variables */
 
 /* speed - when running at FULL speed we need a HW PID filter */
 	if (d->udev->speed == USB_SPEED_FULL && !(d->props.caps & DVB_USB_HAS_PID_FILTER)) {
diff --git a/drivers/media/dvb/dvb-usb/dvb-usb.h b/drivers/media/dvb/dvb-usb/dvb-usb.h
diff --git a/drivers/media/dvb/dvb-usb/dvb-usb.h b/drivers/media/dvb/dvb-usb/dvb-usb.h
index d2be37c..fead958 100644
--- a/drivers/media/dvb/dvb-usb/dvb-usb.h
+++ b/drivers/media/dvb/dvb-usb/dvb-usb.h
@@ -88,7 +88,7 @@ struct dvb_usb_device;
 
 /**
  * struct dvb_usb_properties - properties of a dvb-usb-device
- * @caps: capabilites of the DVB USB device.
+ * @caps: capabilities of the DVB USB device.
  * @pid_filter_count: number of PID filter position in the optional hardware
  *  PID-filter.
  *
diff --git a/drivers/media/dvb/ttpci/av7110.c b/drivers/media/dvb/ttpci/av7110.c
diff --git a/drivers/media/dvb/ttpci/av7110.c b/drivers/media/dvb/ttpci/av7110.c
index 914f2e3..aef4f58 100644
--- a/drivers/media/dvb/ttpci/av7110.c
+++ b/drivers/media/dvb/ttpci/av7110.c
@@ -1441,7 +1441,7 @@ static int check_firmware(struct av7110*
 	len = ntohl(*(u32*) ptr);
 	ptr += 4;
 	if (len >= 512) {
-		printk("dvb-ttpci: dpram file is way to big.\n");
+		printk("dvb-ttpci: dpram file is way too big.\n");
 		return -EINVAL;
 	}
 	if (crc != crc32_le(0, ptr, len)) {
diff --git a/drivers/media/video/cpia.c b/drivers/media/video/cpia.c
diff --git a/drivers/media/video/cpia.c b/drivers/media/video/cpia.c
index c240502..d93a561 100644
--- a/drivers/media/video/cpia.c
+++ b/drivers/media/video/cpia.c
@@ -3369,7 +3369,7 @@ static int cpia_do_ioctl(struct inode *i
 	//DBG("cpia_ioctl: %u\n", ioctlnr);
 
 	switch (ioctlnr) {
-	/* query capabilites */
+	/* query capabilities */
 	case VIDIOCGCAP:
 	{
 		struct video_capability *b = arg;
diff --git a/drivers/media/video/cpia2/cpia2_v4l.c b/drivers/media/video/cpia2/cpia2_v4l.c
diff --git a/drivers/media/video/cpia2/cpia2_v4l.c b/drivers/media/video/cpia2/cpia2_v4l.c
index 589283d..08f8be3 100644
--- a/drivers/media/video/cpia2/cpia2_v4l.c
+++ b/drivers/media/video/cpia2/cpia2_v4l.c
@@ -1628,7 +1628,7 @@ static int cpia2_do_ioctl(struct inode *
 	}
 
 	switch (ioctl_nr) {
-	case VIDIOCGCAP:	/* query capabilites */
+	case VIDIOCGCAP:	/* query capabilities */
 		retval = ioctl_cap_query(arg, cam);
 		break;
 
diff --git a/drivers/media/video/videocodec.h b/drivers/media/video/videocodec.h
diff --git a/drivers/media/video/videocodec.h b/drivers/media/video/videocodec.h
index 156ae57..b1239ac 100644
--- a/drivers/media/video/videocodec.h
+++ b/drivers/media/video/videocodec.h
@@ -56,7 +56,7 @@
    the slave is bound to it). Otherwise it doesn't need this functions and
    therfor they may not be initialized.
 
-   The other fuctions are just for convenience, as they are for shure used by
+   The other fuctions are just for convenience, as they are for sure used by
    most/all of the codecs. The last ones may be ommited, too. 
 
    See the structure declaration below for more information and which data has
diff --git a/drivers/media/video/zr36050.c b/drivers/media/video/zr36050.c
diff --git a/drivers/media/video/zr36050.c b/drivers/media/video/zr36050.c
index bd0cd28..6699725 100644
--- a/drivers/media/video/zr36050.c
+++ b/drivers/media/video/zr36050.c
@@ -159,7 +159,7 @@ zr36050_wait_end (struct zr36050 *ptr)
 
 	while (!(zr36050_read_status1(ptr) & 0x4)) {
 		udelay(1);
-		if (i++ > 200000) {	// 200ms, there is for shure something wrong!!!
+		if (i++ > 200000) {	// 200ms, there is for sure something wrong!!!
 			dprintk(1,
 				"%s: timout at wait_end (last status: 0x%02x)\n",
 				ptr->name, ptr->status1);
diff --git a/drivers/media/video/zr36060.c b/drivers/media/video/zr36060.c
diff --git a/drivers/media/video/zr36060.c b/drivers/media/video/zr36060.c
index 28fa31a..d8dd003 100644
--- a/drivers/media/video/zr36060.c
+++ b/drivers/media/video/zr36060.c
@@ -161,7 +161,7 @@ zr36060_wait_end (struct zr36060 *ptr)
 
 	while (zr36060_read_status(ptr) & ZR060_CFSR_Busy) {
 		udelay(1);
-		if (i++ > 200000) {	// 200ms, there is for shure something wrong!!!
+		if (i++ > 200000) {	// 200ms, there is for sure something wrong!!!
 			dprintk(1,
 				"%s: timout at wait_end (last status: 0x%02x)\n",
 				ptr->name, ptr->status);
diff --git a/drivers/media/video/zr36120_i2c.c b/drivers/media/video/zr36120_i2c.c
diff --git a/drivers/media/video/zr36120_i2c.c b/drivers/media/video/zr36120_i2c.c
index 6bfe84d..21fde43 100644
--- a/drivers/media/video/zr36120_i2c.c
+++ b/drivers/media/video/zr36120_i2c.c
@@ -65,7 +65,7 @@ void attach_inform(struct i2c_bus *bus, 
 	 case I2C_DRIVERID_VIDEODECODER:
 		DEBUG(printk(CARD_INFO "decoder attached\n",CARD));
 
-		/* fetch the capabilites of the decoder */
+		/* fetch the capabilities of the decoder */
 		rv = i2c_control_device(&ztv->i2c, I2C_DRIVERID_VIDEODECODER, DECODER_GET_CAPABILITIES, &dc);
 		if (rv) {
 			DEBUG(printk(CARD_DEBUG "decoder is not V4L aware!\n",CARD));

