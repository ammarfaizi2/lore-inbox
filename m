Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311919AbSDIW2H>; Tue, 9 Apr 2002 18:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311936AbSDIW2G>; Tue, 9 Apr 2002 18:28:06 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:27399 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S311919AbSDIW2F>;
	Tue, 9 Apr 2002 18:28:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Felix Seeger <felix.seeger@gmx.de>
To: Greg KH <greg@kroah.com>
Subject: Re: usb problems (no /dev/usb)
Date: Wed, 10 Apr 2002 00:25:38 +0200
X-Mailer: KMail [version 1.4]
In-Reply-To: <200204082106.33705.felix.seeger@gmx.de> <200204090917.21508.seeger@sitewaerts.de> <20020409161834.GD13763@kroah.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200204100025.43310.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Dienstag, 9. April 2002 18:18 schrieb Greg KH:
> On Tue, Apr 09, 2002 at 09:17:21AM +0200, Felix Seeger wrote:
> > Am Dienstag, 9. April 2002 01:59 schrieb Greg KH:
> > > On Mon, Apr 08, 2002 at 09:06:33PM +0200, Felix Seeger wrote:
> > > > Hi
> > > >
> > > > I have tried to install a usb printer but I have no /dev/usb.
> > > >
> > > > Usb drivers / usb printer installed (in kernel / module)
> > > >
> > > > Do I have to create the folders /dev/usb and the things that are in
> > > > there ?
> > >
> > > If you are not using devfs, yes.
> > >
> > > > Why ? ;)
> > >
> > > Welcome to Unix :)
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Ok, it is in development, thats fine ;)
> > It works now, I've found a mknod command in the newsgroups.
>
> Heh, no it's not in development.  Sorry for giving you such a short
> answer, but it was a short question, with a lot of needed information
> missing :)
>
> Your distro should have set up all of the /dev nodes properly.  If you
> are using an old distro version (as I am guessing you are) you will have
> to set up the missing /dev entries by hand.
I'm using Debian unstable. I think this is new.
But Debian is not the best in "self doing linux", so thats ok ;)

What is mit devfs, it is experimental. But what is it's status.

Will it delete my files, will it toast my printer or will it only crash my 
system ?
If it ok, I think I could change to it.

> > Is there a document for mknod which explaints the numbers at the ond of
> > the command. The manpage is not really good.
>
> All of the numbers are documented in the Documentation/devices.txt
> file.  The Linux USB Guide at http://www.linux-usb.org/ also has info on
> how to create the needed USB device entries if you're interested.
I will have a look at it.

> Good luck,
>
> greg k-h

thanks

have fun
Felix
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8s2pnS0DOrvdnsewRAldVAJ9bBt9HhFcjdCtmbqQg2Tucd5nmaQCePczC
jZrrwgOadG598ux8CjcMNxY=
=dE+P
-----END PGP SIGNATURE-----

