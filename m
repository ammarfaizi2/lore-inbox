Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbTKBRxy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 12:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTKBRxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 12:53:53 -0500
Received: from hal-4.inet.it ([213.92.5.23]:21398 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id S261763AbTKBRxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 12:53:52 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: linux-kernel@vger.kernel.org
Subject: test9 and bluetooth
Date: Sun, 2 Nov 2003 18:53:47 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311021853.47300.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bluetooth USB crashses

I'm playing with a Bluetooth USB dongle (D-LINK DBT 120) and it works quite 
well,  but when I unplug the dongle the system freeezes immediately. I've 
tried to unplug other USB devices as scanner or printer but without crashes.

System: PIV 2.8 Abit IC7-G MB;
2.6.0-test9 #3 SMP
Relevant Modules:
bnep
l2cap
bluetooth
uhci_hcd
ehci_hcd
hci_usb
rfcomm

I'm not using devfs but udev/sysfs.

I get no informations/messages in logs.
I'm using the same dogle and usb devices on a 2.4.21 kernel (on a different 
HW) and I can remove the dongle without any problem.

If more informations or tries are needed just let me know.

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

