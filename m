Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbTDIJiZ (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 05:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbTDIJiZ (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 05:38:25 -0400
Received: from mail.mediaways.net ([193.189.224.113]:19681 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S262952AbTDIJiY (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 05:38:24 -0400
Subject: 2.4.21pre6 usb+devfs usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt
	128 rq 6 len 9 ret -6
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049881235.2773.71.camel@fortknox>
Mime-Version: 1.0
Date: 09 Apr 2003 11:40:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last strange message I could not make any sense of. Everything at least
pretends to work, but at bootup I get:

usb-uhci.c: ENXIO 80000280, flags 0, urb f6289dc0, burb f6289b40
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb f6289dc0, burb f6289b40
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb f6289dc0, burb f6289b40
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb f6289b40, burb f6289dc0
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 9 ret -6

Soeren.

