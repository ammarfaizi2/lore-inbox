Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVAZMT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVAZMT0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 07:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVAZMT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 07:19:26 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:2018 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262280AbVAZMTX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 07:19:23 -0500
Date: Wed, 26 Jan 2005 13:20:14 +0100
From: DervishD <lkml@dervishd.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-usb-users@lists.sourceforge.net
Subject: USB API, ioctl's and libusb
Message-ID: <20050126122014.GF58@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi everybody :)

    I've been solving a USB problem related to a digital photo
camera, and I've noticed that 'libusb' uses a ioctl interface to the
USB kernel system. In fact it implements 'usb_control_msg()' using
ioctl's. On the other hand, the kernel itself (I'm talking about
2.4.29) provides an API in <linux/usb.h> that implements too
'usb_control_msg()' using URB's.

    My question is: which interface should be used by user space
applications, <linux/usb.h> or ioctl's? Is the ioctl interface
deprecated in any way? In the "Programming guide for Linux USB Device
Drivers", located in http://usb.in.tum.de/usbdoc/, I can't find ioctl
interface references :?

    Thanks a lot in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
