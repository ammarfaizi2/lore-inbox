Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261967AbSJIRiA>; Wed, 9 Oct 2002 13:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261968AbSJIRiA>; Wed, 9 Oct 2002 13:38:00 -0400
Received: from air-2.osdl.org ([65.172.181.6]:61870 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261967AbSJIRh7>;
	Wed, 9 Oct 2002 13:37:59 -0400
Date: Wed, 9 Oct 2002 10:46:10 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210091038540.7355-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210091043070.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Linus Torvalds wrote:

> 
> On Wed, 9 Oct 2002, Patrick Mochel wrote:
> > 
> > > I think that is a valid argument as long as it's called "driverfs" or
> > > something, but since the thing is clearly evolving into a "kernelfs"  
> > 
> > BTW, is that the name you prefer, and will you take the patch? 
> 
> I do know that "kfs" is too much of a random collection of consonants.  
> Looks like something out of an IBM architecture manual. "kernelfs" is more
> acceptable, I think, but it's not perfect either - it's a bit too generic.  
> Isn't /proc a kernelfs too? But I can't come up with anything better..

The fantasy that we have is to start reverting procfs back to what it was
originally designed for (and what the name hints at): displaying process
information. Of course, that will never be entirely possible, but we'll
always have our dreams.

Peter Anvin suggest 'kernfs', which ain't bad. Then again, we could just
call it 'patfs'..

	-pat

