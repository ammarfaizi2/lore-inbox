Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280641AbRKYCAb>; Sat, 24 Nov 2001 21:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280647AbRKYCAX>; Sat, 24 Nov 2001 21:00:23 -0500
Received: from grip.panax.com ([63.163.40.2]:13067 "EHLO panax.com")
	by vger.kernel.org with ESMTP id <S280641AbRKYCAO>;
	Sat, 24 Nov 2001 21:00:14 -0500
Date: Sat, 24 Nov 2001 20:56:32 -0500
From: Patrick McFarland <unknown@panax.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16-pre1
Message-ID: <20011124205632.C241@localhost>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0111241744250.12119-100000@freak.distro.conectiva> <Pine.LNX.4.33.0111241311040.2591-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111241311040.2591-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.14 i686
X-Distributed: Join the Effort!  http://www.distributed.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heh, speaking about stuff like this, isnt testing suppost to happen to kernels? I mean, in 2.4.14 we had the file loopback problem (_alot_ of people use that module, its great for building iso images and stuff)  and then we have the inode.c bug (which may or may not exist and the fix may or may not actually fix it) then it seems bugs in other sections of the kernel. Whats going on Linus? Stable kernel releases were never this bad before.

On 24-Nov-2001, Linus Torvalds wrote:
> 
> On Sat, 24 Nov 2001, Marcelo Tosatti wrote:
> > >
> > > Are these going to appear on the front page of kernel.org?
> >
> > They have to...
> >
> > I'm sure hpa will do that as soon as he has time to...
> 
> I also decided that the suggestion to move the "testing" subdirectory down
> to below the kernel that the directory is for is a good idea.
> 
> So I moved all the 2.5.x testing stuff to kernel/v2.5/testing, leaving the
> old kernel/testing directory basically orphaned.
> 
> Marcelo could either take over the old directory (which will make his
> pre-patches show up on kernel.org automatically), or preferably just do
> the same thing, and make the v2.4 test patches in v2.4/testing (which will
> also require support from the site admin, who is probably overworked as-is
> with the RAID failures ;)
> 
> 			Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Patrick "Diablo-D3" McFarland || unknown@panax.com
