Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSGYSrf>; Thu, 25 Jul 2002 14:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSGYSrf>; Thu, 25 Jul 2002 14:47:35 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:59145 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315449AbSGYSre>;
	Thu, 25 Jul 2002 14:47:34 -0400
Date: Thu, 25 Jul 2002 11:50:25 -0700
From: Greg KH <greg@kroah.com>
To: Sven.Riedel@tu-clausthal.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Keyboards with recent 2.4.19-pre/rcXX and 2.5.2X
Message-ID: <20020725185025.GI16518@kroah.com>
References: <20020724140026.GE9765@moog.heim1.tu-clausthal.de> <20020724173505.GE10124@kroah.com> <20020725161221.GA10866@moog.heim1.tu-clausthal.de> <20020725181519.GC16518@kroah.com> <20020725184637.GA12366@moog.heim1.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020725184637.GA12366@moog.heim1.tu-clausthal.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 27 Jun 2002 14:33:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 08:46:37PM +0200, Sven.Riedel@tu-clausthal.de wrote:
> On Thu, Jul 25, 2002 at 11:15:19AM -0700, Greg KH wrote:
> > > > You _did_ run 'make oldconfig' when upgrading kernel versions, right?
> > > Uhm, no. What does that do? Never heard of it before...
> > 
> > EVERY TIME you move a different .config file from a different kernel
> > version you HAVE to run 'make oldconfig' to fix up the differences.
> > This means everytime you upgrade your kernel version, you have to do it
> > before rebuilding the kernel.
> 
> Well, actually I usually do go through the kernel in menuconfig and set
> all the options by hand. But I didn't consider that kernel option to be
> important for actually using the keyboard and mouse, because so far it
> had worked without this new option. And it didn't really scream for any
> attention whatsoever. So it got ignored. Happened to some of my friends
> too :). Maybe rename it to something that grabs your attention before
> .19 gets released :)

Nope, that's what 'make oldconfig' is there for.  That combined with
reading the help entry for the new config items would have told you that
this was a necessary thing for you to enable.

thanks,

greg k-h
