Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263240AbTJKCf5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 22:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbTJKCf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 22:35:57 -0400
Received: from mail.kroah.org ([65.200.24.183]:29851 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263240AbTJKCf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 22:35:56 -0400
Date: Fri, 10 Oct 2003 19:31:58 -0700
From: Greg KH <greg@kroah.com>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird stuff with USB and Bluetooth
Message-ID: <20031011023158.GE19749@kroah.com>
References: <1065744760.1344.2.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065744760.1344.2.camel@chevrolet.hybel>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 02:12:40AM +0200, Stian Jordet wrote:
> Hi,
> 
> I get these lines in my dmesg at boot-time:
> 
> usb 1-2: device not accepting address 3, error -110
> hci_usb: probe of 1-2:1.1 failed with error -5
> hci_usb: probe of 1-2:1.2 failed with error -5
> usb 1-2: USB disconnect, address 4
> usb 1-2: device not accepting address 5, error -110
> hci_usb: probe of 1-2:1.1 failed with error -5
> hci_usb: probe of 1-2:1.2 failed with error -5
> 
> Which often means that the usb-hc can't get an interrupt, I have read.
> The "problem" is that I have several usb devices (scanner, printer,
> usbserial, hid) and I get no such error with them, only the Bluetooth.
> And even weirder, the BT-dongle works just perfect.
> 
> So my question is; what does this messages means?

You have a broken device, sorry.

greg k-h
