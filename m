Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTDCWeP 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 17:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263573AbTDCWeP 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 17:34:15 -0500
Received: from granite.he.net ([216.218.226.66]:3333 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263572AbTDCWeN 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 17:34:13 -0500
Date: Thu, 3 Apr 2003 14:39:01 -0800
From: Greg KH <greg@kroah.com>
To: Vagn Scott <vagn@ranok.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.66-bk9] : undefined reference to `i2c_detect'
Message-ID: <20030403223901.GB6170@kroah.com>
References: <E191DBZ-0004ac-00@Maya.ny.ranok.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E191DBZ-0004ac-00@Maya.ny.ranok.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 05:27:53PM -0500, Vagn Scott wrote:
> 
> CONFIG_SENSORS_LM75=y
> CONFIG_SENSORS_VIA686A=y
> CONFIG_I2C_SENSOR=m

Ok, I need a bit of Kconfig help for drivers/i2c/chips to set
CONFIG_I2C_SENSOR to be "y" if either of those two drivers are selected
as "y".  Anyone know how?

thanks,

greg k-h
