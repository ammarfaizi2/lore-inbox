Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVKWTNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVKWTNp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVKWTNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:13:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:57290 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932232AbVKWTNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:13:43 -0500
Date: Wed, 23 Nov 2005 11:12:28 -0800
From: Greg KH <gregkh@suse.de>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] - Fixes NULL pointer deference in usb-serial driver.
Message-ID: <20051123191228.GB28255@suse.de>
References: <20051116151634.20661b0f.lcapitulino@mandriva.com.br> <20051116172416.GA6310@suse.de> <20051116175409.GA30894@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116175409.GA30894@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 05:54:09PM +0000, Russell King wrote:
> Hint: there's a VERY good reason the serial_core layer exists and
> it's to get these kind of semantics (and bugs) centralised in one
> place rather than spread across thousands of drivers.

Yes, I know I need to convert the usb-serial core/drivers to use the
serial core...

thanks,

greg k-h
