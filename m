Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbUCLBFz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 20:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUCLBFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 20:05:54 -0500
Received: from mail.kroah.org ([65.200.24.183]:53977 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261876AbUCLBFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 20:05:47 -0500
Date: Thu, 11 Mar 2004 16:31:35 -0800
From: Greg KH <greg@kroah.com>
To: backblue <backblue@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a7n8x-x & i2c
Message-ID: <20040312003135.GA26958@kroah.com>
References: <20040310185047.454779fc.backblue@netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310185047.454779fc.backblue@netcabo.pt>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 06:50:47PM +0000, backblue wrote:
> Hello,
> 
> I have compiled 2.6.3, with i2c suporte for my chipset "nforce2" to
> the board asus a7n8x-x, but, it crashes my box all the time, dont know
> why!  But it only crashes after login and a couple of minutes
> working...  any one know womething about this?

What is the oops reported?

Do you have any of the CONFIG_I2C_DEBUG_* options enabled?  If so,
please do not, as that was causing a few oopses.  All of them are fixed
in the latest -mm release.

thanks,

greg k-h
