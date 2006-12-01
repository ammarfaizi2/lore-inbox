Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031666AbWLATE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031666AbWLATE0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031684AbWLATE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:04:26 -0500
Received: from foo.birdnet.se ([213.88.146.6]:24725 "EHLO foo.birdnet.se")
	by vger.kernel.org with ESMTP id S1031666AbWLATEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:04:25 -0500
Message-ID: <20061201190426.14911.qmail@stuge.se>
Date: Fri, 1 Dec 2006 20:04:26 +0100
From: Peter Stuge <peter@stuge.se>
To: Greg KH <gregkh@suse.de>
Cc: "Lu, Yinghai" <yinghai.lu@amd.com>,
       Stefan Reinauer <stepan@coresystems.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
Mail-Followup-To: Greg KH <gregkh@suse.de>,
	"Lu, Yinghai" <yinghai.lu@amd.com>,
	Stefan Reinauer <stepan@coresystems.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linuxbios@linuxbios.org, linux-kernel@vger.kernel.org
References: <5986589C150B2F49A46483AC44C7BCA4907273@ssvlexmb2.amd.com> <20061201184123.GA2996@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201184123.GA2996@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 10:41:23AM -0800, Greg KH wrote:
> On Fri, Dec 01, 2006 at 10:26:19AM -0800, Lu, Yinghai wrote:
> > Anyone is working on creating one usb_serial_driver for USB debug
> > device without using host debug port?
> 
> I can do that in about 15 minutes if you give me the device ids for
> the usb debug device that you wish to have.

The host (aka remote) end of the NET20DC debug device has vid 0x0525
and pid 0x127a.


> Or you can also use the generic usb-serial driver today just fine
> with no modification.  Have you had a problem with using that
> option?

Does it check for a debug descriptor and attach to the device if one
is found? Neat!


//Peter
