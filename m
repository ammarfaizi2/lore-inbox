Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314065AbSDQFKB>; Wed, 17 Apr 2002 01:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314066AbSDQFKA>; Wed, 17 Apr 2002 01:10:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43272 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314065AbSDQFKA>; Wed, 17 Apr 2002 01:10:00 -0400
Date: Tue, 16 Apr 2002 22:08:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] USB device support for 2.5.8 (take 2)
In-Reply-To: <20020417035236.GC29897@kroah.com>
Message-ID: <Pine.LNX.4.33.0204162203510.15675-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Apr 2002, Greg KH wrote:
>
> It's code to be a USB client device, not a USB host device, which is
> what we currently have.  It is used in embedded devices that run Linux,
> like the new Sharp device (can't remember the name right now...)

Ahhh.. A dim light goes on.

It would have made more sense (I think) to call it "usb/client" instead of
"usb/device", but maybe that's just because I didn't understand what the
thing was all about.

(Ask Davem some day about my irrational hang-ups about naming, and how I
sometimes like the same code if it's just named differently ;)

> Sorry.  I spend most of my time on this code just cleaning the format
> and removing build errors, instead of looking at the content :(
>
> I'll work on fixing all of the crap before submitting it again.

In this case, the only reason I started really looking at the content was
that I didn't know what it was even supposed to do and was confused about
the naming, so I started looked at a few files. Which didn't really make
me go understand what it did, but _did_ make me puke.

Maybe the rest of it is wonderfully beautiful code, and I was just unlucky
in my selection ;)

			Linus

