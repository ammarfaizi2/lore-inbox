Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTFTOIV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 10:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbTFTOIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 10:08:21 -0400
Received: from ida.rowland.org ([192.131.102.52]:4356 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262253AbTFTOIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 10:08:20 -0400
Date: Fri, 20 Jun 2003 10:22:21 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: Patrick Mochel <mochel@osdl.org>, Mike Anderson <andmike@us.ibm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <20030619213109.GB5644@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0306201020240.917-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jun 2003, Greg KH wrote:

> I think it's more of the matter that Mike is still changing the way the
> SCSI core works with the class and driver model.  I suggest you take
> this to the linux-scsi list to hash out the way scsi should and does
> work in order to find the best solution for usb-storage, as I guess that
> it also would be the best solution for all other SCSI host drivers.

Okay.

> > In the meantime, where should I register my class device for the 
> > usb-storage driver?
> 
> Why not hold off until the scsi people are finished with their changes?
> If after that, you _really_ need to be putting usb-storage only
> attributes in the sysfs tree somewhere, we can talk again.

Sounds reasonable.  By the way, do you plan to create a 
/sys/class/usb_host/ class for the OHCI and ECHI drivers?

Alan Stern

