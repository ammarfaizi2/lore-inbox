Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbUKMA6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbUKMA6D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbUKMA4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 19:56:47 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:30937 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261686AbUKMAyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 19:54:23 -0500
Date: Fri, 12 Nov 2004 16:54:13 -0800
From: Greg KH <greg@kroah.com>
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB-Serial fails with USB 2.0 Hub
Message-ID: <20041113005413.GA18374@kroah.com>
References: <6.1.1.1.0.20041108074026.01dead50@ptg1.spd.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.1.1.1.0.20041108074026.01dead50@ptg1.spd.analog.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 07:49:09AM -0800, Robin Getz wrote:
> Hi.
> 
> Two problems with kernel 2.6.4 (SuSe 9.1):
> 
> 1) When I use a Belkin F5U409 usb-serial converter:
>     - when plugged directly into chipset (Intel ICH5), works great.
>     - when plugged in through a USB 1.0 hub, works great
>     - when plugged in throught USB 2.0 Hub (Belkin F5U237), fails.
>       Failure mechanism is: Tx works, Rx does not.

Known issue.  See the linux-usb-devel mailing list for more details.

For now, just don't do that :)

thanks,

greg k-h
