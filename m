Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbUL0NeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbUL0NeI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 08:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbUL0NeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 08:34:08 -0500
Received: from mail.x-echo.com ([195.101.94.2]:30944 "EHLO mail.x-echo.com")
	by vger.kernel.org with ESMTP id S261895AbUL0NeE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 08:34:04 -0500
From: Serge Tchesmeli <zztchesmeli@echo.fr>
Organization: Transiciel
To: Andrew Benton <andy@benton987.fsnet.co.uk>
Subject: Re: 2.6.10 and speedtouch usb
Date: Mon, 27 Dec 2004 14:33:28 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200412271108.47578.zztchesmeli@echo.fr> <41D00D67.1010307@benton987.fsnet.co.uk>
In-Reply-To: <41D00D67.1010307@benton987.fsnet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200412271433.28454.zztchesmeli@echo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 27 Décembre 2004 14:25, Andrew Benton a écrit :
> Serge Tchesmeli wrote:
> > Hi,
> >
> > i have try the new kernel 2.6.10, compil with exactly the same option
> > from my 2.6.9 (i have copied the .config) but i notice a high load on my
> > machine, and i see that was syslogd.
> > So, i look at my log and see:
> >
> > Dec 26 19:40:44 gateway last message repeated 137 times
> > Dec 26 19:40:46 gateway kernel: usb 2-1: events/0 timed out on ep0in
> > Dec 26 19:40:46 gateway kernel: SpeedTouch: Error -110 fetching device
> > status Dec 26 19:40:46 gateway kernel: usb 2-1: modem_run timed out on
> > ep0in Dec 26 19:40:46 gateway kernel: usb 2-1: usbfs: USBDEVFS_CONTROL
> > failed cmd modem_run rqt 192 rq 18 len 8 ret -110
>
> Are you using the kernel or userspace driver?

I'm using the kernel speedtouch driver.

info: i have made "make oldconfig" :) (i say that before some users ask me in 
private)
