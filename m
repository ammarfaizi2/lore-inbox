Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264976AbTFQWZJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 18:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264975AbTFQWZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 18:25:09 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:14008 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264828AbTFQWYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 18:24:12 -0400
Date: Wed, 18 Jun 2003 00:38:04 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Riley Williams <Riley@Williams.Name>, davidm@hpl.hp.com,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
Message-ID: <20030618003804.A21001@ucw.cz>
References: <16110.4883.885590.597687@napali.hpl.hp.com> <BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name> <20030617232113.J32632@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030617232113.J32632@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, Jun 17, 2003 at 11:21:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 11:21:13PM +0100, Russell King wrote:

> On Tue, Jun 17, 2003 at 11:11:46PM +0100, Riley Williams wrote:
> > On most architectures, the said timer runs at 1,193,181.818181818 Hz.
> 
> Wow.  That's more accurate than a highly expensive Caesium standard.
> And there's one inside most architectures?  Wow, we're got a great
> deal there, haven't we? 8)

Well, it's unfortunately up to 400ppm off on most systems. Nevertheless
this is the 'official' frequency, actually it's a NTSC dotclock (14.3181818)
divided by 12.

> >  > Please do not add CLOCK_TICK_RATE to the ia64 timex.h header file.
> > 
> > It needs to be declared there. The only question is regarding the
> > value it is defined to, and it would have to be somebody with better
> > knowledge of the ia64 than me who decides that. All I can do is to
> > post a reasonable default until such decision is made.
> 
> If this is the case, we have a dilema on ARM.  CLOCK_TICK_RATE has
> been, and currently remains (at Georges distaste) a variable on
> some platforms.  I shudder to think what this is doing to some of
> the maths in Georges new time keeping and timer code.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
