Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263837AbTFDSvl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbTFDSvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:51:40 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:21978 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263837AbTFDSvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:51:36 -0400
Date: Wed, 4 Jun 2003 12:06:29 -0700
From: Greg KH <greg@kroah.com>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I2C/Sensors 2.5.70
Message-ID: <20030604190629.GA6632@kroah.com>
References: <5.1.0.14.2.20030604163948.00af3d28@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030604163948.00af3d28@pop.t-online.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 04:51:30PM +0200, Margit Schubert-While wrote:
> Is anybody looking at getting $Subject working ?

Works for me :)

> At the moment i2c-sensor.c never gets compiled which is bad as
> it contains i2c_detect needed by all the sensors.

What is your .config?  Are you sure you have selected a i2c chip driver?

> And (assuming sensors works) where does the sensor info(fan, temp etc.)
> get put?

In sysfs.  Look at Documentation/i2c/sysfs-interface for more
information on the different files and values.

thanks,

greg k-h
