Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264669AbUEEXOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264669AbUEEXOi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 19:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbUEEXOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 19:14:38 -0400
Received: from mail.kroah.org ([65.200.24.183]:40390 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264669AbUEEXOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 19:14:36 -0400
Date: Wed, 5 May 2004 16:13:53 -0700
From: Greg KH <greg@kroah.com>
To: Michael Hunold <hunold@convergence.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Jean Delvare <khali@linux-fr.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, sensors@stimpy.netroedge.com
Subject: Re: [PATCH][2.6]
Message-ID: <20040505231353.GA30862@kroah.com>
References: <409923F7.7050101@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409923F7.7050101@convergence.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 07:27:19PM +0200, Michael Hunold wrote:
> The attached patch does the first step:
> - add .class member to struct i2c_device
> - remove unused .flags member from struct i2c_adapter
> - rename I2C_ADAP_CLASS_xxx to I2C_CLASS_xxx (to be used both for 
> drivers and adapters)
> - add new I2C_CLASS_ALL and I2C_CLASS_SOUND classes
> - follow these changes in the existing drivers with copy & paste
> 
> I think these things are unquestionable and don't make any functional 
> changes to the code, so this should be applied to 2.6 now.
> 
> From that point on, we can discuss how to proceed.
> 
> Comments?

Looks good, I've applied this to my trees, and it will show up in the
next -mm release.

thanks,

greg k-h
