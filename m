Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVCILXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVCILXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 06:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVCILXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 06:23:39 -0500
Received: from mail.dif.dk ([193.138.115.101]:29400 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262335AbVCILWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 06:22:49 -0500
Date: Wed, 9 Mar 2005 12:23:57 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       chrisw@osdl.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.11.2
In-Reply-To: <Pine.LNX.4.62.0503091139470.22598@numbat.sonytel.be>
Message-ID: <Pine.LNX.4.62.0503091221170.2426@dragon.hyggekrogen.localhost>
References: <20050309083923.GA20461@kroah.com> <Pine.LNX.4.61.0503090950200.7496@student.dei.uc.pt>
 <Pine.LNX.4.62.0503091104180.22598@numbat.sonytel.be>
 <Pine.LNX.4.61.0503091014580.7496@student.dei.uc.pt>
 <Pine.LNX.4.62.0503091139470.22598@numbat.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Geert Uytterhoeven wrote:

> On Wed, 9 Mar 2005, Marcos D. Marado Torres wrote:
> > On Wed, 9 Mar 2005, Geert Uytterhoeven wrote:
> > > > > which is a patch against the 2.6.11.1 release.  If consensus arrives
> > > > > that this patch should be against the 2.6.11 tree, it will be done that
> > > > > way in the future.
> > > > 
> > > > IMHO it sould be against 2.6.11 and not 2.6.11.1, like -rc's that are'nt
> > > > againt
> > > > the last -rc but against 2.6.x.
> > > 
> > > It's a stable release, not a pre/rc, so against 2.6.11.1 sounds most logical
> > > to
> > > me.
> > 
> > Well, yes, _if_ 2.6.12 patch is going to be to aply against 2.6.11.last
> > instead
> > of 2.6.11. And, well, either one will cause great panic for hose who aren't
> > and
> > the mailing lists and just visit kernel.org to downoad the latest stuff.
> 
> Probably the 2.6.12 patch will be against 2.6.11, since:
>   - The 2.6.11.x line may continue after 2.6.12 was released
>   - 2.6.11.x may contain `quick and dirty' fixes for problems, which will be
>     fixed `properly' in 2.6.12 (or later), cfr. Alan Cox' presentation at
>     FOSDEM.
> 
Would it be that hard to have scripts on kernel.org generate the diff 
against 2.6.11 when Greg puts up the 2.6.11.3 diff against 2.6.22.2, then 
have the front page have two links, one for patch against 2.6.11 and one 
for patch against previous 2.6.11.z ?  That along with the full source 
(which I see is up there already) should make everyone happy, and if it is 
automated the burden on Greg should be minimal.


-- 
Jesper Juhl

