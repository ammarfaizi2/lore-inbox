Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbSKRQDB>; Mon, 18 Nov 2002 11:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSKRQDB>; Mon, 18 Nov 2002 11:03:01 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:37307
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262813AbSKRQDA>; Mon, 18 Nov 2002 11:03:00 -0500
Date: Mon, 18 Nov 2002 11:12:15 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Taral <taral@taral.net>
cc: alsa-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: Oops when removing snd-timer
In-Reply-To: <20021118152748.GA8143@hatchling.taral.net>
Message-ID: <Pine.LNX.4.44.0211181110000.1538-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Taral wrote:

> On Mon, Nov 18, 2002 at 04:07:17AM -0500, Zwane Mwaikambo wrote:
> > Looks like you loaded ens137x.c and then that driver got unloaded leaving 
> > the callback still valid, then the core timer code decided to walk off a 
> > cliff using that pointer.
> 
> I don't have ens137x.c compiled, much less loaded. What makes you think
> this?

It was a guess, i presumed you were using one of the ac97 cards. Anyway 
it's irrelevant right now. You could of course make your problem report 
more descriptive wrt to what you loaded/unloaded, which order etc, so that 
reproducing and walking through the code paths is easier.

	Zwane
-- 
function.linuxpower.ca

