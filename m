Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSK0GLH>; Wed, 27 Nov 2002 01:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbSK0GLH>; Wed, 27 Nov 2002 01:11:07 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:40210 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261934AbSK0GLH>;
	Wed, 27 Nov 2002 01:11:07 -0500
Date: Tue, 26 Nov 2002 22:10:25 -0800
From: Greg KH <greg@kroah.com>
To: Roger Gammans <roger@computer-surgery.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A Kernel Configuration Tale of Woe
Message-ID: <20021127061025.GB2889@kroah.com>
References: <3de3cc8d.54dd.0@wincom.net> <1038341131.2534.73.camel@irongate.swansea.linux.org.uk> <20021126232121.A12861@computer-surgery.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021126232121.A12861@computer-surgery.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 11:21:22PM +0000, Roger Gammans wrote:
> On Tue, Nov 26, 2002 at 08:05:31PM +0000, Alan Cox wrote:
> > On Tue, 2002-11-26 at 19:28, Dennis Grant wrote:
> > > Agreed - so then the association between "board" and "chipset" must be capable
> > > of being multi-valued, and when there is a mult-valued match there must be some
> > > means of further interrogating the user (or user agent) for more information.
> > 
> > Much simpler to just include "modular everything" and let user space
> > sort it out. Guess why every vendor takes this path
> 
> Is there a tool though to map bus (PCI,USB etc) id's back 
> onto modules which are likely[1] contain driver for them.

That's exactly what the hotplug package does.

See http://linux-hotplug.sf.net/ for more info.  Odds are it's already
installed on your box :)

greg k-h
