Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTHaR37 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 13:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbTHaR37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 13:29:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:27596 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262315AbTHaR36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 13:29:58 -0400
Date: Sun, 31 Aug 2003 10:28:12 -0700
From: Greg KH <greg@kroah.com>
To: root@mauve.demon.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB userspace tools.
Message-ID: <20030831172812.GA20548@kroah.com>
References: <20030831115903.GA2298@pasky.ji.cz> <200308311244.NAA19278@mauve.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308311244.NAA19278@mauve.demon.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 01:44:17PM +0100, root@mauve.demon.co.uk wrote:
> Is there a tool for accessing USB devices, without actually writing
> a driver? Or perhaps more accurately a driver in scriptorspace.
> Perhaps something that exports a number of named pipes that correspond
> to endpoints?

Look at libusb which uses usbfs to do that from userspace without
writing a kernel driver.

Good luck,

greg k-h
