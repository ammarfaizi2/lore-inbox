Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUFJQQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUFJQQh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 12:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUFJQQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 12:16:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:21466 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261939AbUFJQPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 12:15:48 -0400
Date: Thu, 10 Jun 2004 09:14:42 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Couple of sysfs patches
Message-ID: <20040610161442.GC31787@kroah.com>
References: <20040610144658.31403.qmail@web81309.mail.yahoo.com> <20040610170607.A5830@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040610170607.A5830@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 05:06:07PM +0100, Russell King wrote:
> 
> Now that I can see the platform device interfaces multipling like rabbits,
> (to GregKH) I think that the patch I submitted for platform_add_device
> suffers from this problem as well, and I should've thrown that code
> into platform_register_device itself.
> 
> Greg - comments?  Would you like a new patch which does that, or do you
> think that's too risky?

Hm, I don't think it's too risky.  Make up a patch and let's see how it
looks.

I'm just worried that this "simple" interface really isn't so simple, as
it's almost just as much work to manage it as a normal platform device.

thanks,

greg k-h
