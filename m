Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbUDKUxD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 16:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUDKUxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 16:53:03 -0400
Received: from mail.kroah.org ([65.200.24.183]:7863 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262473AbUDKUxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 16:53:00 -0400
Date: Sun, 11 Apr 2004 13:51:19 -0700
From: Greg KH <greg@kroah.com>
To: wim delvaux <wim.delvaux@adaptiveplanet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: crash of usb ... backtrace included.
Message-ID: <20040411205119.GA23434@kroah.com>
References: <200404111408.08828.wim.delvaux@adaptiveplanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404111408.08828.wim.delvaux@adaptiveplanet.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2004 at 02:08:08PM +0200, wim delvaux wrote:
> 
> This happened when trying to use a usb bluetooth dongle on my system

Yes, there are multiple problems with the bluetooth driver and the USB
system right now.  A number of them have been worked out, and should be
fixed in the -mm tree, but there are still a few left to be done to the
bluetooth driver itself, patches are available on the linux-usb-devel
mailing list for them to be blessed by the bluetooth maintainer.

It seems that lots of things broke this driver all at once, a few of
which were always bugs, but are just now getting hit due to timing
changes...

Sorry about this.

greg k-h
