Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbTDEBK0 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 20:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbTDEBK0 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:10:26 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:31666 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261620AbTDEBKZ (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 20:10:25 -0500
Date: Fri, 4 Apr 2003 17:24:14 -0800
From: Greg KH <greg@kroah.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, frodol@dds.nl, phil@netroedge.com
Subject: Re: 2.5.66: The I2C code ate my grandma...
Message-ID: <20030405012414.GA5532@kroah.com>
References: <20030404021152.GE466@zip.com.au> <20030404171424.GA1380@kroah.com> <20030405005950.GA464@zip.com.au> <20030405011414.GA5697@kroah.com> <20030405011607.GB464@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405011607.GB464@zip.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 11:16:07AM +1000, CaT wrote:
> On Fri, Apr 04, 2003 at 05:14:14PM -0800, Greg KH wrote:
> > To a:
> > 	tree /sys/bus/i2c/devices/
> > to see all of the i2c devices in your system.
> > Then go in to the directories of those devices to see the sensor values
> > for the devices.
> 
> AHA! I was sure I ran find /sys -name '*i2c*'. hrrumph.
> 
> > libsensor support will be forthcoming soon for these changes.
> 
> Cool. I'll just modify my little script for now. :)

Great.  Can you validate that the output of the sysfs files is in the
proper units (should be milliVolts and milliCelcius)?  I am pretty sure
I got this one wrong, as I don't have the hardware to test it on.

thanks,

greg k-h
