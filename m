Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266769AbSKHHrt>; Fri, 8 Nov 2002 02:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266770AbSKHHrt>; Fri, 8 Nov 2002 02:47:49 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:59141 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266769AbSKHHrs>;
	Fri, 8 Nov 2002 02:47:48 -0500
Date: Thu, 7 Nov 2002 23:50:07 -0800
From: Greg KH <greg@kroah.com>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linux-USB-Users <linux-usb-users@lists.sourceforge.net>
Subject: Re: USB broken in 2.5.4[56]
Message-ID: <20021108075007.GA2282@kroah.com>
References: <20021106132022.GA2101@home.ldb.ods.org> <20021106183046.GA23770@kroah.com> <1036701797.2841.17.camel@ldb> <20021108074334.GE2152@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108074334.GE2152@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 11:43:34PM -0800, Greg KH wrote:
> On Thu, Nov 07, 2002 at 09:43:17PM +0100, Luca Barbieri wrote:
> > > Anyway, which USB drivers are you using?  That might help us narrow this
> > > down a bit.
> > 
> > speedtouch              8932   3
> 
> Oops, I don't think I fixed up that driver based on the other changes
> that happened in the USB core.  I'll try to find some time to look at
> it, but can't guarantee anything...

Hm, no, I take that back, I did fix up the obvious compile time fixes
for that driver.  I wonder what broke it...

What's the symptoms of it not working?

thanks,

greg k-h
