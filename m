Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265901AbSLXWPg>; Tue, 24 Dec 2002 17:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265909AbSLXWPg>; Tue, 24 Dec 2002 17:15:36 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:5380
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S265901AbSLXWPf>; Tue, 24 Dec 2002 17:15:35 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: Greg KH <greg@kroah.com>
Subject: Re: [PROBLEM][2.5.52/53][USB] USB Device unusable
Date: Tue, 24 Dec 2002 17:25:15 -0500
User-Agent: KMail/1.5.9
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <200212241533.21347.spstarr@sh0n.net> <200212241652.45041.spstarr@sh0n.net> <20021224220913.GA3237@kroah.com>
In-Reply-To: <20021224220913.GA3237@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200212241725.15439.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mount reports:
usbfs on /proc/bus/usb type usbfs (rw)

/etc/fstab:
usbfs          /proc/bus/usb  usbfs   defaults    0       0

well, KDE has a plugin that utilizes libusb, libgphoto2 to manipulate the 
camera. 

I never tried the USB on this machine in 2.5 or 2.4.

Shawn.

On Tuesday 24 December 2002 5:09 pm, Greg KH wrote:
> On Tue, Dec 24, 2002 at 04:52:44PM -0500, Shawn Starr wrote:
> > 2.5.53-mm1 compiled w/ lm_sensors merged in:
> >
> > Same error however new thing:
> >
> > When a non-root user tries to configure the USB device the userland
> > program returns 'Unable to claim USB device'
>
> So you are using usbfs?  What program?  Nothing changed with usbfs from
> 2.5.52 to 2.5.53, but some things did change from 2.5.50 to 2.5.51.  Did
> .50 work for you?
>
> thanks,
>
> greg k-h


