Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSJYUFr>; Fri, 25 Oct 2002 16:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbSJYUFr>; Fri, 25 Oct 2002 16:05:47 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:37124 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261582AbSJYUFq>;
	Fri, 25 Oct 2002 16:05:46 -0400
Date: Fri, 25 Oct 2002 13:10:12 -0700
From: Greg KH <greg@kroah.com>
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB does not work after 2.4.18 to 2.5.44-ac2 upgrade
Message-ID: <20021025201012.GK29874@kroah.com>
References: <20021025024906.GA18214@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025024906.GA18214@ncsu.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 10:49:06PM -0400, jlnance@unity.ncsu.edu wrote:
> Hello All,
>     I decided to do what Linus asked, and try out a 2.5.X kernel.
> The machine boots fine with the 2.5.44-ac2 kernel I installed, however
> I am having some problems with USB.  The usb-uhci module seems to be
> gone.  I read Documentation/usb/uhci.txt and it appears that the
> uhci module has been rewritten.  I assume the module named uhci-hcd.o
> is the replacement, but I could not find that written down anywhere.
> I did an insmod of this module and I can now see the hub in
> /proc/bus/usb/devices.  I dont see any of my other USB devices in that
> file, even after I insmod the drivers.

Are your devices plugged in? :)

What does the kernel log say when you plug them in?

thanks,

greg k-h
