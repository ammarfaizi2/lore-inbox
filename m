Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUDFTrQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 15:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbUDFTrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 15:47:16 -0400
Received: from bender.bawue.de ([193.7.176.20]:38840 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S263100AbUDFTrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 15:47:14 -0400
Date: Tue, 6 Apr 2004 21:47:08 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: libusb scanner hangs with 2.6.x-mm kernels
Message-ID: <20040406194708.GB13257@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

since 2.6.3-mm4 most of the mm-kernels cause a complete hang of libusb
applications accessing my Epson perfection 1260 scanner.  Disabling
hotplug (i.e. replacing /sbin/hotplug with /bin/true)  solved the
problem on some kernels, on others this made my usb mouse unusable.
Plain vanilla kernels and rc-series work fine.  There has been some
discussion on this topic on the usb-developer's list.  I'm not sure if
this problem is already addressed on the kernel mailing list.

This problem prevents me from using mm-kernels.

-jo

-- 
-rw-r--r--    1 jo       users          80 2004-04-06 18:59 /home/jo/.signature
