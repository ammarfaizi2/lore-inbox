Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbTIHNZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbTIHNYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:24:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50141 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262248AbTIHNYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:24:03 -0400
Date: Wed, 3 Sep 2003 10:06:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Vojtech Pavlik <vojtech@ucw.cz>, Vojtech Pavlik <vojtech@suse.cz>,
       Andries Brouwer <aebr@win.tue.nl>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030903080653.GM1358@openzaurus.ucw.cz>
References: <16189.58357.516036.664166@gargle.gargle.HOWL> <20030821003606.A3165@pclin040.win.tue.nl> <20030820225812.GB24639@mail.jlokier.co.uk> <20030821015258.A3180@pclin040.win.tue.nl> <20030821080145.GA11263@ucw.cz> <20030822022709.A3640@pclin040.win.tue.nl> <20030822073328.GA7473@ucw.cz> <20030825042235.GB20529@mail.jlokier.co.uk> <20030825082248.GA3341@ucw.cz> <20030825193600.GA24233@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825193600.GA24233@mail.jlokier.co.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > There is only one solution which works well that I can see: do the
> > > forced-up thing by default, but as soon as you see a real UP event
> > > from a key, disabled forced-up _for that key_ in future.
> > 
> > Won't work. There are keyboards that forget to send a key up event
> > sometimes. They usually send it, but from time to time they don't.
> > We need to cover these keyboards, too. It's actually the main reason for
> > the whole forced up thingy.
> 
> :(  That's a shame, and a peculiar bug too.  Then I agree that
> forced-up is needed all the time, if we do not know what triggers the
> keyboard to forget to send one or have any way to detect it.

Can we at least report keyboard as broken to the syslog?
Its usefull if we want manufacturers to eventually fix
their hw (and its extremely usefull when someone gives
you pre-production hw "see if you can break it")
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

