Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132324AbRDDUSv>; Wed, 4 Apr 2001 16:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132279AbRDDUSl>; Wed, 4 Apr 2001 16:18:41 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:23300 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S132272AbRDDUSK>;
	Wed, 4 Apr 2001 16:18:10 -0400
Date: Mon, 2 Apr 2001 14:40:53 +0000
From: Pavel Machek <pavel@suse.cz>
To: Robert-Velisav MICIOVICI <roby@dexter.allieddomecq.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [WISHLIST] Addition of suspend patch into 2.5?
Message-ID: <20010402144053.B34@(none)>
In-Reply-To: <20010222214308.B14395@bug.ucw.cz> <Pine.LNX.4.21md.0103291046060.2103-100000@dexter.allieddomecq.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21md.0103291046060.2103-100000@dexter.allieddomecq.ro>; from roby@dexter.allieddomecq.ro on Thu, Mar 29, 2001 at 10:54:17AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Just a small adition to the 2.5 whislist:
> Is "hibernation" on linux possible? Ideally it should write out on the /

I just said it is. However you definitely do not want to write it onto 
filesystem -- that's much too hard. But you can write it to the swap space,
and that's exactly what the patch does.

> running on ext2fs and the new journaling fs's like reiserfs, xfs, etx3 etc
> and not some special filesystem or unpartiotioned space etc. I mean that
> this should be working without the need to repartiotion/reinstall.
> This is something **very** useful for laptop owners, not having to shut 
> down (all) applications when need to grab the laptop and travel.
> Id' like to see this working nice in 2.6.
> 
> Best regards,
> r
> 
> On Thu, 22 Feb 2001, Pavel Machek wrote:
> 
> > Date: Thu, 22 Feb 2001 21:43:08 +0100
> > From: Pavel Machek <pavel@suse.cz>
> > To: Shawn Starr <spstarr@sh0n.net>, lkm <linux-kernel@vger.kernel.org>
> > Subject: Re: [WISHLIST] Addition of suspend patch into 2.5?
> > 
> > Hi!
> > 
> > > Any idea if suspend/hybernation will be in future kernels?
> > 
> > I'd like it included, too. Some toshiba laptops support sleep but not
> > suspend, and battery runs out within few hours if it was low before
> > suspend. That's bad.
> > 
> > And the patch was pretty clean last time I checked.
> > 								Pavel
> > -- 
> > I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
> > Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

