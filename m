Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263722AbUECOys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbUECOys (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 10:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUECOys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 10:54:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:4569 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263722AbUECOyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 10:54:46 -0400
Date: Mon, 3 May 2004 07:54:13 -0700
From: Greg KH <greg@kroah.com>
To: Joerg Pommnitz <pommnitz@yahoo.com>
Cc: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Software based unplug of USB device?
Message-ID: <20040503145413.GA31691@kroah.com>
References: <20040503102120.23966.qmail@web41314.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503102120.23966.qmail@web41314.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 12:21:20PM +0200, Joerg Pommnitz wrote:
> Hello listees,
> we are struggling with a 3rd party USB device. It comes with its own
> firmware and its own Linux USB serial drivers.

Which device and driver is this?  Do you have a pointer to the driver?

> Unfortunately the
> communication between the device and the user application seems to break
> down from time to time. This situation can easily be resolved by
> unplugging and then re-plugging the device. Unfortunately this requires
> manual intervention.
> While resolving the real issue would be the preferred way to deal with
> this problem, we would settle for a way to do a software unplug/re-plug.

Do you want to do this from within the kernel, or from userspace?  If
from within the kernel, you should be able to drop the power to a hub
port and reenable it, but I haven't checked to see if that works in a
long time.

thanks,

greg k-h
