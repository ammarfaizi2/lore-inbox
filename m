Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269324AbTGUORu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 10:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270109AbTGUORu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 10:17:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:14738 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269324AbTGUORs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 10:17:48 -0400
Date: Mon, 21 Jul 2003 10:31:40 -0400
From: Greg KH <greg@kroah.com>
To: Ronald Jerome <imun1ty@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: INIT:   USB FATAL in for Kernel 2.5.xx and 2.6.xx in Redhat v9.0  PLease Read.
Message-ID: <20030721143140.GB9401@kroah.com>
References: <20030720211048.19155.qmail@web13308.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030720211048.19155.qmail@web13308.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 20, 2003 at 02:10:48PM -0700, Ronald Jerome wrote:
> 
> One thing I knwo for sure is that in 2.5.xx and 2.6.xx
> kernels there is no usb-uhci.o driver.  I believe they
> changes the name and I wonder if this is why I am
> having problems booting the 2.5.xx and 2.6.xx serieis
> kernels?

That is probably your problem :)

Try loading the uhci-hcd module and see if your usb devices now work.

thanks,

greg k-h
