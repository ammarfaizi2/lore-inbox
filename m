Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVKFUlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVKFUlN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 15:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVKFUlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 15:41:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:21973 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751217AbVKFUlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 15:41:13 -0500
Date: Sun, 6 Nov 2005 12:39:38 -0800
From: Greg KH <greg@kroah.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Add platform_driver
Message-ID: <20051106203938.GD2527@kroah.com>
References: <20051105181122.GD12228@flint.arm.linux.org.uk> <20051105181217.GA14419@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105181217.GA14419@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 06:12:17PM +0000, Russell King wrote:
> Introduce struct platform_driver.  This allows the platform device
> driver methods to be passed a platform_device structure instead of
> instead of a plain device structure, and therefore requiring casting
> in every platform driver.
> 
> We introduce this in such a way that any existing platform drivers
> registered directly via driver_register continue to work as before,
> thereby allowing a gradual conversion to the new platform_driver
> methods.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

Thanks a lot for doing this work, I really appreciate it and think it is
the proper way to move forward (the whole, remove the pointers from the
struct driver thing.)

thanks,

greg k-h
