Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262962AbTCSIJT>; Wed, 19 Mar 2003 03:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262961AbTCSIJT>; Wed, 19 Mar 2003 03:09:19 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:63106 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S262962AbTCSIJO>;
	Wed, 19 Mar 2003 03:09:14 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm1
References: <20030318031104.13fb34cc.akpm@digeo.com>
	<87adfs4sqk.fsf@lapper.ihatent.com>
	<87bs08vfkg.fsf@lapper.ihatent.com>
	<20030318160902.C21945@flint.arm.linux.org.uk>
	<873clkw6ui.fsf@lapper.ihatent.com>
	<20030318162601.78f11739.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 19 Mar 2003 09:20:11 +0100
In-Reply-To: <20030318162601.78f11739.akpm@digeo.com>
Message-ID: <87fzpjpy2s.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> Alexander Hoogerhuis <alexh@ihatent.com> wrote:
> >
> > I'm not suspecting the PCI in particular for the PCIC-bits, only
> > making X and the Radeon work again. But here you are:
> 
> Something bad has happened to the Radeon driver in recent kernels.  I've seen
> various reports with various syptoms and some suspicion has been directed at
> the AGP changes.
> 
> But as far as I know nobody has actually got down and done the binary search
> to find out exactly when it started happening.

The best I've narrowed it down to is whatever makes 2.5.64-mm1 be
different from plain 2.5.64 and 2.5.64-mm2. In addition, I have one
more gripe, and this one is present in 2.4 too, but seems kernel
related:

When closing Gnome (Gnome 2.x, Gentoo), after the screen has been
"faded" by the logout applet, on the first keystroke or movement of
the mouse the machine will instantly cold start the machine.

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
