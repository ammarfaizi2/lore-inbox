Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262871AbVF3GdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262871AbVF3GdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbVF3Gbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:31:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:44951 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262871AbVF3G3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:29:31 -0400
Date: Wed, 29 Jun 2005 23:29:23 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Message-ID: <20050630062923.GA23712@kroah.com>
References: <11201114613610@kroah.com> <200506300125.40851.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506300125.40851.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 01:25:39AM -0500, Dmitry Torokhov wrote:
> On Thursday 30 June 2005 01:04, Greg KH wrote:
> > [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
> > 
> > This adds a single file, "unbind", to the sysfs directory of every
> > device that is currently bound to a driver.  To unbind the driver from
> > the device, write anything to this file and they will be disconnected
> > from each other.
> >
> 
> Comment and the patch disagree with each other.

bleah, you are right, that was the old comment with the new patch.  Oh
well...

thanks,

greg k-h
