Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVCZS2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVCZS2n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 13:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVCZS2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 13:28:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:39811 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261204AbVCZS2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 13:28:41 -0500
Date: Sat, 26 Mar 2005 10:28:28 -0800
From: Greg KH <greg@kroah.com>
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050326182828.GA8540@kroah.com>
References: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 05:52:20PM +0000, Mark Fortescue wrote:
> 
> I am writing a "Proprietry" driver module for a "Proprietry" PCI card and
> I have found that I can't use SYSFS on Linux-2.6.10.
> 
> Why ?. 

What ever gave you the impression that it was legal to create a
"Proprietry" kernel driver for Linux in the first place.  I seriously
encourage you to consult your company's legal department if you insist
on attempting to do this, as they will be contacted by others after your
driver is released.

> I am not modifing the Kernel/SYSFS code so I should be able, to use all
> the SYSFS/internal kernel function calls without hinderence.

I'm sorry, but as you have found out, that is not possible.

> I believe that this sort of idiocy is what helps Microsoft hold on to its
> manopoly and as shuch hinders hardware/software development in all areas
> and should be chanaged in a way that promotes diversified software
> development.

If your company does not agree with the current license of the Linux
kernel, which prevents you from creating "Proprietry" drivers, then do
not write or create such drivers in the first place.  We (the kernel
community) are not forcing you to write a Linux driver.

However, if you do wish to create a Linux driver, you _must_ abide by
the legal requirements of the kernel, which I feel, along with every IP
lawyer I have ever consulted, that it is not allowed to create a non-GPL
compatible kernel module.

Good luck,

greg k-h
