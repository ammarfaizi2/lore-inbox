Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVFWAXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVFWAXA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVFWAWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:22:37 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:60240 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261904AbVFWAUn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:20:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dezYXsVrkjTc0C5L7llsCrV2a9LkEPpmLXJmDZSdupRC+SNDOldpJUIx2AVcBrOxxpHocVFSSA8rnBfISyIKYWmyBEyAF4aw9baiU7JLHmOlV2/32vPKbLR1IpAix78DwXuHB4O+d71GHtLAdFyZjcr1DCl81w0JhuRuC6g8KGE=
Message-ID: <c775eb9b050622172073afec9d@mail.gmail.com>
Date: Wed, 22 Jun 2005 20:20:41 -0400
From: Bharath Ramesh <krosswindz@gmail.com>
Reply-To: Bharath Ramesh <krosswindz@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.12] System becomes unresponsive with USB errors
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running the 2.6.12 kernel on my Athlon64 workstation. I am using
the Microsoft Wireless Optical Desktop keyboard and mice. Every now
and then my system becomes unresponsive to the input devices. I can
still login remotely and my dmesg is full of the following message:

drivers/usb/input/hid-core.c: input irq status -75 received

I have filed this bug at bugme.osdl.org the bug number is 4724.

http://bugzilla.kernel.org/show_bug.cgi?id=4724
