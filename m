Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUFRUrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUFRUrj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUFRUpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:45:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:28812 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262101AbUFRUl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:41:29 -0400
Date: Fri, 18 Jun 2004 13:39:05 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Couple of sysfs patches
Message-ID: <20040618203905.GA18523@kroah.com>
References: <20040610144658.31403.qmail@web81309.mail.yahoo.com> <20040610191740.B6833@flint.arm.linux.org.uk> <20040610212552.C6833@flint.arm.linux.org.uk> <200406161751.03574.dtor_core@ameritech.net> <20040618202949.B17516@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618202949.B17516@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 08:29:49PM +0100, Russell King wrote:
> On Wed, Jun 16, 2004 at 05:51:03PM -0500, Dmitry Torokhov wrote:
> > What about freeing the resources? Can it be put in platform_device_unregister
> > or is it release handler task? I'd put it in unregister because when I call
> > unregister I expect device be half-dead and release as much resources as it
> > can.
> 
> Greg,
> 
> Here's the updated patch - to be applied on top of the
> platform_get_resource() patch sent previously.

Looks good, thanks I've applied this and will send it on.

greg k-h
