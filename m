Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTK1QWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 11:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTK1QWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 11:22:55 -0500
Received: from slimnet.xs4all.nl ([194.109.194.192]:50365 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S262591AbTK1QWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 11:22:54 -0500
Subject: 2.6.0-test11: sbp2 trouble
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1070036586.8571.15.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 28 Nov 2003 17:23:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am experiencing sbp2 problems With the current test11. Somehow
it keeps telling me that it has problems logging in to one of my
external sbp2 devices.

ieee1394: sbp2: Error logging into SBP-2 device - login timed-out

This is even after I do a power cycle on the failing device.

I have two IEEE1394 interface in my system. One is a onboard VIA
controller the other one is on a Audigy2 card.

ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[20]  MMIO=[feaff800-feafffff]  Max
Packet=[2048]
ohci1394_1: OHCI-1394 1.1 (PCI): IRQ=[20]  MMIO=[feaff000-feaff7ff]  Max
Packet=[2048]

The SBP2 module only seems to be able to log in to the device connected
to the Audigy2 firewire controller. The kernel is compiled with SMP
enabled.

Jurgen

