Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbTDDRPe (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 12:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263874AbTDDROf (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 12:14:35 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:254 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263870AbTDDRIs (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 12:08:48 -0500
Date: Fri, 4 Apr 2003 09:14:24 -0800
From: Greg KH <greg@kroah.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, frodol@dds.nl, phil@netroedge.com
Subject: Re: 2.5.66: The I2C code ate my grandma...
Message-ID: <20030404171424.GA1380@kroah.com>
References: <20030404021152.GE466@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404021152.GE466@zip.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 12:11:52PM +1000, CaT wrote:
> 
> I2C components that were compiled in:
> 
> -CONFIG_I2C=y
> -CONFIG_I2C_CHARDEV=y
> -CONFIG_I2C_PIIX4=y
> -CONFIG_I2C_PROC=y
> -CONFIG_SENSORS_ADM1021=y
> 
> Please help. I like knowing what temp my cpu is at. :)

So if you disable the I2C config items, everything works just fine?

I did send out a bugfix for the i2c code for a problem in 2.5.66, it's
now included in the latest -bk tree.  Could you grab that patch and see
if it fixes your problem?

thanks,

greg k-h
