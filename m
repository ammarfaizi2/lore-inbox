Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264880AbUE2OIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbUE2OIF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 10:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUE2OIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 10:08:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14785 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264880AbUE2OIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 10:08:01 -0400
Date: Sat, 29 May 2004 16:08:00 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: 2.6-BK usb (printing) broken
Message-ID: <20040529140757.GA16264@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Something between 2.6.7-rc1 and current 2.6-BK broke usb printing here
again. I have two printers attached:

usb 1-1: new full speed USB device using address 6
usb 1-1: control timeout on ep0out
usb 1-1: control timeout on ep0out
usb 1-1: device not accepting address 6, error -110
usb 1-1: new full speed USB device using address 7
usb 1-1: control timeout on ep0out
usb 1-1: control timeout on ep0out
usb 1-1: device not accepting address 7, error -110

It's a VIA EPIA-800 board, lspci shows the following for usb:

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 24)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 24)

-- 
Jens Axboe

