Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSFYQva>; Tue, 25 Jun 2002 12:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSFYQv3>; Tue, 25 Jun 2002 12:51:29 -0400
Received: from air-2.osdl.org ([65.172.181.6]:5532 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315627AbSFYQv2>;
	Tue, 25 Jun 2002 12:51:28 -0400
Date: Tue, 25 Jun 2002 09:46:23 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Nick Bellinger <nickb@attheoffice.org>
cc: David Brownell <david-b@pacbell.net>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <1024769900.6875.139.camel@subjeKt>
Message-ID: <Pine.LNX.4.33.0206250940370.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This reiterates the need for a sound logical device naming scheme that
> fits into driverfs without mucking up the basic structure.  Not being a
> expert on naming, the least offensive format I can think with regard to
> iSCSI would be something along the lines of:

The device model will not give devices default names. It will pass the 
responsibility to userspace, along with the path to the device via 
/sbin/hotplug. From the patch, the userspace agent can derive various 
things from the device's directory, including the device type and the UUID 
of the device. From this, userspace can look up what to name the device. 

	-pat

