Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSFDQ4R>; Tue, 4 Jun 2002 12:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSFDQ4Q>; Tue, 4 Jun 2002 12:56:16 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:61448 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315179AbSFDQ4P>;
	Tue, 4 Jun 2002 12:56:15 -0400
Date: Tue, 4 Jun 2002 09:53:45 -0700
From: Greg KH <greg@kroah.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: device model documentation 1/3
Message-ID: <20020604165345.GB28805@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0206040904430.654-100000@geena.pdx.osdl.net> <3CFCE09B.6090007@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 07 May 2002 14:47:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 05:45:31PM +0200, Martin Dalecki wrote:
> Patrick Mochel wrote:
> 
> >Bus Types 
> >
> >struct bus_type {
> 
> ...
> 
> 
> >	int	(*bind)		(struct device * dev, struct device_driver * 
> >	drv);
> >};
> >
> 
> Please - Why do you call it bind? Does it have something with
> netowrking to do? Please just name it attach. This way the old UNIX
> guys among us won't have to drag a too big
> "UNIX to Linux translation dictionary" around with them.
> As an "added bonus" you will stay consistent with -
> 
> USB code base in kernel

Huh?  The usb code base doesn't use either "bind" or "attach" in it's
api.

And who cares?  You knew what he ment by this, and it's a pretty
standard term.

greg k-h
