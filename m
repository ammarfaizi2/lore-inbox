Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263029AbSJBKKl>; Wed, 2 Oct 2002 06:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263031AbSJBKKl>; Wed, 2 Oct 2002 06:10:41 -0400
Received: from tungsten.btinternet.com ([194.73.73.81]:49326 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S263029AbSJBKKi>; Wed, 2 Oct 2002 06:10:38 -0400
From: Nick Sanders <sandersn@btinternet.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Kernel Panic 2.5.39 when starting hotplug
Date: Wed, 2 Oct 2002 11:16:01 +0100
User-Agent: KMail/1.4.7
Cc: linux-kernel@vger.kernel.org
References: <200209281324.47486.sandersn@btinternet.com> <200210020222.40880.sandersn@btinternet.com> <20021002015903.GA11453@kroah.com>
In-Reply-To: <20021002015903.GA11453@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200210021116.02036.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 October 2002 2:59 am, Greg KH wrote:
> On Wed, Oct 02, 2002 at 02:22:40AM +0100, Nick Sanders wrote:
> > Sorry about the last report not the most informative, I'm still getting a
> > kernel panic with 2.5.40. I think it's my Alcatel USB Speedtouch Modem as
> > it only panics when I plug it in.
>
> Are you using the new "in-kernel" driver for this device?  Or the
> userspace driver?  Hm, in looking at your .config, you're not using the
> kernel driver, any reason you aren't?
>
> And if you move usbmodules to something else (like usbmodules.orig), it
> will not be run by the hotplug code.  Does that prevent the oops?
>
I used the kernel driver about 9 months ago but it wasn't reliable, the 
userspace driver is brilliantly reliable and also I don't have to patch the 
kernel, just looked at 2.5.40 and see it's in the kernel but I have been 
using 2.4 till recently but there is still the speedmgmt application which 
used to hang the machine on shutdown  and also when the link was dropped and 
you also need a ATM aware PPP daemon so the userpace driver is IMHO simpler 
use.

Moving /usr/sbin/usbmodules to /usr/sbin/usbmodules.orig stops the kernel 
panic, I get the following on boot

Starting hotplug subsystem: usb** can't synthesize root hub events.

Thanks

Nick

