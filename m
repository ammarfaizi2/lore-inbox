Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312488AbSCYSbI>; Mon, 25 Mar 2002 13:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312490AbSCYSa6>; Mon, 25 Mar 2002 13:30:58 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:43278 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312488AbSCYSaw>;
	Mon, 25 Mar 2002 13:30:52 -0500
Date: Mon, 25 Mar 2002 10:30:11 -0800
From: Greg KH <greg@kroah.com>
To: Jan-Marek Glogowski <glogow@stud.fbi.fh-darmstadt.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Microsoft Natural KeyB not recogniced as a HID device
Message-ID: <20020325183011.GA29011@kroah.com>
In-Reply-To: <Pine.LNX.4.30.0203251825130.29093-600000@stud.fbi.fh-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 25 Feb 2002 16:24:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 06:57:59PM +0100, Jan-Marek Glogowski wrote:
> Hi
> 
> I have a problem with my Microsoft Natural USB Keyboard.
> 
> Since I moved from kernel 2.4.18-rc2-ac1 to 2.4.19-pre3-ac6 the keybord
> isn't recogniced as a HID device anymore and I just get an error message,
> when I reconnect it. The usb driver finds the integrated hub but not the
> keyboard itself.

Can you try the patches at:
	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101684196109355
and also:
	http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101684207509482

And let us know if they help you out?

If not, try renaming 'usbmodules' on your box to something else (like
'usbmodules.orig' and seeing if that solves your problem?

thanks,

greg k-h
