Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWAEXJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWAEXJb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWAEXJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:09:30 -0500
Received: from mail.kroah.org ([69.55.234.183]:37332 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932256AbWAEXJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:09:28 -0500
Date: Thu, 5 Jan 2006 15:07:39 -0800
From: Greg KH <greg@kroah.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [CFT 1/29] Add bus_type probe, remove, shutdown methods.
Message-ID: <20060105230739.GA27466@kroah.com>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105142951.13.01@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 02:29:51PM +0000, Russell King wrote:
> Add bus_type probe, remove and shutdown methods to replace the
> corresponding methods in struct device_driver.  This matches
> the way we handle the suspend/resume methods.
> 
> Since the bus methods override the device_driver methods, warn
> if a device driver is registered whose methods will not be
> called.
> 
> The long-term idea is to remove the device_driver methods entirely.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

All of this looks good to me, want me to add them to my tree and forward
it on to Linus?

thanks for doing this work, I really appreciate it.

greg k-h
