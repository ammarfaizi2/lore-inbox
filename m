Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVCBRDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVCBRDT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVCBRB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:01:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:12703 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262359AbVCBRAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:00:10 -0500
Date: Wed, 2 Mar 2005 08:59:44 -0800
From: Greg KH <greg@kroah.com>
To: James Chapman <jchapman@katalix.com>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH: 2.6.11-rc5] i2c chips: ds1337 RTC driver
Message-ID: <20050302165943.GA2393@kroah.com>
References: <42235171.80500@katalix.com> <20050301075413.GC3791@kroah.com> <4224C0D4.2060303@katalix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4224C0D4.2060303@katalix.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 07:21:56PM +0000, James Chapman wrote:
> Revised ds1337 chip driver patch.
> 
> Signed-off-by: James Chapman <jchapman@katalix.com>
> 
> - change all driver log messages to use dev_dbg() or dev_err()
> - remove debug module parameter

Hm, doesn't seem to apply at all:

drivers/i2c/chips/Kconfig 1.78: 418 lines
patching file drivers/i2c/chips/Kconfig
drivers/i2c/chips/Makefile 1.61: 46 lines
patching file drivers/i2c/chips/Makefile
patching file drivers/i2c/chips/ds1337.c
patch: **** malformed patch at line 420: 


Care to respin it again?

thanks,

greg k-h
