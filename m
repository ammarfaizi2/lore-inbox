Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261323AbTCZSr6>; Wed, 26 Mar 2003 13:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261789AbTCZSr6>; Wed, 26 Mar 2003 13:47:58 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:57861 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261323AbTCZSr5>;
	Wed, 26 Mar 2003 13:47:57 -0500
Date: Wed, 26 Mar 2003 10:58:17 -0800
From: Greg KH <greg@kroah.com>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB MemoryStick reader and 2.5.66
Message-ID: <20030326185817.GG24689@kroah.com>
References: <20030325124711.GC1242@hottah.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325124711.GC1242@hottah.alcove-fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 01:47:11PM +0100, Stelian Pop wrote:
> Hi,
> 
> Is the usb storage driver supposed to work in the latest kernels, or
> is there somewhere a big pile of scsi / usb-storage patches waiting
> to be integrated and I shouldn't bother with that until then ?

No it should work.  I just used a usb cdrom successfully with 2.5.66.

> This is with an internal USB Memory Stick reader on a Sony Vaio C1VE, 
> which works just fine in 2.4, but in 2.5 it doesn't even gets 
> recognized (hotplug ?). If I modprobe usb-storage manually the 
> module loads just fine:
>   Initializing USB Mass Storage driver...
>   scsi0 : SCSI emulation for USB Mass Storage devices
>     Vendor: Sony      Model: MSC-U01N          Rev: 1.00
>     Type:   Direct-Access                      ANSI SCSI revision: 02
> 
> But then any attempt to mount it or even 'dd if=/dev/sda' hangs 
> forever, the only messages I have in kernel logs are below.
> 
> Is someone interesting in a more complete bug report or should I
> test something else ?

Could you enter this into bugzilla.kernel.org?  Then I can assign it to
the usb-storage maintainer :)

thanks,

greg k-h
