Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290915AbSAaEBY>; Wed, 30 Jan 2002 23:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290917AbSAaEBO>; Wed, 30 Jan 2002 23:01:14 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:26375 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290915AbSAaEA7>;
	Wed, 30 Jan 2002 23:00:59 -0500
Date: Wed, 30 Jan 2002 19:59:36 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@suse.de>, mmcclell@bigfoot.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ov511 verbose startup.
Message-ID: <20020131035936.GD31006@kroah.com>
In-Reply-To: <20020131023457.D31313@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020131023457.D31313@suse.de>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 03 Jan 2002 01:45:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 02:34:57AM +0100, Dave Jones wrote:
> The changes to ov511 in 2.5.3 seem to generate excessive
> amounts of blurb on boot up for me..
> 
> ov511.c: USB OV511+ camera found
> ov511.c: model: Creative Labs WebCam 3
> ov511.c: Sensor is an OV7620
> ov511.c: Device registered on minor 0
> usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 137 ret -75
> usb_control/bulk_msg: timeout
> usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -110
> usb_control/bulk_msg: timeout
> usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -110
> ...
> repeat last two lines another dozen or so times...

What userspace program are you using that is talking to the usb device
through usbfs?  Or is this usbutils trying to determine what driver to
load?

thanks,

greg k-h
