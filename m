Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261634AbSI0FsO>; Fri, 27 Sep 2002 01:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261635AbSI0FsO>; Fri, 27 Sep 2002 01:48:14 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:33548 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261634AbSI0FsN>;
	Fri, 27 Sep 2002 01:48:13 -0400
Date: Thu, 26 Sep 2002 22:51:59 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Marz <smarz@host187.south.iit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Mass Storage Hangs
Message-ID: <20020927055158.GB8971@kroah.com>
References: <Pine.LNX.4.44.0209270035080.3034-100000@host187.south.iit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209270035080.3034-100000@host187.south.iit.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 12:38:16AM -0500, Stephen Marz wrote:
> This message regards the USB mass storage driver for kernel version
> 2.4.18-10:
> 
> On my Dell Inspiron 7500 I have an adaptec USB 2.0 cardbus
> adapter.  I plugged in a 120GB hard drive and the mass
> storage driver in linux detects it and runs it fine.  The
> problem comes in when I try to also plug in my CD-RW into
> the cardbus adapter (it has two USB 2.0 ports).  The mass
> storage driver will detect and gather information about
> the drive, however it doesn't take more than two or
> three minutes before the entire system hangs.  The kernel
> immediately drops all knowledge of any USB device on
> my system.
> 
> Anybody else notice this problem?

Is there a kernel oops anywhere?
And are both of these devices USB 2.0 devices?  If so, you might want to
try the 2.4.20-pre kernels, it has much better USB 2.0 support than the
kernel you are using.

thanks,

greg k-h
