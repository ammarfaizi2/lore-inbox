Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263035AbSJRI5j>; Fri, 18 Oct 2002 04:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263152AbSJRI5j>; Fri, 18 Oct 2002 04:57:39 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:9354 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263035AbSJRI5i>;
	Fri, 18 Oct 2002 04:57:38 -0400
Date: Fri, 18 Oct 2002 11:03:23 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Thomas Molina <tmolina@cox.net>
Cc: Christopher Hoover <ch@murgatroid.com>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz, Arnaud Gomes-do-Vale <arnaud@carrosse.frmug.org>
Subject: Re: [PATCH] 2.5.43: Fix for Logitech Wheel Mouse
Message-ID: <20021018110323.A26747@ucw.cz>
References: <20021017231953.A17985@heavens.murgatroid.com> <Pine.LNX.4.44.0210180354140.19699-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0210180354140.19699-100000@dad.molina>; from tmolina@cox.net on Fri, Oct 18, 2002 at 04:00:37AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 04:00:37AM -0500, Thomas Molina wrote:

> On Thu, 17 Oct 2002, Christopher Hoover wrote:
> 
> > The wheel on my Logitech mouse doesn't work under the input layer.
> > The mouse was originally recognized as:
> > 
> >   input: PS2++ Logitech Mouse on isa0060/serio1
> > 
> > In this mode, the driver also emits (just once?):
> > 
> >   psmouse.c: Received PS2++ packet #0, but don't know how to handle.
> > 
> > 
> > The following patch simply swaps the order of detection of Logitech PS
> > 2++ and Intellimouse protocols.  Now my mouse is recognized as:
> > 
> >   input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
> > 
> > And the wheel works properly in this mode.
> 
> I am also carrying a problem report from Arnaud Gomes-do-Vale with this 
> exact problem.  If this is deemed a proper fix it would probably close 
> the other outstanding report.

No, it unfortunately is not a proper fix. I'll have to analyze the
problem some more.

-- 
Vojtech Pavlik
SuSE Labs
