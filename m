Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266361AbUAHW6Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266365AbUAHW6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:58:24 -0500
Received: from mail.kroah.org ([65.200.24.183]:19429 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266361AbUAHW6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:58:18 -0500
Date: Thu, 8 Jan 2004 14:58:13 -0800
From: Greg KH <greg@kroah.com>
To: andreamrl <andreamrl@tiscali.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.6.1-rc1-mm2
Message-ID: <20040108225813.GA3180@kroah.com>
References: <200401081629.20497.andreamrl@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401081629.20497.andreamrl@tiscali.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 04:29:20PM +0100, andreamrl wrote:
> When i stop to messing around with a sane backend and i disconnect the power 
> cord of my USB scanner, system generates a kernel oops (kernel 
> 2.6.1-rc1-mm2). 
> I attach the oops log hoping be useful.

There seems to be a bug in the scanner driver, a number of people have
reported this :(

This driver isn't needed at all, just use xsane which uses libusb/usbfs
to talk to the scanner.  That way no more oopses :)

Also, try sending this to the scanner driver maintainer, he's usually
quite responsive about these kinds of issues.

thanks,

greg k-h
