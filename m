Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWGLAwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWGLAwb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWGLAwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:52:31 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:30620 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932305AbWGLAwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:52:30 -0400
Date: Wed, 12 Jul 2006 02:52:24 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: pavel@ucw.cz, roubert@df.lth.se, stern@rowland.harvard.edu,
       dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Magic Alt-SysRq change in 2.6.18-rc1
In-Reply-To: <20060711173735.43e9af94.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607120248050.12900@scrub.home>
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
 <20060710094414.GD1640@igloo.df.lth.se> <Pine.LNX.4.64.0607102356460.17704@scrub.home>
 <20060711124105.GA2474@elf.ucw.cz> <Pine.LNX.4.64.0607120016490.12900@scrub.home>
 <20060711224225.GC1732@elf.ucw.cz> <Pine.LNX.4.64.0607120132440.12900@scrub.home>
 <20060711165003.25265bb7.akpm@osdl.org> <Pine.LNX.4.64.0607120213060.12900@scrub.home>
 <20060711173735.43e9af94.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 11 Jul 2006, Andrew Morton wrote:

> > > > > BTW I believe that original way (alt down, sysrq down, b down) still
> > > > > works before and after the patch.
> > > > 
> > > > No, it doesn't.
> > > > 
> > > > > Here's patch that updates docs with now-working trick.
> > > > 
> > > > NACK.
> > > > 
> > > 
> > > Nack your nack!  The patch in 2.6.18-rc1 makes sysrq work on machines on
> > > which it *did not work at all*.  If that makes it harder to type but still
> > > possible to type on other machines, well, we win.
> > 
> > Why can't we even _try_ to preserve compatibility? :-(
> > 
> 
> It would of course be good if we could do that.  If it's impossible to
> retain the old behaviour without breaking those oddball keyboards then
> we're screwed.
> 
> IOW, someone needs to find a way to make the new code work like the old
> code without re-breaking Pavel's keyboard.  But the bitchin-to-patchin
> ratio here seems to exclude that outcome.

Traditionally that responsibility is in the hands of whose who break it in 
the first place, so this patch needs to be either reverted or fixed 
(preferably before 2.18).

bye, Roman
