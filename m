Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291678AbSBNOUc>; Thu, 14 Feb 2002 09:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291679AbSBNOUW>; Thu, 14 Feb 2002 09:20:22 -0500
Received: from [212.3.242.3] ([212.3.242.3]:52230 "HELO mail.i4gate.net")
	by vger.kernel.org with SMTP id <S291678AbSBNOUF>;
	Thu, 14 Feb 2002 09:20:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Daniel Pittman <daniel@rimspace.net>
Subject: Re: What does AddrMarkNotFound mean?
Date: Thu, 14 Feb 2002 15:16:14 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16b8Ab-0006f6-00@the-village.bc.nu> <871yfpf046.fsf@inanna.rimspace.net>
In-Reply-To: <871yfpf046.fsf@inanna.rimspace.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020214142013Z291678-13996+23204@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 February 2002 00:11, Daniel Pittman wrote:
> On Wed, 13 Feb 2002, Alan Cox wrote:
> >> Is this typical behavior for a hard drive which has developed bad
> >> blocks?  And if I blacklist the affected blocks in the filesystem,
> >> should I also blacklist a few previous blocks in order to avoid
> >> problems with the readahead feature of the IDE drivers?
> >
> > Its a disk error (it can't find the index marks for a sector). In
> > general its a bad sign and you might want to check the smart data for
> > the disk.
> >
> > If you bought an IBM disk within the last 18 months or so check for
> > new firmware, flash it if so and reformat it before panicing and
> > assuming the worst.
>
> Having done precisely that, and ended up owning an IBM hard drive that
> has hit exactly this problem, like so many before this, this firmware
> upgrade idea is rather appealing. It would be nice to be able to trust
> the drive...
>
> ...but I can't seem to find the firmware anywhere on the IBM storage
> site or, in fact, anywhere.  Have you any hints as to where I might
> look?
>

It isn't on the site.

> It's a DTLA-307030, made in Hungary, if that makes it easier to help. :)

The firmware can be found here:

http://www.scan.co.uk/ibmhddtest.htm

I must say that personally I've had this IBM DTLA drive for over 1.5 years 
now, and I haven't seen any problems with it whatsoever.
A friend of mine had the same problems (bad sectors), he reformatted the 
drive with the IBM drive tool and got rid of all bad sectors.

>
> Thanks,
>         Daniel

Good luck revamping your drive!

DK
