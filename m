Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTIRS24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 14:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTIRS24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 14:28:56 -0400
Received: from mail.kroah.org ([65.200.24.183]:41649 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262040AbTIRS2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 14:28:53 -0400
Date: Thu, 18 Sep 2003 11:29:03 -0700
From: Greg KH <greg@kroah.com>
To: Paco Ros <switch@tiscali.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: visor module and Palm Zire 71 problem.
Message-ID: <20030918182903.GC1846@kroah.com>
References: <200309132008.17716.switch@tiscali.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309132008.17716.switch@tiscali.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 08:08:17PM +0200, Paco Ros wrote:
> Hi!
> 
> I bought one of these nice Palm handhelds with integrated camera.
> I was running 2.4.20 kernel at that time and I modified the following files:
> - drivers/usb/serial/visor.h
>  added #define PALM_ZIRE71_ID			0x0060
> 
> - drivers/usb/serial/visor.c
>  added id_table and id_table_combined definitions.
> 
> You have both modified from 2.4.20 files here:
> http://bulmalug.net/~pacoros/articulos/visor.c
> http://bulmalug.net/~pacoros/articulos/visor.h

This device has been supported for a while now, just upgrade your kernel
please.

> They were working fine with pilot-link software.
> 
> Some weeks ago I compiled a 2.4.22-ac1 kernel and I saw that a new version of visor was released.
> I haven't been able to make my Zire 71 work with this kernel version.
> 
> The trick of adding PALM_ZIRE71_ID definition does not work anymore
> and I get a Oops! when the module tries to be removed.  Here is the
> log:

This device should just work with this kernel, the driver does not need
to be modified.

> I've been googling and looking for visor project and seems to be
> completely integrated in kernel tree and no news or movement is
> appreciated at usbvisor web site.

The usbvisor web site is dead as the maintainer for it has disappeared.
The kernel driver is kept quite up to date.

thanks,

greg k-h
