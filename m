Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSFKGmj>; Tue, 11 Jun 2002 02:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSFKGmi>; Tue, 11 Jun 2002 02:42:38 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:10761 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316857AbSFKGmi>;
	Tue, 11 Jun 2002 02:42:38 -0400
Date: Mon, 10 Jun 2002 23:38:54 -0700
From: Greg KH <greg@kroah.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Message-ID: <20020611063854.GA6839@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D048CFD.2090201@evision-ventures.com> <20020611004000.GH5202@kroah.com> <3D0599AE.7080809@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 14 May 2002 05:33:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 08:33:18AM +0200, Martin Dalecki wrote:
> Greg KH wrote:
> >On Mon, Jun 10, 2002 at 01:26:53PM +0200, Martin Dalecki wrote:
> >
> >>Fix improper usage of __FUNCTION__ in usb code.
> >
> >
> >It's not improper.  Well it wasn't when it was written, but the gcc
> >authors decided to change their minds... :(
> >
> >As stated before, I'll clean up all of the USB drivers later all at
> >once, and the pci hotplug drivers as well.  The USB drivers could use
> >with some good debugging macro cleanup in general...
> >
> >Martin, any reason you are doing all of this "cleanup" without sending
> >the patches to the relevant maintainers?
> 
> 1. I know you read lkml.

Yeah, but not all the other maintainers do, it's still good form to at
least CC: them on things like this.

And remember, other maintainers aren't as nice as I am :)

greg k-h
