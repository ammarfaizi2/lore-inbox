Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbTJ2HQG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 02:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTJ2HQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 02:16:06 -0500
Received: from mail.mediaways.net ([193.189.224.113]:15852 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S261740AbTJ2HQE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 02:16:04 -0500
Subject: usb devices get redetected all the time in 2.6.0-test{7,9}
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1067411725.1577.19.camel@localhost>
Mime-Version: 1.0
Date: Wed, 29 Oct 2003 08:15:26 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

When I attach a camera to a 2.4. based machine hotplug starts up some
script to download images of that camera and fine thats it.

In 2.6.0-testX I see kernel messages like:

hub 2-0:1.0: new USB device on port 1, assigned address 2
bus usb: add device 2-1
bound device '2-1' to driver 'usb'
bus usb: add device 2-1:1.0
bus usb: remove device 2-1:1.0
bus usb: add device 2-1:1.0
bus usb: remove device 2-1:1.0
bus usb: add device 2-1:1.0
bus usb: remove device 2-1:1.0
bus usb: add device 2-1:1.0
[...]

and several of these hotplug scripts get started... Is this a wanted
behaviour and something has to be fixed in userspace or is it a kernel
bug ?

Soeren

