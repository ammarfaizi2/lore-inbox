Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVANA4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVANA4o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVANAys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:54:48 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:44674 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261749AbVANAue
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:50:34 -0500
Date: Thu, 13 Jan 2005 16:50:32 -0800
From: Greg KH <greg@kroah.com>
To: Armen Babikyan <armenb@cs.umass.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hardware sensors problem with 2.4.21 on IBM eServer 335/345
Message-ID: <20050114005032.GB4140@kroah.com>
References: <106F50BA-65B9-11D9-9300-003065F94C4C@cs.umass.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <106F50BA-65B9-11D9-9300-003065F94C4C@cs.umass.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 06:15:50PM -0500, Armen Babikyan wrote:
> Hi,
> 
> I am trying to get hardware sensors (i.e. cpu temp, fan speed, and 
> voltage sensors) working on an IBM eServer 335 system that is running 
> RedHat (Enterprise edition) with kernel 2.4.21 (2.4.21-27 actually).
> 
> The driver for the sensors chip on this particular mainboard is found 
> using sensors-detect:
> 
> Use driver `i2c-piix4' for device 00:0f.0: ServerWorks CSB5 South Bridge
> 
> However, the driver failed to load with the following error:
> 
> i2c-core.o: i2c core module
> i2c-dev.o: i2c /dev entries driver module
> i2c-core.o: driver i2c-dev dummy driver registered.
> i2c-piix4.o version 2.6.5 (20020915)
> i2c-piix4.o: Found CSB5 device

This driver is not in the mainline kernel tree, right?  I suggest asking
about this on the lm-sensors mailing list, or ask Red Hat.

Good luck,

greg k-h
