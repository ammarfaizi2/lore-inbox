Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293276AbSDIQVG>; Tue, 9 Apr 2002 12:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293337AbSDIQVF>; Tue, 9 Apr 2002 12:21:05 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:51973 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293276AbSDIQVE>;
	Tue, 9 Apr 2002 12:21:04 -0400
Date: Tue, 9 Apr 2002 09:18:34 -0700
From: Greg KH <greg@kroah.com>
To: Felix Seeger <seeger@sitewaerts.de>
Cc: Felix Seeger <felix.seeger@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: usb problems (no /dev/usb)
Message-ID: <20020409161834.GD13763@kroah.com>
In-Reply-To: <200204082106.33705.felix.seeger@gmx.de> <20020408235945.GD10263@kroah.com> <200204090917.21508.seeger@sitewaerts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 12 Mar 2002 13:43:57 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2002 at 09:17:21AM +0200, Felix Seeger wrote:
> Am Dienstag, 9. April 2002 01:59 schrieb Greg KH:
> > On Mon, Apr 08, 2002 at 09:06:33PM +0200, Felix Seeger wrote:
> > > Hi
> > >
> > > I have tried to install a usb printer but I have no /dev/usb.
> > >
> > > Usb drivers / usb printer installed (in kernel / module)
> > >
> > > Do I have to create the folders /dev/usb and the things that are in there
> > > ?
> >
> > If you are not using devfs, yes.
> >
> > > Why ? ;)
> >
> > Welcome to Unix :)
> >
> > thanks,
> >
> > greg k-h
> Ok, it is in development, thats fine ;)
> It works now, I've found a mknod command in the newsgroups.

Heh, no it's not in development.  Sorry for giving you such a short
answer, but it was a short question, with a lot of needed information
missing :)

Your distro should have set up all of the /dev nodes properly.  If you
are using an old distro version (as I am guessing you are) you will have
to set up the missing /dev entries by hand.

> Is there a document for mknod which explaints the numbers at the ond of the 
> command. The manpage is not really good.

All of the numbers are documented in the Documentation/devices.txt
file.  The Linux USB Guide at http://www.linux-usb.org/ also has info on
how to create the needed USB device entries if you're interested.

Good luck,

greg k-h
