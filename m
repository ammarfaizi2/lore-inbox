Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbUL3UUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbUL3UUT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 15:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUL3UUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 15:20:18 -0500
Received: from black.click.cz ([62.141.0.10]:47511 "EHLO click.cz")
	by vger.kernel.org with ESMTP id S261710AbUL3UUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 15:20:15 -0500
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: for USB guys - strange saying in switching HID proxy dongle
Date: Thu, 30 Dec 2004 21:18:10 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200412302118.10210.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

we discused it on bluez mailing list and this looks like your problem:

usb 3-1: USB disconnect, address 4
usb 3-1: new full speed USB device using uhci_hcd and address 5
input: USB HID v1.11 Keyboard [0a12:1000] on usb-0000:00:1d.2-1
input: USB HID v1.11 Mouse [0a12:1000] on usb-0000:00:1d.2-1
notas:/home/cijoml# hid2hci
Switching device 0a12:1000 to HCI mode failed (Invalid or incomplete multibyte 
or wide character)

----
Dongle is switched normally to HCI mode

Thanks for fixing

Michal
