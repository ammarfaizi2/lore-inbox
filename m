Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132758AbRBEEzF>; Sun, 4 Feb 2001 23:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132828AbRBEEyx>; Sun, 4 Feb 2001 23:54:53 -0500
Received: from selene.cps.intel.com ([192.198.165.10]:268 "EHLO
	selene.cps.intel.com") by vger.kernel.org with ESMTP
	id <S132811AbRBEEyn>; Sun, 4 Feb 2001 23:54:43 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDFF4@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Michael Rothwell'" <rothwell@holly-springs.nc.us>,
        Eric Sandeen <sandeen@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: "kaweth" usb ethernet driver in 2.4?
Date: Sun, 4 Feb 2001 20:54:18 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was posted on linux-usb-devel on 28-jan-2001.
Find some email archive for it, or I can forward it
to you...

~Randy

> -----Original Message-----
> From: Michael Rothwell [mailto:rothwell@holly-springs.nc.us]
> Sent: Sunday, February 04, 2001 6:17 PM
> To: Eric Sandeen
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: "kaweth" usb ethernet driver in 2.4?
> 
> 
> Thanks. Has Brad Hards made his version available somewhere?
> -M
> 
> ----- Original Message -----
> From: "Eric Sandeen" <sandeen@sgi.com>
> To: "Michael Rothwell" <rothwell@holly-springs.nc.us>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Sunday, February 04, 2001 9:30 AM
> Subject: Re: "kaweth" usb ethernet driver in 2.4?
> 
> 
> > Michael Rothwell wrote:
> >
> > > > It also doesn't seem to work in 2.2.  :)  The original 
> development of
> > > > this driver was going on at 
> http://drivers.rd.ilan.net/kaweth/ but
> there
> > > > have been no updates for quite some time.
> > >
> > > Well, it doesn't work you _you_ on 2.2, obviously. But it 
> works for us
> > > and other people. Can you provide any information to diagnose the
> > > problem you're having?
> >
> > I'm sorry, I should have provided that info.  I searched 
> the 'net, and
> > saw many people with problems on several mailing lists, and saw no
> > solutions, or reports of success, so I assumed that it was 
> a widespread,
> > possibly even known, problem with the driver.
> >
> > I'll preface this by saying that Brad Hards sent me an 
> updated version
> > that works much better, at least as long as the module is 
> loaded before
> > the device is plugged in.
> >
> > But here's what I get with a 2.2 kernel and the stock driver:
> >
> > Kawasaki USB->Ethernet Driver loading...
> > usb.c: registered new driver kaweth
> > usb.c: USB new device connect, assigned device number 2
> > Kawasaki Device Probe (Device number:2): 0x0846:0x1001
> > Device at c2192600
> > Descriptor length: 12 type: 1
> > NetGear EA-101 connected...
> > Reading kaweth configuration
> > Request type: c0  Request: 0  Value: 0 Index: 0 Length: 12
> > usb-uhci.c: interrupt, status 2, frame# 1929
> > kaweth control message failed (urb addr: c2c05ca0)
> > usb_control/bulk_msg: timeout
> > usb-uhci.c: interrupt, status 2, frame# 851
> > Actual length: 0, length 18
> > Resetting...
> > usb-uhci.c: interrupt, status 2, frame# 854
> > Downloading firmware at c48abb6c to kaweth device at c31be000...
> > Firmware length: 3838
> > Request type: 40  Request: ff  Value: 0 Index: 0 Length: efe
> > usb-uhci.c: interrupt, status 2, frame# 871
> > kaweth control message failed (urb addr: c213ab60)
> > usb-uhci.c: interrupt, status 2, frame# 877
> > usb-uhci.c: interrupt, status 2, frame# 882
> > Actual length: 0, length 3838
> > Error downloading firmware (-110), no net device created
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
