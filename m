Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVB0RVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVB0RVv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 12:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVB0RVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:21:51 -0500
Received: from mx1.mail.ru ([194.67.23.121]:27452 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261444AbVB0RVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:21:46 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: linux-usb-devel@lists.sourceforge.net
Subject: Build failure of drivers/usb/gadget/ether.c
Date: Sun, 27 Feb 2005 20:21:54 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200502272021.54173.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, allyesconfig on sparc gives:

  CC      drivers/usb/gadget/ether.o
drivers/usb/gadget/ether.c: In function `eth_bind':
drivers/usb/gadget/ether.c:2418: error: `control_intf' undeclared (first use in this function)
drivers/usb/gadget/ether.c:2418: error: (Each undeclared identifier is reported only once
drivers/usb/gadget/ether.c:2418: error: for each function it appears in.)
make[3]: *** [drivers/usb/gadget/ether.o] Error 1

	Alexey
