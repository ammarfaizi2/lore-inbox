Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbVCJWUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbVCJWUy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbVCJWNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:13:52 -0500
Received: from A.painless.aaisp.net.uk ([81.187.81.51]:31159 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S263272AbVCJWIU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:08:20 -0500
Subject: Problem with 2.6.11-bk[3456]
From: Andrew Clayton <andrew@digital-domain.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 22:08:19 +0000
Message-Id: <1110492499.2666.8.camel@alpha.digital-domain.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Got a problem here with the last few Linus -bk releases.

2.6.11-bk2 is running fine.

2.6.11-bk3 - 2.6.11-bk6 has the following problem:

Everything is fine while the machine is booting. However as soon as X
starts up the screen goes blank as normal but stays blank, no gdm login
screen and the hard disk and floppy drive lights are on continuously.
The machine is now locked up solid and needs a hard reset.

I tried a serial console but get nothing after the kernel messages and
the agetty login.

The machine is question is an UP Athlon 1800+ XP with 768MB RAM, the
graphics card is an AGP ATI Radeon 9200SE using the kernel AGP/DRM
drivers and the Xorg radeon driver.

It's running FC3.


I've put 2.6.11-bk2 and 2.6.11-bk6 config's, dmesg's and an lspc -vv up
on the web.

http://digital-domain.net/kernel/2.6.11-bk2.config
http://digital-domain.net/kernel/2.6.11-bk6.config
http://digital-domain.net/kernel/2.6.11-bk2.dmesg
http://digital-domain.net/kernel/2.6.11-bk6.dmesg
http://digital-domain.net/kernel/lspci-vv


When looking at this the other day I did get a message on the serial
console after X started and the machine locked, about uhci host
controller being disabled or something. Unfortunately I didn't make a
note of it and didn't get it today for when I was preparing this report.

Looking at the two dmesg's there is some difference in the usb messages.


Anyway, thanks for your time and if you need any more info just let me
know.


Cheers,

Andrew Clayton
 

