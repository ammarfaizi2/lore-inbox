Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265944AbSKFS2R>; Wed, 6 Nov 2002 13:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265945AbSKFS2R>; Wed, 6 Nov 2002 13:28:17 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:56849 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265944AbSKFS2Q>;
	Wed, 6 Nov 2002 13:28:16 -0500
Date: Wed, 6 Nov 2002 10:30:46 -0800
From: Greg KH <greg@kroah.com>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linux-USB-Users <linux-usb-users@lists.sourceforge.net>
Subject: Re: USB broken in 2.5.4[56]
Message-ID: <20021106183046.GA23770@kroah.com>
References: <20021106132022.GA2101@home.ldb.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106132022.GA2101@home.ldb.ods.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 02:20:23PM +0100, Luca Barbieri wrote:
> In 2.5.4[56] USB has the following problems:
> - Kernel and lsusb unable to get strings (empty in driverfs and lsusb
>    gets EPIPE from usbdevfs)
> - bAlternateSetting == 0 on interface 1 of my SpeedTouch USB (this
>    prevents loading the firmware to it)
> 
> Reverting all the USB changes in 2.5.45 fixes the problems.

_All_ the changes?  Hm, that was a lot :(

Anyway, which USB drivers are you using?  That might help us narrow this
down a bit.

thanks,

greg k-h
