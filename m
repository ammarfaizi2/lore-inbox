Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267505AbSLEV2z>; Thu, 5 Dec 2002 16:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267503AbSLEV2G>; Thu, 5 Dec 2002 16:28:06 -0500
Received: from air-2.osdl.org ([65.172.181.6]:23980 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267445AbSLEV0x>;
	Thu, 5 Dec 2002 16:26:53 -0500
Date: Thu, 5 Dec 2002 13:33:52 -0800
From: Dave Olien <dmo@osdl.org>
To: Mihai RUSU <dizzy@roedu.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Monitor utility (was Re: DAC960 at 2.5.50)
Message-ID: <20021205133352.A1661@acpi.pdx.osdl.net>
References: <20021205094500.A6769@acpi.pdx.osdl.net> <Pine.LNX.4.33.0212052105300.22842-100000@ahriman.bucharest.roedu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0212052105300.22842-100000@ahriman.bucharest.roedu.net>; from dizzy@roedu.net on Thu, Dec 05, 2002 at 09:21:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks, I'll give it a try!

I was just playing with varmon.
It's OK.  It seems to do the same set of things
that I can do through the /proc/rd/c0/user_command
interface.  I can take drives offline, put them
back online, make drives standby, do consistency
checks.

But, I can't delete or create logical devices,
I'm forced to do that through the Mylex BIOS during
system boot.

I've not given a lot of thought to where those
restrictions come from.  Certainly part of the
problem is a lack of specifications for Mylex.

It'd be really nice of global array manager could
do these things.

I'll give it a try.

On Thu, Dec 05, 2002 at 09:21:11PM +0200, Mihai RUSU wrote:
> On Thu, 5 Dec 2002, Dave Olien wrote:
> 
> ....
> > I've heard of something Mylex provides called
> > "global array manager" that runs on Linux.  But, I
> > think it requires a graphical front end on a windows
> > box.  I don't think it's open source either.
> > I'll look it over as a second priority after
> > this one.
> >
> > Dave
> >
> 
> Hi Dave
> 
> Yes, their software its pretty cool and its the only choice for using some
> of the features of the DAC960 (ex. MORE, setting queue tag len for single
> hdd, write-back cache for logical and physical drives, very nice event
> viewer, full SNMP variables exporting). They provide native linux
> drivers/server and win32 client (inside a rpm and using wine to start
> itself). Except for some minor visual problems the GAM client works pretty
> well with wine.
> 
> I sugest you to try it out.
> 
> ----------------------------
> Mihai RUSU
> 
> Disclaimer: Any views or opinions presented within this e-mail are solely
> those of the author and do not necessarily represent those of any company,
> unless otherwise specifically stated.
