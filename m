Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbTIZVwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 17:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTIZVwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 17:52:40 -0400
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:39120 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261656AbTIZVwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 17:52:39 -0400
X-Originating-IP: [62.252.32.4]
From: <linuxmail@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5 USB Konica WebCam
Date: Fri, 26 Sep 2003 21:51:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <20030926215130.WZWA272.mta02-svc.ntlworld.com@[10.137.100.62]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The konicawc works fine on 2.4.22 - upgrading to 2.6.0-test5 results in the following error:-

drivers/usb/media/konicawc.c: Konica Webcam (rev. 0x0103)
drivers/usb/media/usbvideo.c: usbvideo_ClientIncModCount: uvd->handle->md_module == NULL
drivers/usb/media/usbvideo.c: usbvideo_ClientDecModCount: uvd->handle->md_module == NULL
videodev: "konicawc USB Camera" has no release callback. Please fix your driver for proper sysfs support, see http://lwn.net/Articles/36850/
drivers/usb/media/usbvideo.c: konicawc on /dev/video0: canvas=320x240 videosize=160x120
drivers/usb/media/konicawc.c: konicawc: Konicawc snapshot button on usb-0000:01:08.0-2.2/input0

drivers/usb/media/usbvideo.c: usbvideo_ClientIncModCount: uvd->handle->md_module == NULL
ohci-hcd 0000:01:08.0: bad entry 1637c800
drivers/usb/media/usbvideo.c: usbvideo_ClientDecModCount: uvd->handle->md_module == NULL
drivers/usb/media/usbvideo.c: usbvideo_ClientIncModCount: uvd->handle->md_module == NULL
drivers/usb/media/konicawc.c: Lost sync on frames
drivers/usb/media/konicawc.c: Lost sync on frames
drivers/usb/media/konicawc.c: usb_unlink_urb() error -22.
drivers/usb/media/konicawc.c: usb_unlink_urb() error -22.
drivers/usb/media/usbvideo.c: Packet Statistics: Total=5952. Empty=0. Usage=100%
drivers/usb/media/usbvideo.c: Transfer Statistics: Transferred=0 B Usage=0%
drivers/usb/media/usbvideo.c: usbvideo_ClientDecModCount: uvd->handle->md_module == NULL

-----------------------------------------
Email provided by http://www.ntlhome.com/


