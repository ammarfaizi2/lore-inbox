Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbUBWBHD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 20:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUBWBHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 20:07:03 -0500
Received: from smtp.vnoc.murphx.net ([217.148.32.26]:41715 "HELO
	smtp.vnoc.murphx.net") by vger.kernel.org with SMTP id S261301AbUBWBGz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 20:06:55 -0500
Message-ID: <40395346.3040300@gadsdon.giointernet.co.uk>
Date: Mon, 23 Feb 2004 01:11:34 +0000
From: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040206
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>
Subject: 2.6.x support for prism2 USB wireless adapter?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had my Linksys prism2 USB wireless adapter (WUSB11 v2.5) working 
reasonably well with kernel 2.4.23, but with kernel 2.6.3 (and udev 018) 
I get:

usb 1-1: new full speed USB device using address 5
drivers/usb/core/config.c: invalid interface number (1/1)
usb 1-1: can't read configurations, error -22

#modprobe prism2_usb     gives:
prism2usb_init: prism2_usb.o: 0.2.1-pre20 Loaded
prism2usb_init: dev_info is: prism2_usb
drivers/usb/core/usb.c: registered new driver prism2_usb

#lsusb     does not show the device at all...

Is this still 'work in progress'?


Robert Gadsdon

