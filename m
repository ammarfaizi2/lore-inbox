Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031726AbWLASlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031726AbWLASlt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 13:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031727AbWLASlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 13:41:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:46258 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1031726AbWLASls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 13:41:48 -0500
Date: Fri, 1 Dec 2006 10:41:23 -0800
From: Greg KH <gregkh@suse.de>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: Stefan Reinauer <stepan@coresystems.de>,
       Peter Stuge <stuge-linuxbios@cdy.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
Message-ID: <20061201184123.GA2996@suse.de>
References: <5986589C150B2F49A46483AC44C7BCA4907273@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA4907273@ssvlexmb2.amd.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 10:26:19AM -0800, Lu, Yinghai wrote:
> -----Original Message-----
> From: Lu, Yinghai 
> 
> >To my understanding, you don't need to waiting for Eric's code.
> >You can use the cable on two systems without debug port support.
> >So just extend the program to make it can write the data too.
> 
> Greg,
> 
> Anyone is working on creating one usb_serial_driver for USB debug device
> without using host debug port?

I can do that in about 15 minutes if you give me the device ids for the
usb debug device that you wish to have.

Or you can also use the generic usb-serial driver today just fine with
no modification.  Have you had a problem with using that option?

thanks,

greg k-h
