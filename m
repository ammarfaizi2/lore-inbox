Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281865AbRLQSSh>; Mon, 17 Dec 2001 13:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281854AbRLQSS1>; Mon, 17 Dec 2001 13:18:27 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:59562 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281811AbRLQSSQ>; Mon, 17 Dec 2001 13:18:16 -0500
Date: Mon, 17 Dec 2001 11:17:33 -0700
Message-Id: <200112171817.fBHIHXj09903@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ken Brownfield <brownfld@irridia.com>
Subject: Re: Linux 2.4.17-rc1
In-Reply-To: <Pine.LNX.4.21.0112171450240.3255-100000@freak.distro.conectiva>
In-Reply-To: <E16FTOd-00007M-00@starship.berlin>
	<Pine.LNX.4.21.0112171450240.3255-100000@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:
> On Sun, 16 Dec 2001, Daniel Phillips wrote:
> > Will there be a rc2?
> 
> Yes there will.
> 
> There have been reiserfs bug reports (I'm waiting for the fix for
> -rc2), and I'm waiting for Richard's patch to fix a devfs update
> issue.

I've got the devfs patch ready, I'm just waiting for followups on bug
reports from people. I was also hoping to get feedback from Al about
the blkdev+devfs races, but he hasn't followed up. I was going to send
it to you once I've gotten those followups. But if you want to apply
the patch anyway (and thus defer some testing to -rc2), let me know
and I'll send it off to you. I'm assuming that Al's silence means he
hasn't managed to poke holes in my solution :-)

Either way, I'm pretty confident that my current patch is an
improvement, even it it doesn't fix everything.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
