Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSKSCVw>; Mon, 18 Nov 2002 21:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbSKSCVw>; Mon, 18 Nov 2002 21:21:52 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:35855 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261353AbSKSCVw>;
	Mon, 18 Nov 2002 21:21:52 -0500
Date: Mon, 18 Nov 2002 18:22:31 -0800
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] fix compile error in usb-serial.c
Message-ID: <20021119022231.GA14827@kroah.com>
References: <20021118213508.GC13154@kroah.com> <20021118235221.561DD2C3CC@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021118235221.561DD2C3CC@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 10:26:40AM +1100, Rusty Russell wrote:
> In message <20021118213508.GC13154@kroah.com> you write:
> > On Mon, Nov 18, 2002 at 03:39:09PM +0100, Adrian Bunk wrote:
> > > drivers/usb/serial/usb-serial.c in 2.5.48 fails to compile with the
> > > following error:
> > 
> > I don't get this error when building.  What does your .config look like?
> 
> No doubt CONFIG_MODULE=n.  His patch looks correct.

Yeah, you're right :)

I've added this to my trees and will send it on to Linus.

thanks,

greg k-h
