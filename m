Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVAHJeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVAHJeO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVAHJeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:34:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:5256 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261954AbVAHFxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:53:38 -0500
Date: Fri, 7 Jan 2005 21:53:16 -0800
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Export symbol from I2C eeprom driver
Message-ID: <20050108055315.GC8571@kroah.com>
References: <9e47339105010721347fbeb907@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105010721347fbeb907@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 12:34:44AM -0500, Jon Smirl wrote:
> Trivial patch to export a symbol from the eeprom driver. Currently
> there are no exported symbols. The symbol lets the radeon DRM driver
> link to it and modprobe will then force it to load along with the
> radeon driver.

Why do you need this symbol?  Or are you just saying that you need the
eeprom driver loaded for some reason?

I say this as this variable is probably going to go away in the very
near future, as it isn't really needed at all.

thanks,

greg k-h
