Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVFWNNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVFWNNF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 09:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVFWNMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 09:12:47 -0400
Received: from mail.harcroschem.com ([208.188.194.242]:39172 "EHLO
	kcdc1.harcros.com") by vger.kernel.org with ESMTP id S261900AbVFWNKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 09:10:11 -0400
Message-ID: <D9A1161581BD7541BC59D143B4A06294021FAA7C@KCDC1>
From: "Hodle, Brian" <BHodle@harcroschem.com>
To: "'Bharath Ramesh'" <krosswindz@gmail.com>, linux-kernel@vger.kernel.org
Subject: RE: [2.6.12] System becomes unresponsive with USB errors
Date: Thu, 23 Jun 2005 08:05:35 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bharath,
   I also have an Athlon 64 workstation, and had the same problem. You need
to disable legacy USB support in your BIOS.

-Brian

-----Original Message-----
From: Bharath Ramesh [mailto:krosswindz@gmail.com]
Sent: Wednesday, June 22, 2005 7:21 PM
To: linux-kernel@vger.kernel.org
Subject: [2.6.12] System becomes unresponsive with USB errors


I am running the 2.6.12 kernel on my Athlon64 workstation. I am using
the Microsoft Wireless Optical Desktop keyboard and mice. Every now
and then my system becomes unresponsive to the input devices. I can
still login remotely and my dmesg is full of the following message:

drivers/usb/input/hid-core.c: input irq status -75 received

I have filed this bug at bugme.osdl.org the bug number is 4724.

http://bugzilla.kernel.org/show_bug.cgi?id=4724
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
