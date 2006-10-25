Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030463AbWJYPJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbWJYPJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 11:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbWJYPJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 11:09:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:61411 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030463AbWJYPJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 11:09:26 -0400
Date: Wed, 25 Oct 2006 08:08:46 -0700
From: Greg KH <greg@kroah.com>
To: md@Linux.IT, linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: major 442
Message-ID: <20061025150846.GB23331@kroah.com>
References: <20061025102030.GA5790@wonderland.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061025102030.GA5790@wonderland.linux.it>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 12:20:30PM +0200, Marco d'Itri wrote:
> I just installed the Debian 2.6.18 kernel package and I noticed that it
> repeatedly tries to load a major 442 module alias, which appears to be
> used by the usb_endpoint devices.
> Does anybody know why? I am not even using the USB ports.

It doesn't matter if you are using them or not, they are being created
by the usb core for the next-version of usbfs.  They currently are not
hooked up to anything properly, but people are working on them to fix
that soon.

And the number is just a placeholder, it's not a reserved major number.

As for what is trying to load the module, I have no idea, it must be
some userspace tool...

thanks,

greg k-h
