Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316581AbSEUULw>; Tue, 21 May 2002 16:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316583AbSEUULv>; Tue, 21 May 2002 16:11:51 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:8710 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316581AbSEUULv>;
	Tue, 21 May 2002 16:11:51 -0400
Date: Tue, 21 May 2002 13:10:51 -0700
From: Greg KH <greg@kroah.com>
To: "Timothy E. Jedlicka - wrk" <bonzo@lucent.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-usb-users@lists.sourceforge.net
Subject: Re: What to do with all of the USB UHCI drivers in the kernel?
Message-ID: <20020521201051.GC2623@kroah.com>
In-Reply-To: <20020520223132.GC25541@kroah.com> <20020521152316.029228C362@bonzo.localdomain.fake>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 23 Apr 2002 18:30:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 10:23:15AM -0500, Timothy E. Jedlicka - wrk wrote:
> greg@kroah.com said:
> > Ok, now that 2.5.16 is out, we have a total of 4 different USB UHCI
> > controller drivers in the kernel!  That's about 3 too many for me :)
> 
> Stupid follow-up question for you.  Is it possible for me to stay on 2.4.18, 
> but test the 2.5.16 USB subsystem?  I really don't want to move my whole 
> system to 2.5.16, but would be willing to experiment with the USB parts.  Is 
> this possible?  Can I just rebuild the usb modules - I'm guessing this 
> wouldn't work, but thought I would ask anyway.  Or to ask another way - any 
> way us 2.4 folks can help?

You _might_ want to try dropping the drivers/usb tree from 2.5.x into
2.4 (and the usb files in include/linux/usb*.h too) and see what
happens.

Odds are the build process will not work, and I think some of the usbfs
changes will also not work.  But it would be interesting to see what you
found :)

So in short, I don't think that you could test out the 2.5 code on 2.4.
Is there some reason you can't run a 2.5 kernel?  Personally I run it on
lots of different machines (laptops, desktops, servers, etc.)
successfully.

If you can't run a 2.5 kernel, you can just take a look through the
code, and tell me what you think of that.  Readability is one of the
criteria I'm going to be using.

thanks,

greg k-h
