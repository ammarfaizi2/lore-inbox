Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbUCOWdc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUCOWb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:31:26 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:39162 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262789AbUCOWbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:31:08 -0500
Date: Mon, 15 Mar 2004 23:31:06 +0100
From: Oliver Vogel <oliver.vogel@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.4 - Card Reader not working
Message-Id: <20040315233106.28bc8b7a.oliver.vogel@gmx.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody!

I got a little problem with a Memory Card Reader under Linux 2.6.4.

I enabled usb (both ehci and uhci) support, usb storage support in the
kernel, as well as scsi support and scsi disk support.
Mounting usb sticks works well, also the Card Reader shows at lsusb (see
below).
Also, there is a device /dev/sda (or rather
/dev/scsi/host0/bus0/target0/lun0/disc, I'm using devfs), but when I
insert an SD card into the reader, there is no sda1 (or rather target1)
appearing.
I also tried enabling probe all LUNs, with the result that the device
didn't appear in lsusb anymore.

I already asked in a Linux hardware newsgroup, but nobody seems to have
a clue...

Any hints?

Regards,

Oliver.


Here the output of lsusb:

Bus 004 Device 001: ID 0000:0000  
Bus 003 Device 002: ID 0db0:6982 Micro Star International Medion Flash
XL V2.7A Card Reader Bus 003 Device 001: ID 0000:0000  
Bus 002 Device 001: ID 0000:0000  
Bus 001 Device 001: ID 0000:0000  




