Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbTKZWNI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 17:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTKZWNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 17:13:08 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:46210 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S264388AbTKZWNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 17:13:05 -0500
X-Analyze: Velop Mail Shield v0.0.3
Date: Wed, 26 Nov 2003 20:12:25 -0200 (BRST)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
cc: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [2.6.0-test10] standby freezes bttv
Message-ID: <Pine.LNX.4.58.0311262006170.154@pervalidus.dyndns.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your 2.6.0-test10-2 patch fails for me:

/usr/local/src/kernel/linux-2.6.0-test11/drivers/media/video/ir-kbd-gpio.c:147: unknown field `name' specified in initializer
/usr/local/src/kernel/linux-2.6.0-test11/drivers/media/video/ir-kbd-gpio.c:147: warning: missing braces around initializer
/usr/local/src/kernel/linux-2.6.0-test11/drivers/media/video/ir-kbd-gpio.c:147: warning: (near initialization for `driver.drv')
/usr/local/src/kernel/linux-2.6.0-test11/drivers/media/video/ir-kbd-gpio.c:148: unknown field `drv' specified in initializer
/usr/local/src/kernel/linux-2.6.0-test11/drivers/media/video/ir-kbd-gpio.c:149: unknown field `drv' specified in initializer
/usr/local/src/kernel/linux-2.6.0-test11/drivers/media/video/ir-kbd-gpio.c:150: unknown field `gpio_irq' specified in initializer
/usr/local/src/kernel/linux-2.6.0-test11/drivers/media/video/ir-kbd-gpio.c:150: warning: initialization from incompatible pointer type
/usr/local/src/kernel/linux-2.6.0-test11/drivers/media/video/ir-kbd-gpio.c: In function `ir_probe':
/usr/local/src/kernel/linux-2.6.0-test11/drivers/media/video/ir-kbd-gpio.c:185: warning: `mask_keycode' might be used uninitialized in this function
/usr/local/src/kernel/linux-2.6.0-test11/drivers/media/video/ir-kbd-gpio.c:186: warning: `mask_keydown' might be used uninitialized in this function
/usr/local/src/kernel/linux-2.6.0-test11/drivers/media/video/ir-kbd-gpio.c:187: warning: `ir_type' might be used uninitialized in this function
make[4]: *** [drivers/media/video/ir-kbd-gpio.o] Error 1
make[3]: *** [drivers/media/video] Error 2
make[2]: *** [drivers/media] Error 2
make[1]: *** [drivers] Error 2
make: *** [all] Error 2

Before I was using 2.6.0-test8-1.

GCC 2.95.4, make O=objdir/ , in case it makes any difference.

-- 
http://www.pervalidus.net/contact.html
