Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbVIQKzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbVIQKzG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 06:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbVIQKzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 06:55:05 -0400
Received: from mail1.dmailman.com ([65.125.9.75]:17934 "EHLO dmailman.com")
	by vger.kernel.org with ESMTP id S1751059AbVIQKzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 06:55:04 -0400
From: <ugenn@dmailman.com>
Subject: 2.6.13: USB vibration feedback gamepad problem.
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.3.5.7
Date: Sat, 17 Sep 2005 07:11:59 -0400
Message-ID: <web-15260507@dmailman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading to 2.6.13, whenever I plug in my usb gamepad, it automatically starts vibrating and can't be stopped without unloading the usbhid module.

2.6.12 had a similar problem but the vibration happens only when usbfs is mounted and lasts only a few seconds before stopping.

Prior versions never had this problem.

/proc/bus/usb/device entry:
T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=02 Dev#=  4 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0c12 ProdID=0023 Rev= 0.90
S:  Manufacturer=Zeroplus
S:  Product=USB Vibration Feedback Gamepad
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms
__________________________________________________________
Get your Private, Free Email from HTTP://www.DmailMan.Com
