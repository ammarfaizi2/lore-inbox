Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263058AbVFXQHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbVFXQHh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 12:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbVFXQHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 12:07:37 -0400
Received: from a.relay.invitel.net ([62.77.203.3]:55201 "EHLO
	a.relay.invitel.net") by vger.kernel.org with ESMTP id S263058AbVFXQA1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 12:00:27 -0400
Date: Fri, 24 Jun 2005 18:00:18 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Message-ID: <20050624160018.GB8591@vega.lgb.hu>
Reply-To: lgb@lgb.hu
References: <20050620235458.5b437274.akpm@osdl.org> <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu> <20050621142820.GC2015@openzaurus.ucw.cz> <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu> <20050621220619.GC2815@elf.ucw.cz> <E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu> <20050621233914.69a5c85e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050621233914.69a5c85e.akpm@osdl.org>
X-Operating-System: vega Linux 2.6.11.11-grsec-vega i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EHLO,

On Tue, Jun 21, 2005 at 11:39:14PM -0700, Andrew Morton wrote:
> >  > System where users can mount their own filesystems should not be
> >  > called "Unix" any more.
> > 
> >  It's not.  It's "Linux".
> 
> It would be helpful if we could have a brief description of the feature
> which you're discussing here.  We discussed this a couple of months back,
> but I've forgotten most of it and it was off-list I think.

<offtopic>

Excuse me, I'm far from being a filesystem/vfs expert ... However I've
got the idea about the merging fuse/reiser4 that some guys keep complaining
about the quite strange behaviour of these stuffs: when I write 'strange'
I mean strange from the view point of some standard unix ideas about filesystems
 (and anything related to filesystems like permission checking, namespaces
etc) and how they should be implemented and handled.

This reminds me articles about comparing Linux and BSDs. BSD guys claims
that BSD distros _ARE_ unices but Linux is not. It's out of scope to waste
mails about these flames like this (it's question of view point as almost
always) however there IS some lesson here. BSD systems are somewhat (well,
not counting the interesting ideas of DragonFly BSD) conservative to
implement new stuffs. I'm about stuffs like filesystem transactions, API
exported to the user space to be able to do things like deleting data from
the begining of the file (there is API call to truncate - from the end of
the file ...) and such (what a quite braindead idea to rewrite eg a 10Gbyte
long file just for inserting one byte to somewhere in the middle of the file
- in 2005 ...). The only thing explains where the later is not present in
most OSes is because of historical reasons and not technical ones. And if even
Linux does not want to open toward extended filesystem abilities which common
open source system will? I guess none.

I can inmagine that vendors of some closed source systems will exploit
the hole in the area of outdated filesystem concept of our current world
and when it becomes reality it's to late. Maybe.

Please forgive for my possible offtopic mail here but I could not resist :)

</offtopic>

-- 
- Gábor
