Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWBHVHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWBHVHp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWBHVHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:07:44 -0500
Received: from mailhost3.gsfc.nasa.gov ([128.183.244.224]:29349 "EHLO
	mailhost3.gsfc.nasa.gov") by vger.kernel.org with ESMTP
	id S964910AbWBHVHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:07:44 -0500
Message-Id: <6.2.1.2.2.20060208161352.01fc65a0@pop200.gsfc.nasa.gov>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.1.2
Date: Wed, 08 Feb 2006 16:15:30 -0500
To: linux-kernel@vger.kernel.org
From: Uthra Rao <urao@pop200.gsfc.nasa.gov>
Subject: USB -UPS Problem on FC4
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have configured "nuts" UPS software on a Fedora core 4 machine. I have 
configured it for USB port. I have also put in a rule in 
/etc/udev/rules.d/10-custom.rules as follows:

BUS="usb", KERNEL="hiddev0" MODE="667" OWNER="nut"

when I do #upsc smartups@localhost, the staus looks o.k.

I don't know why I am getting the following error message in my "messages" 
file:

***************************************************************************************************
Feb  8 11:26:42 peace kernel: drivers/usb/input/hid-core.c: 
usb_submit_urb(ctrl) failed
Feb  8 11:26:42 peace kernel: drivers/usb/input/hid-core.c: timeout 
initializing reports
*****************************************************************************************************
It is a APC Smart-UPS 1500.

Any help would be greatly appreciated.

Thank you.


