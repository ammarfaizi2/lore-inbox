Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292536AbSCIHfy>; Sat, 9 Mar 2002 02:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291333AbSCIHeR>; Sat, 9 Mar 2002 02:34:17 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:28421 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292571AbSCIHdE>;
	Sat, 9 Mar 2002 02:33:04 -0500
Date: Fri, 8 Mar 2002 23:24:44 -0800
From: Greg KH <greg@kroah.com>
To: Thomas Winischhofer <tw@webit.com>
Cc: linux-kernel@vger.kernel.org,
        Carl-Johan Kjellander <carljohan@kjellander.com>
Subject: Re: pwc-webcam attached to usb-ohci card blocks on read() indefinitely.
Message-ID: <20020309072443.GD30439@kroah.com>
In-Reply-To: <3C89273D.28BC97DB@webit.com> <20020308223513.GD28541@kroah.com> <3C8985B5.4D3606C7@webit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C8985B5.4D3606C7@webit.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 09 Feb 2002 02:08:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2002 at 04:47:01AM +0100, Thomas Winischhofer wrote:
> 
> Sorry if I ask something stupid, I am a total USB rookie - what's that
> /usr/sbin/usbmodules file for?

The hotplug package uses it to try to determine some stuff about the
device.  Why it does this, I'm not really sure, it shouldn't be running
for when a new device is plugged in, but only when the hotplug stuff is
started the first time.

thanks,

greg k-h
