Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbTJUU7H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263395AbTJUU7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:59:00 -0400
Received: from smtp01.web.de ([217.72.192.180]:8712 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263389AbTJUU6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:58:38 -0400
From: Mathias =?utf-8?q?Fr=C3=B6hlich?= <Mathias.Froehlich@web.de>
To: linux-kernel@vger.kernel.org
Subject: 3Com pcmcia wlan with 2.6.0-test8
Date: Tue, 21 Oct 2003 22:58:34 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200310212258.34328.Mathias.Froehlich@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I use a 3Com 3CRSHPW196 PCMCIA wlan card with the atmel_cs module on a IBM R40 
laptop. Installed is Fedora 0.95 together with linux 2.6.0-test8.

The firmware is loaded using the kernel-hotplug firmware loader.

When the device is stopped or unloaded i get this message:

unregister_netdevice: waiting for eth1 to become free. Usage count = 4

Sometimes this locks shutdown hard. Sometimes the pcmcia card is left more or 
less unusable. It is afterwards not detected on bootup and also not on 
insertation past pcmcia initialization. Only

cardctl insert

switches the LED on the card on. Sometimes it is then usable, sometimes not. 
The first 2.6.0 boot past a session with linux-2.4.22 using the pcmf502r3.o 
module is allways successful as far as I remember.

Could you please take a look at the atmel driver?

    Thank you in advance

      Mathias Fröhlich

-- 
Mathias Fröhlich, email: Mathias.Froehlich@web.de

