Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285307AbRLFX3g>; Thu, 6 Dec 2001 18:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285315AbRLFX3O>; Thu, 6 Dec 2001 18:29:14 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:62470 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S285307AbRLFX2W>;
	Thu, 6 Dec 2001 18:28:22 -0500
Date: Thu, 6 Dec 2001 15:27:22 -0800
From: Greg KH <greg@kroah.com>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: Jonathan Hudson <jonathan@daria.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Q: device(file) permissions for USB
Message-ID: <20011206152721.M2710@kroah.com>
In-Reply-To: <fa.ljcupnv.1ghotjk@ifi.uio.no> <664.3c0fd1b7.a66fa@trespassersw.daria.co.uk> <20011206223050.179cd30e.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011206223050.179cd30e.rene.rebe@gmx.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 08 Nov 2001 18:50:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 10:30:50PM +0100, Rene Rebe wrote:
> 
> This is what I do - but IT SUCKS!! Can't the USB stuff simply use devfs so
> I can control the permissions of this USB nodes in a very nice / cleaner
> way I do with all my other stuff??? (In contrast to use some find -name
> | xargs chmod ... or simillar hacks ...)

How is using devfs (and devfsd) any different in "hack level" from using
/sbin/hotplug?

usbdevfs does not require devfs, which enables the majority of Linux
users to actually use it.

thanks,

greg k-h
