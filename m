Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265999AbUGIWRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUGIWRd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 18:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266005AbUGIWRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 18:17:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:164 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265999AbUGIWRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 18:17:31 -0400
Date: Fri, 9 Jul 2004 15:15:40 -0700
From: Greg KH <greg@kroah.com>
To: Michael Geithe <warpy@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm7
Message-ID: <20040709221540.GB6284@kroah.com>
References: <20040708235025.5f8436b7.akpm@osdl.org> <200407091344.32938.warpy@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407091344.32938.warpy@gmx.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 01:44:32PM +0200, Michael Geithe wrote:
> Am Freitag, 9. Juli 2004 08:50 schrieben Sie:
> > 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/
> 
> Hi,
> reverting bk-usb.patch makes it boot.

Do you have any USB devices plugged in?  If so, unplug them during the
boot process (or use a different distro that doesn't try to autoload the
usb drivers at boot time...)

It's a known bug that people are working on.

thansk,

greg k-h
