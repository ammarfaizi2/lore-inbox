Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287633AbSA3BKy>; Tue, 29 Jan 2002 20:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287645AbSA3BKo>; Tue, 29 Jan 2002 20:10:44 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:36356 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287633AbSA3BKc>;
	Tue, 29 Jan 2002 20:10:32 -0500
Date: Tue, 29 Jan 2002 17:09:22 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@suse.de>, mochel@osdl.org,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driverfs support for USB - take 2
Message-ID: <20020130010921.GB22131@kroah.com>
In-Reply-To: <20020130002418.GB21784@kroah.com> <20020130020312.C16379@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020130020312.C16379@suse.de>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 01 Jan 2002 22:36:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 02:03:12AM +0100, Dave Jones wrote:
> 
>  > Yes, I need to have better names for the devices than just "usb_bus",
>  > any suggestions?  These devices nodes are really the USB root hubs in
>  > the USB controller, so they could just have the USB number as the name
>  > like the other USB devices (001), but that's pretty boring :)
> 
>  "usb_root0" .. "usb_rootN" ?

Hm, that's a good idea, it would match the usbfs bus numbers which
should keep people happy.

>  btw, a script to marry the busid's from driverfs to lspci/lsusb
>  output may be useful in the future especially if combined somehow
>  with tree(1). Could be very handy when it gets time to debug
>  those "My system won't suspend to disk" "What does /driver look like?"
>  situations.

Ah, a lsdrivers program is needed! :)

thanks,

greg k-h
