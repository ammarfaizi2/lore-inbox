Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUL0KJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUL0KJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 05:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUL0KJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 05:09:26 -0500
Received: from mail.x-echo.com ([195.101.94.2]:63157 "EHLO mail.x-echo.com")
	by vger.kernel.org with ESMTP id S261378AbUL0KJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 05:09:23 -0500
From: Serge Tchesmeli <zztchesmeli@echo.fr>
Organization: Transiciel
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 and speedtouch usb
Date: Mon, 27 Dec 2004 11:08:47 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412271108.47578.zztchesmeli@echo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i have try the new kernel 2.6.10, compil with exactly the same option from my 
2.6.9 (i have copied the .config) but i notice a high load on my machine, and 
i see that was syslogd.
So, i look at my log and see:

Dec 26 19:40:44 gateway last message repeated 137 times
Dec 26 19:40:46 gateway kernel: usb 2-1: events/0 timed out on ep0in
Dec 26 19:40:46 gateway kernel: SpeedTouch: Error -110 fetching device status
Dec 26 19:40:46 gateway kernel: usb 2-1: modem_run timed out on ep0in
Dec 26 19:40:46 gateway kernel: usb 2-1: usbfs: USBDEVFS_CONTROL failed cmd 
modem_run rqt 192 rq 18 len 8 ret -110
Dec 26 19:40:46 gateway kernel: usb 2-1: usbfs: process 5296 (modem_run) did 
not claim interface 0 before use
Dec 26 19:40:49 gateway last message repeated 413 times
Dec 26 19:40:51 gateway kernel: usb 2-1: events/0 timed out on ep0in
Dec 26 19:40:51 gateway kernel: SpeedTouch: Error -110 fetching device status
Dec 26 19:40:51 gateway kernel: usb 2-1: modem_run timed out on ep0in
Dec 26 19:40:51 gateway kernel: usb 2-1: usbfs: USBDEVFS_CONTROL failed cmd 
modem_run rqt 192 rq 18 len 8 ret -110
Dec 26 19:40:51 gateway kernel: usb 2-1: usbfs: process 5296 (modem_run) did 
not claim interface 0 before use
Dec 26 19:40:59 gateway last message repeated 1105 times

The speedtouch modem work, connection is etablished and work well.
