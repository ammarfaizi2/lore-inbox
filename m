Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290573AbSBKWCM>; Mon, 11 Feb 2002 17:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290570AbSBKWCD>; Mon, 11 Feb 2002 17:02:03 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:10757 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290547AbSBKWBz>;
	Mon, 11 Feb 2002 17:01:55 -0500
Date: Mon, 11 Feb 2002 13:58:20 -0800
From: Greg KH <greg@kroah.com>
To: Nathan <wfilardo@fuse.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: USB OOPS persists in 2.5.3-dj4
Message-ID: <20020211215820.GH12514@kroah.com>
In-Reply-To: <3C644F9B.4050702@fuse.net> <20020209001405.GG27610@kroah.com> <3C64B635.5080804@fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C64B635.5080804@fuse.net>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 14 Jan 2002 18:00:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 12:40:05AM -0500, Nathan wrote:
> Greg KH wrote:
> 
> >
> >Can you let me know if 2.5.4-pre3 has this problem?
> >
> No, it does not have *this* problem, however...
> 
> rmmod usb-uhci
> rmmod usbcore - "in use"
> umount /proc/bus/usb
> rmmod usbcore
> modprobe usbcore
> mount -t usbdevfs none /proc/bus/usb
> modprobe uhci - OOPS.  Didn't manage to capture it.  System kept running.

That's the important one.  Everything else was just errors because of
this one.  Let me know if you can capture this.

thanks,

greg k-h
