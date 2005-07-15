Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263254AbVGOJU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263254AbVGOJU3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 05:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263255AbVGOJU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 05:20:29 -0400
Received: from bay106-f24.bay106.hotmail.com ([65.54.161.34]:30631 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263254AbVGOJU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 05:20:27 -0400
Message-ID: <BAY106-F24AA8EC580378C0F66BAA5D9D00@phx.gbl>
X-Originating-IP: [23.251.190.230]
X-Originating-Email: [axel__17@hotmail.com]
From: "Axel Dine" <axel__17@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: i2o vs dpt-i2o
Date: Thu, 14 Jul 2005 23:20:24 -1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 15 Jul 2005 09:20:24.0643 (UTC) FILETIME=[6E891930:01C5891E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,
I have an Adaptec 2110S controller on an A7M266-D dual AMD Athlon MP
rig running a Debian Sarge 3.1 stable.

I am considering which driver between i2o and dpt-i2o using: according
to your experience which one is preferrable performance and reliably
wise?

I have installed the i2o native driver and the linux kernel change the
order of my disk (like /dev/sda became /dev/i2o/hdc): is there any way to
have a consistent drive order (i.e. /dev/sda -> /dev/i2o/hdc)?

Last question: I started with the dpt-i2o and installed grub on the first 
disk array, then I moved to the i2o native driver (statically compiled in 
the kernel), without appling any patch and everything runs smoothly: how is 
this possible? I would have expected some errors with frub not recognizing 
the /dev/i2o/hdx devices.

Ciao
AxeL


