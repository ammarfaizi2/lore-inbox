Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276444AbRJCQLB>; Wed, 3 Oct 2001 12:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276426AbRJCQKv>; Wed, 3 Oct 2001 12:10:51 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:33550 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S276439AbRJCQKe>;
	Wed, 3 Oct 2001 12:10:34 -0400
Date: Wed, 3 Oct 2001 09:04:55 -0700
From: Greg KH <greg@kroah.com>
To: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb ov511 problem (kernel crash)
Message-ID: <20011003090455.C22631@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0110031227510.4235-100000@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0110031227510.4235-100000@edu.joroinen.fi>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 12:30:06PM +0300, Pasi Kärkkäinen wrote:
> 
> Hello!
> 
> I have an HP Omnibook 6000 laptop. When I plug in the D-LINK DRU-100C
> (Ver. B2) usb-camera, and load the ov511 driver, the camera is detected
> just fine. But, when I try to use the /dev/video0, the whole kernel
> crashes! The same happens when I do "cat /dev/video0". There's nothing in
> the syslog. Sysrq wont work.
> 
> I'm using Linux 2.4.10 and driver that comes with the kernel. I've also
> tried the 1.42 ov511 driver from linux-usb.org. I use Debian GNU/Linux
> (sid).

Fixed in 2.4.11-pre1, or use the uhci.o host controller instead of
usb-uhci.o.

thanks,

greg k-h
