Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVEaXWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVEaXWJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 19:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVEaXWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 19:22:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:10935 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261156AbVEaXWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 19:22:06 -0400
Date: Tue, 31 May 2005 16:20:25 -0700
From: Greg KH <greg@kroah.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: dpervushin@ru.mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] SPI core
Message-ID: <20050531232025.GA23881@kroah.com>
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru> <200506010044.34559.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506010044.34559.adobriyan@gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 12:44:34AM +0400, Alexey Dobriyan wrote:
> On Tuesday 31 May 2005 20:09, dmitry pervushin wrote:
> > In order to support the specific board, we have ported the generic SPI core
> > to the 2.6 kernel. This core provides basic API to create/manage SPI devices
> > like the I2C core does. We need to continue providing support of SPI devices
> > and would like to maintain the SPI subtree.
> 
> > +#ifdef CONFIG_DEVFS_FS
> > +#include <linux/devfs_fs_kernel.h>
> > +#endif
> 
> devfs will be removed from mainline in a month.

True, but the #ifdef should never be there in the first place...

thanks,

greg k-h
