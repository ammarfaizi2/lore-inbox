Return-Path: <linux-kernel-owner+w=401wt.eu-S1758306AbWLIEbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758306AbWLIEbN (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 23:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758660AbWLIEbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 23:31:13 -0500
Received: from www.tedsautoline.com ([69.222.0.225]:60692 "HELO
	mail.webhostingstar.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758306AbWLIEbN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 23:31:13 -0500
Message-ID: <20061208222148.u6druqastzscwgg0@69.222.0.225>
Date: Fri, 08 Dec 2006 22:21:48 -0600
From: art@usfltd.com
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com, torvalds@osdl.org
Subject: Re: 2.6.19-git libusual: modprobe for usb-storage succeeded, but
	module is not present
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) H3 (4.1.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to: linux-kernel@vger.kernel.org
cc: zaitcev@redhat.com, torvalds@osdl.org
Re: 2.6.19-git libusual: modprobe for usb-storage succeeded, but  
module is not present

> usb 2-2: new high speed USB device using ehci_hcd and address 3
> > usb 2-2: configuration #1 chosen from 1 choice
> > libusual: modprobe for usb-storage succeeded, but module is not present
> > usb 2-4: new high speed USB device using ehci_hcd and address 5
> > usb 2-4: configuration #1 chosen from 1 choice
> > libusual: modprobe for usb-storage succeeded, but module is not present
> > usb 2-5: new high speed USB device using ehci_hcd and address 6
> > usb 2-5: configuration #1 chosen from 1 choice
> > libusual: modprobe for usb-storage succeeded, but module is not present

> I don't know what you've done to accomplish it, but either your
> modules got separated (e.g. libusual built statically while usb-storage
> is dynamic), or your modprobe is toast, or 100 other reasons.
>
> Just deconfigure CONFIG_BLK_DEV_UB and CONFIG_USB_LIBUSUAL
> and forget about it all.
>
> I know, I have to think of a workaround for this, but nothing is
> readily apparent.
>
> -- Pete

was
CONFIG_BLK_DEV_UB=m
CONFIG_USB_LIBUSUAL=y

now
# CONFIG_BLK_DEV_UB is not set
# CONFIG_USB_LIBUSUAL is not set

works ok thanx

xboom





