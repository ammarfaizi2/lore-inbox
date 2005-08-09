Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbVHIJDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVHIJDd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVHIJDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:03:32 -0400
Received: from ws6-1.us4.outblaze.com ([205.158.62.196]:15846 "HELO
	ws6-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932458AbVHIJDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:03:32 -0400
Message-ID: <42F8715C.4000404@bakke.com>
Date: Tue, 09 Aug 2005 11:03:24 +0200
From: Dag Bakke <dag@bakke.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050808)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Enabling PCMCIA serial ports without pcmciautils/pcmcia_cs in 2.6?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am building a small root fs for an embedded target.
(Soekris 4521, which is an SC520 + yenta-compatible cardbus bridge)

Basing my system on kernel, uclibc and busybox, I can build a very lean, 
clean and compact root fs with a minimum of effort. (gentoo-embedded rocks!)

But getting my 4port serial pcmcia card enabled appears to require 
various stuff to be installed, just to get the card initialised: 
pcmcia_cs (or alternatively pcmciautils for 2.6.13), hotplug, pciutils, 
usbutils, libusb, sysfsutils(?).

Is this really necessary? I'd guess that serial cards are some of the 
simpler pcmcia targets to enable? (I could be very wrong..)
Anyone got an idea about alternative solutions, or can state the minimum 
binaries/files I need to enable this card? (Advantech COMpad-32/85B-4)


----
Dag B

