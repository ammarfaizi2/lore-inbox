Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265987AbUAUSWh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 13:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUAUSWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 13:22:37 -0500
Received: from mail.kroah.org ([65.200.24.183]:13282 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265987AbUAUSWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 13:22:36 -0500
Date: Wed, 21 Jan 2004 10:22:42 -0800
From: Greg KH <greg@kroah.com>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: My USB pendrive broke in 2.6.1
Message-ID: <20040121182241.GA12861@kroah.com>
References: <20040121172837.79127.qmail@web40909.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040121172837.79127.qmail@web40909.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 09:28:37AM -0800, Bradley Chapman wrote:
> Confirmed - the USB pendrive works perfectly fine without any errors in both Linux
> 2.6.0 and Windows XP.
> 
> Where should I look first for changes between .0 and .1, to troubleshoot this?

Please enable CONFIG_USB_STORAGE_DEBUG and send the kernel debug log to
the linux-usb-devel mailing list.  The people there should be able to
help you out.

Good luck,

greg k-h
