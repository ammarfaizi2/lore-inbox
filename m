Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbUAFTbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 14:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264943AbUAFTbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 14:31:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:7889 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264941AbUAFTbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 14:31:49 -0500
Date: Tue, 6 Jan 2004 11:25:43 -0800
From: Greg KH <greg@kroah.com>
To: lk@rekl.yi.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: KM266/VT8235, USB2.0 and problems
Message-ID: <20040106192543.GC11989@kroah.com>
References: <Pine.LNX.4.58.0401042314160.18200@rekl.yi.org> <20040105081226.GA14177@kroah.com> <Pine.LNX.4.58.0401051045270.30821@rekl.yi.org> <20040105172306.GB21531@kroah.com> <Pine.LNX.4.58.0401052145520.32347@rekl.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401052145520.32347@rekl.yi.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 09:52:04PM -0600, lk@rekl.yi.org wrote:
> > > > Do the errors go away if you stop using devfs?
> > > 
> 
> Ok, I removed devfs support from the kernel, and installed udev on the 
> machine.  I get the same error:

You don't get the oops anymore, which is good.

> SCSI error : <0 0 0 0> return code = 0x70000
> end_request: I/O error, dev sda, sector 7552
> Buffer I/O error on device sda, logical block 944

Can you enable CONFIG_USB_STORAGE_DEBUG and send the debug log to the
linux-usb-devel mailing list for when this happens?  The people there
should be able to help you out.

thanks,

greg k-h
