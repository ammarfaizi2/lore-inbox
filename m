Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266907AbTGKWN1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 18:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266799AbTGKWN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 18:13:27 -0400
Received: from mail.kroah.org ([65.200.24.183]:7918 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266813AbTGKWN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 18:13:26 -0400
Date: Fri, 11 Jul 2003 15:23:28 -0700
From: Greg KH <greg@kroah.com>
To: imunity@softhome.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB-UHCI Fatal Error for all 2.5 kernels and 2.5.75 in RedHat v9.0 (fwd)
Message-ID: <20030711222328.GA23189@kroah.com>
References: <courier.3F0E58EC.000047AD@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.3F0E58EC.000047AD@softhome.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 12:27:56AM -0600, imunity@softhome.net wrote:
> 
> I just carefully read the error and now figured out why its FATAL. 
> 
> It cannot find the usb-uhci.o module 

The module is now called uhci-hcd.o, not usb-uhci.o

I guess this should be in Dave's document, I'll go send him email about
that...

Hope this helps,

greg k-h
