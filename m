Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbVIMADN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVIMADN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 20:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVIMADN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 20:03:13 -0400
Received: from natfrord.rzone.de ([81.169.145.161]:20465 "EHLO
	natfrord.rzone.de") by vger.kernel.org with ESMTP id S932373AbVIMADM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 20:03:12 -0400
From: Lion Vollnhals <lion.vollnhals@web.de>
To: Andrew Morton <akpm@osdl.org>
Subject: drivers/usb/class/bluetty.c does NOT build
Date: Tue, 13 Sep 2005 02:02:57 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20050912024350.60e89eb1.akpm@osdl.org>
In-Reply-To: <20050912024350.60e89eb1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509130202.57093.lion.vollnhals@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC [M]  drivers/usb/class/bluetty.o
drivers/usb/class/bluetty.c: In function `bluetooth_int_callback':
drivers/usb/class/bluetty.c:797: Fehler: structure hat kein Element namens »flip«
drivers/usb/class/bluetty.c: In function `bluetooth_read_bulk_callback':
drivers/usb/class/bluetty.c:925: Fehler: structure hat kein Element namens »flip«
make[3]: *** [drivers/usb/class/bluetty.o] Fehler 1
make[2]: *** [drivers/usb/class] Fehler 2
make[1]: *** [drivers/usb] Fehler 2
make: *** [drivers] Fehler 2


I suggest alan's tty fixes are at fault.


Lion Vollnhals
