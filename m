Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRDFBDT>; Thu, 5 Apr 2001 21:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRDFBDJ>; Thu, 5 Apr 2001 21:03:09 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:58641 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130038AbRDFBCz>; Thu, 5 Apr 2001 21:02:55 -0400
Date: Fri, 6 Apr 2001 00:34:38 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@suse.cz>
cc: Robert-Velisav MICIOVICI <roby@dexter.allieddomecq.ro>,
        linux-kernel@vger.kernel.org
Subject: Re: [WISHLIST] Addition of suspend patch into 2.5?
In-Reply-To: <20010402144053.B34@(none)>
Message-ID: <Pine.LNX.3.96.1010406002842.18417A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Any idea if suspend/hybernation will be in future kernels?
> 
> I'd like it included, too. Some toshiba laptops support sleep but not
> suspend, and battery runs out within few hours if it was low before
> suspend. That's bad.
> 
> And the patch was pretty clean last time I checked.
> 								Pavel

Clean? I think it is impossible to write hibernation properly without
adding suspend/resume hooks to all drivers. And I doubt anybody is able to
do it.

If we don't rewrite all drivers, hibernation will be just a 'cool feature'
that doesn't work most time.

Mikulas

