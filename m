Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280664AbRKYCgd>; Sat, 24 Nov 2001 21:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280663AbRKYCgV>; Sat, 24 Nov 2001 21:36:21 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:22898 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S280662AbRKYCgG>; Sat, 24 Nov 2001 21:36:06 -0500
Message-ID: <3C0058CF.D97D0E2B@starband.net>
Date: Sat, 24 Nov 2001 21:34:55 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick McFarland <unknown@panax.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16-pre1
In-Reply-To: <Pine.LNX.4.21.0111241744250.12119-100000@freak.distro.conectiva> <Pine.LNX.4.33.0111241311040.2591-100000@penguin.transmeta.com> <20011124205632.C241@localhost> <20011124211204.D241@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.14 - Has deactivate_page linker bug.  Fix: Edit loop.c, and delete the deactivate_page() function calls.

2.4.13 - No known bugs.

2.4.12 - Parallel port driver broken in this release.

2.4.11 - Allows local denial of service using symlinks.

http://www.ramdown.com/war/kernel.html

Patrick McFarland wrote:

> er, I think I ment 2.4.13 for the loopback bug... or did that have the ieee parport problem...
>
> On 24-Nov-2001, Patrick McFarland wrote:
> > Heh, speaking about stuff like this, isnt testing suppost to happen to kernels? I mean, in 2.4.14 we had the file loopback problem (_alot_ of people use that module, its great for building iso images and stuff)  and then we have the inode.c bug (which may or may not exist and the fix may or may not actually fix it) then it seems bugs in other sections of the kernel. Whats going on Linus? Stable kernel releases were never this bad before.
> >
> > On 24-Nov-2001, Linus Torvalds wrote:
> > >
> > > On Sat, 24 Nov 2001, Marcelo Tosatti wrote:
> > > > >
> > > > > Are these going to appear on the front page of kernel.org?
> > > >
> > > > They have to...
> > > >
> > > > I'm sure hpa will do that as soon as he has time to...
> > >
> > > I also decided that the suggestion to move the "testing" subdirectory down
> > > to below the kernel that the directory is for is a good idea.
> > >
> > > So I moved all the 2.5.x testing stuff to kernel/v2.5/testing, leaving the
> > > old kernel/testing directory basically orphaned.
> > >
> > > Marcelo could either take over the old directory (which will make his
> > > pre-patches show up on kernel.org automatically), or preferably just do
> > > the same thing, and make the v2.4 test patches in v2.4/testing (which will
> > > also require support from the site admin, who is probably overworked as-is
> > > with the RAID failures ;)
> > >
> > >                     Linus
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> >
> > --
> > Patrick "Diablo-D3" McFarland || unknown@panax.com
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

