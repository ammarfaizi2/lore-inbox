Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261358AbSJHSRz>; Tue, 8 Oct 2002 14:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbSJHSRz>; Tue, 8 Oct 2002 14:17:55 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:1801 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261358AbSJHSRx>;
	Tue, 8 Oct 2002 14:17:53 -0400
Date: Tue, 8 Oct 2002 11:19:51 -0700
From: Greg KH <greg@kroah.com>
To: Peter Osterlund <petero2@telia.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.5.40 panic in uhci-hcd
Message-ID: <20021008181951.GD5239@kroah.com>
References: <20021008071351.GQ1780@kroah.com> <Pine.LNX.4.44.0210081959400.6558-100000@p4.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210081959400.6558-100000@p4.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 08:01:34PM +0200, Peter Osterlund wrote:
> On Tue, 8 Oct 2002, Greg KH wrote:
> 
> > On Sun, Oct 06, 2002 at 02:03:49PM +0200, Peter Osterlund wrote:
> > > Sometimes when booting 2.5.40 and my Freecom USB-IDE controller (CDRW)
> > > is connected, the kernel panics when trying to initialize the usb
> > > subsystem. It happens right after the RH73 boot scripts print out:
> > > 
> > >         Initializing USB controller (uhci-hcd):  [  OK  ]
> > > 
> > > In 2.5.39, this happened every time I tried to boot, but in 2.5.40 it
> > > seems to happen about 20% of the time.
> > 
> > Hey, we're getting better :)
> > 
> > How does 2.5.41 work for you?
> 
> It seems to be fixed. Thanks.

Heh, that's pretty funny.  There were not any uhci specific fixes in
2.5.41...

Not complaining,

greg k-h
