Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTDOQUa (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 12:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbTDOQUa 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 12:20:30 -0400
Received: from granite.he.net ([216.218.226.66]:47110 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261798AbTDOQU2 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 12:20:28 -0400
Date: Tue, 15 Apr 2003 09:34:03 -0700
From: Greg KH <greg@kroah.com>
To: Balram Adlakha <b_adlakha@softhome.net>
Cc: john@grabjohn.com, linux-kernel@vger.kernel.org
Subject: Re: module for sony network walkman
Message-ID: <20030415163403.GB12105@kroah.com>
References: <200304151247.h3FClnq2000157@81-2-122-30.bradfords.org.uk> <200304151918.19936.b_adlakha@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304151918.19936.b_adlakha@softhome.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 07:18:19PM +0000, Balram Adlakha wrote:
> > >Is there any driver available for accessing the flash memory of my sony usb
> > >network walkman (nw-e5)? This thing was quite expensive and I really would
> > >like it to work. 
> 
> >At a guess, it might just act like a disk device. Without a lot more
> >information, I can't help you any further. What does lsusb say about
> >it?
> >
> >John. 
> 
> this is what lsusb says:
> 
> 
> Bus 001 Device 002: ID 054c:0035 Sony Corp.
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass          255 Vendor Specific Class

This is not a usb-storage device (or it is saying it is not, it might be
lying...)  I'd suggest contacting Sony to try to get the specs for this
device.

Good luck,

greg k-h
