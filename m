Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUDNRFr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 13:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbUDNRFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 13:05:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:35814 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261313AbUDNRFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 13:05:21 -0400
Date: Wed, 14 Apr 2004 09:57:23 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@free.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] USB speedtouch: fix memory leak in error path
Message-ID: <20040414165723.GB7945@kroah.com>
References: <200404131115.25784.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404131115.25784.baldrick@free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 11:15:25AM +0200, Duncan Sands wrote:
> Hi Greg, this patch fixes a memory leak in the speedtouch driver.
> The leak occurs when the ATM layer submits a skbuff for transmission,
> but the driver rejects it (because the device has been unplugged for
> example).  The ATM layer requires the driver to free the skbuff in this
> case.  The patch is against your 2.6 kernel tree.

Applied, thanks.

greg k-h
