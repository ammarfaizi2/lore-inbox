Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261919AbSJIReS>; Wed, 9 Oct 2002 13:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261927AbSJIReS>; Wed, 9 Oct 2002 13:34:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49937 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261919AbSJIReK>; Wed, 9 Oct 2002 13:34:10 -0400
Date: Wed, 9 Oct 2002 10:41:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Patrick Mochel <mochel@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210091025500.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210091038540.7355-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Patrick Mochel wrote:
> 
> > I think that is a valid argument as long as it's called "driverfs" or
> > something, but since the thing is clearly evolving into a "kernelfs"  
> 
> BTW, is that the name you prefer, and will you take the patch? 

I do know that "kfs" is too much of a random collection of consonants.  
Looks like something out of an IBM architecture manual. "kernelfs" is more
acceptable, I think, but it's not perfect either - it's a bit too generic.  
Isn't /proc a kernelfs too? But I can't come up with anything better..

		Linus

