Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266492AbUA2XC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 18:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266494AbUA2XC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 18:02:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:35491 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266492AbUA2XCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 18:02:51 -0500
Date: Thu, 29 Jan 2004 15:02:50 -0800
From: Greg KH <greg@kroah.com>
To: Jonas Diemer <diemer@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which interface: sysfs, proc, devfs?
Message-ID: <20040129230250.GA9988@kroah.com>
References: <20040129222813.3b22b2c8.diemer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129222813.3b22b2c8.diemer@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 10:28:13PM +0100, Jonas Diemer wrote:
> Hi!
> 
> I am writing a driver for an usb microcontroller (ezusb), which will be
> used for measuring and controlling. I am confused on which interface to
> use though. The driver is for kernel 2.6.x. 
> I want to send small (human readable) commends as well as data (e.g.
> firmware) to the device. Which filesystem is appropriate?

What about not writing a kernel driver at all and just using
libusb/usbfs?  Any reason you have to have a kernel driver for your
device?

thanks,

greg k-h
