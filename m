Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275172AbSIUAKT>; Fri, 20 Sep 2002 20:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275175AbSIUAKT>; Fri, 20 Sep 2002 20:10:19 -0400
Received: from air-2.osdl.org ([65.172.181.6]:64273 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S275172AbSIUAKS>;
	Fri, 20 Sep 2002 20:10:18 -0400
Date: Fri, 20 Sep 2002 17:11:24 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Johannes Erdfelt <johannes@erdfelt.com>
cc: Brad Hards <bhards@bigpond.net.au>, David Brownell <david-b@pacbell.net>,
       Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
In-Reply-To: <20020920193642.I1627@sventech.com>
Message-ID: <Pine.LNX.4.33L2.0209201709570.5885-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002, Johannes Erdfelt wrote:

| On Sat, Sep 21, 2002, Brad Hards <bhards@bigpond.net.au> wrote:
| > -----BEGIN PGP SIGNED MESSAGE-----
| > Hash: SHA1
| >
| > On Sat, 21 Sep 2002 06:42, David Brownell wrote:
| > > >>I wasn't joking about putting back the /proc/bus/usb/drivers file. This
| > > >> is really going to hurt us in 2.6.
| > >
| > > Considering that the main use of that file that I know about was
| > > implicit (usbfs is available if its files are present, another
| > > assumption broken in 2.5), I'm not sure I feel any pain... :-)
| >
| > OK. Everytime someone goes "I've got usbfs loaded, and here is
| > /proc/bus/usb/devices, but can't send you /proc/bus/usb/drivers", I'll assume
| > that you two will answer the question.
| >
| > Helping people is hard. Please don't make it harder. :-(
|
| Personally, I've never used /proc/bus/usb/drivers. I've always just
| looked at lsmod.
|
| Why should this be any different?

The only case I know of that's it been useful is to see why
some USB driver failed registration -- because it's minor number(s)
were already assigned/registered.  That won't happen with
just kernel.org stock drivers etc., of course.

-- 
~Randy

