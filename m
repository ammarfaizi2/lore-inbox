Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280663AbRKYDFH>; Sat, 24 Nov 2001 22:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280665AbRKYDE5>; Sat, 24 Nov 2001 22:04:57 -0500
Received: from otter.mbay.net ([206.40.79.2]:52232 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S280663AbRKYDEl>;
	Sat, 24 Nov 2001 22:04:41 -0500
Date: Sat, 24 Nov 2001 19:04:36 -0800 (PST)
From: John Alvord <jalvo@mbay.net>
To: Patrick McFarland <unknown@panax.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16-pre1
In-Reply-To: <20011124205632.C241@localhost>
Message-ID: <Pine.LNX.4.20.0111241903180.19439-100000@otter.mbay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If nothing else, the wart in 2.4.15 will make sure people move to the
Marcelo Tosatti tree promptly. Not a bad result...

john alvord

On Sat, 24 Nov 2001, Patrick McFarland wrote:

> Heh, speaking about stuff like this, isnt testing suppost to happen to kernels? I mean, in 2.4.14 we had the file loopback problem (_alot_ of people use that module, its great for building iso images and stuff)  and then we have the inode.c bug (which may or may not exist and the fix may or may not actually fix it) then it seems bugs in other sections of the kernel. Whats going on Linus? Stable kernel releases were never this bad before.
> 
> On 24-Nov-2001, Linus Torvalds wrote:
> > 
> > On Sat, 24 Nov 2001, Marcelo Tosatti wrote:
> > > >
> > > > Are these going to appear on the front page of kernel.org?
> > >
> > > They have to...
> > >
> > > I'm sure hpa will do that as soon as he has time to...
> > 
> > I also decided that the suggestion to move the "testing" subdirectory down
> > to below the kernel that the directory is for is a good idea.
> > 
> > So I moved all the 2.5.x testing stuff to kernel/v2.5/testing, leaving the
> > old kernel/testing directory basically orphaned.
> > 
> > Marcelo could either take over the old directory (which will make his
> > pre-patches show up on kernel.org automatically), or preferably just do
> > the same thing, and make the v2.4 test patches in v2.4/testing (which will
> > also require support from the site admin, who is probably overworked as-is
> > with the RAID failures ;)
> > 
> > 			Linus
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -- 
> Patrick "Diablo-D3" McFarland || unknown@panax.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

