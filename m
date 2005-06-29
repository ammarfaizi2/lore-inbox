Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVF2QOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVF2QOm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVF2QKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:10:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:11984 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261583AbVF2QHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:07:21 -0400
Date: Wed, 29 Jun 2005 09:06:59 -0700
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Mike Bell <kernel@mikebell.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050629160659.GA23594@kroah.com>
References: <20050624081808.GA26174@kroah.com> <200506281400.08777.oliver@neukum.org> <20050628200824.GA12851@kroah.com> <200506290841.29785.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506290841.29785.oliver@neukum.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 08:41:29AM +0200, Oliver Neukum wrote:
> What devfs and udev can do, and a static dev cannot, is names independent
> of order of detection.

devfs can not do that.

> As for ressources, it is an illusion to think that user space means
> less ressources. A demon means page tables and a kernel stack. That
> 12K unswappable memory in the best case.

You don't have to run the udevd process if you are worried about an
extra process in your kernel tables.  Although this is the first time I
have heard anyone voice the "oh no, not another userspace task running"
point :)

thanks,

greg k-h
