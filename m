Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUI0Rtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUI0Rtb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 13:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbUI0Rtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 13:49:31 -0400
Received: from loncoche.terra.com.br ([200.154.55.229]:56731 "EHLO
	loncoche.terra.com.br") by vger.kernel.org with ESMTP
	id S266839AbUI0Rt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 13:49:29 -0400
Date: Mon, 27 Sep 2004 13:53:30 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5]: usb-serial cleanup.
Message-Id: <20040927135330.428851a9.lcapitulino@conectiva.com.br>
Organization: Conectiva S/A.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi Greg,

 I did some trivial cleanup in usb-serial subsystem code
(drivers/usb/serial/usb-serial.c).

 The main change is the first patch, which moves the search
in device list out of usb_serial_probe(). It is the first
of some patches to make usb_serial_probe() more simple (today
it is an very big function).

 I'm sending only one patch for usb_serial_probe() organization
because I'm not certain if is the better/right thing to do, so,
comments and flames are welcome. :)

 Well, hope some of the patches to be applyed.

 Summary:

[PATCH 1/5]: usb-serial: Moves the search in device list out of usb_serial_probe().
[PATCH 2/5]: usb-serial: create_serial() return value trivial fix.
[PATCH 3/5]: usb-serial: return_serial() trivial cleanup.
[PATCH 4/5]: usb-serial: usb_serial_register() cleanup.
[PATCH 5/5]: usb-serial: Add module version information.

OBS: The patches are against 2.6.9-rc2-mm4, because your last
USB tree is there.

 Thanks,
