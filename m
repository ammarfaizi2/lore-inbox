Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbTH0Tl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 15:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTH0Tl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 15:41:29 -0400
Received: from imsm083.netvigator.com ([218.102.48.167]:46794 "EHLO
	imsm083dat.netvigator.com") by vger.kernel.org with ESMTP
	id S262091AbTH0Tl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 15:41:28 -0400
X-Mailer: Openwave WebEngine, version 2.8.10.1 (webedge20-101-191-105-20030415)
From: Sum <ellenyip@netvigator.com>
To: <linux-kernel@vger.kernel.org>
Subject: install problem with kernel 2.6.0
Date: Thu, 28 Aug 2003 3:41:23 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Message-Id: <20030827194123.LBVT10998.imsm083dat.netvigator.com@imailmta.netvigator.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there. I just compile the kernel 2.6.0 version. However, there is not any /lib/modules/2.6.0-test4/modules.dep created. When I type "depmod -a", there is an error message said "depmod: QM_MODULES: Function not implemented". 
Also, when I type the "make modules_install", the output is:
[root@localhost linux-2.6.0-test4]# make modules_install
  INSTALL drivers/media/video/bw-qcam.ko
  INSTALL drivers/media/video/cpia.ko
  INSTALL drivers/media/video/cpia_usb.ko
  INSTALL drivers/net/dummy.ko
  INSTALL drivers/i2c/i2c-algo-bit.ko
  INSTALL drivers/i2c/i2c-algo-pcf.ko
  INSTALL drivers/i2c/i2c-core.ko
  INSTALL drivers/i2c/i2c-dev.ko
  INSTALL drivers/i2c/i2c-philips-par.ko
  INSTALL drivers/media/video/pms.ko
  INSTALL drivers/net/ppp_generic.ko
  INSTALL drivers/media/video/saa7134/saa7134.ko
  INSTALL drivers/net/slhc.ko
  INSTALL drivers/media/video/tda9887.ko
  INSTALL drivers/media/video/tuner.ko
  INSTALL drivers/usb/serial/usbserial.ko
  INSTALL drivers/media/video/v4l1-compat.ko
  INSTALL drivers/media/video/v4l2-common.ko
  INSTALL drivers/media/video/video-buf.ko
  INSTALL drivers/media/video/videodev.ko
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.0-test4; fi.
After I configure the modules, I type "make bzImage", then "make modules", "make modules_install", and "depmod -a". I copied the bzImage to vmlinuz and the System.map to /boot.
Is there anything I did wrong?
Thanks very much.

