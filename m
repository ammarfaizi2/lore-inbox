Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVBAHkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVBAHkr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 02:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVBAHkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 02:40:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:35996 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261686AbVBAHkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 02:40:45 -0500
Date: Mon, 31 Jan 2005 23:19:03 -0800
From: Greg KH <greg@kroah.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: I2C algorithm IDs
Message-ID: <20050201071903.GG20783@kroah.com>
References: <20050122174718.A27993@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122174718.A27993@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 05:47:18PM +0000, Russell King wrote:
> Greg,
> 
> Are I2C algorithm IDs supposed to be unique?  Do they have any meaning in
> reality at all?  If the answer is yes to either of these questions, the
> following should probably be resolved:

Yes, they are used in some places, and yes they do need to be unique.

> #define I2C_ALGO_PCA    0x150000        /* PCA 9564 style adapters      */
> #define I2C_ALGO_SIBYTE 0x150000        /* Broadcom SiByte SOCs         */

Thanks for pointing this out, I've gone and fixed this up and will send
the patch upward.

thanks,

greg k-h
