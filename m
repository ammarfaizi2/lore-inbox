Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRALHaU>; Fri, 12 Jan 2001 02:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRALHaK>; Fri, 12 Jan 2001 02:30:10 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:58126 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S129183AbRALH37>;
	Fri, 12 Jan 2001 02:29:59 -0500
Date: Thu, 11 Jan 2001 23:26:32 -0800
From: Greg KH <greg@kroah.com>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: linux-usb-devel@lists.sourceforge.net, f5ibh <f5ibh@db0bm.ampr.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] USB Config fix for 2.2.19-pre7
Message-ID: <20010111232632.A19723@kroah.com>
In-Reply-To: <20010110002639.B26680@wirex.com> <20010110164451.A16985@kroah.com> <5.0.2.1.2.20010111175414.03377210@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.0.2.1.2.20010111175414.03377210@mail.lauterbach.com>; from Franz.Sirl-kernel@lauterbach.com on Thu, Jan 11, 2001 at 06:01:19PM +0100
X-Operating-System: Linux 2.2.16-immunix (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 06:01:19PM +0100, Franz Sirl wrote:
> Why do the input handlers depend on CONFIG_USB_HID? On PPC we already have 
> trouble with them depending on CONFIG_USB, so everybody has to select 
> CONFIG_USB even if he just has ADB hardware.

Don't these input drivers _require_ the USB HID driver core to work
properly?  

Or am I mistaken, and this is the 2.4.0 input core code, but
not in a separate directory, like 2.4.0 has it?

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
