Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291091AbSAaOjS>; Thu, 31 Jan 2002 09:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291092AbSAaOjI>; Thu, 31 Jan 2002 09:39:08 -0500
Received: from ns.suse.de ([213.95.15.193]:51213 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291091AbSAaOix>;
	Thu, 31 Jan 2002 09:38:53 -0500
Date: Thu, 31 Jan 2002 15:38:52 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Greg KH <greg@kroah.com>
Cc: <mmcclell@bigfoot.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ov511 verbose startup.
In-Reply-To: <20020131035936.GD31006@kroah.com>
Message-ID: <Pine.LNX.4.33.0201311538040.7473-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Greg KH wrote:

> > usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -110
> > usb_control/bulk_msg: timeout
> > usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -110
> > ...
> > repeat last two lines another dozen or so times...
> What userspace program are you using that is talking to the usb device
> through usbfs?  Or is this usbutils trying to determine what driver to
> load?

More than likely usbutils. There shouldn't be anything else running
on startup that touches usb.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

