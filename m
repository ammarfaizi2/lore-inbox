Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131665AbRCTAVx>; Mon, 19 Mar 2001 19:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131671AbRCTAVe>; Mon, 19 Mar 2001 19:21:34 -0500
Received: from [24.221.152.185] ([24.221.152.185]:60654 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S131665AbRCTAVb>; Mon, 19 Mar 2001 19:21:31 -0500
Date: Mon, 19 Mar 2001 17:16:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "J. Michael Kolbe" <wicked@convergence.de>
Cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: sysrq.txt
Message-ID: <20010319171623.C26631@opus.bloom.county>
In-Reply-To: <20010316161919.A30690@midget.convergence.de> <20010318233955.D13058@bug.ucw.cz> <20010319091559.A22291@opus.bloom.county> <20010319203659.A17888@dontpanic.int.convergence.de> <20010319134653.C22291@opus.bloom.county> <3AB692BB.7AFCC646@uow.edu.au> <20010319162135.B26631@opus.bloom.county> <20010320010053.A248@dontpanic.int.convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010320010053.A248@dontpanic.int.convergence.de>; from wicked@convergence.de on Tue, Mar 20, 2001 at 01:00:53AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2001 at 01:00:53AM +0100, J. Michael Kolbe wrote:
> Hi.
> 
> On Mon, Mar 19, 2001 at 04:21:35PM -0700, Tom Rini wrote:
> > On Mon, Mar 19, 2001 at 11:14:03PM +0000, Andrew Morton wrote:
> > 
> > > I included Mr Kolbe's one-liner in the SAK patch which I put
> > > out on Sunday.  Now my head is spinning.
> > > 
> > > What *should* the change to sysrq.txt say?
> > 
> > Well, I think:
> > 
> > On PowerPC - You press 'ALT-Print Screen (or F13)-<command key>
> > 
> > Which is what 2.2 says, but mentions F13 directly (incase print screen isn't
> > on the key.).  The above even makes sense for 2 of my machines which have
> > working sysrq and keyboards.
>
> Well, I've just found an old USB Keyboard, none of the mentioned
> Keyboard combos work, as there is neither F13 nor PrintScreen.

Yes, as SysRq quite possibly doesn't work on (since none of the keys on it
send the right keycode.)

> 
> Btw, I'm using an old Newworld G3, the one with ADB.

The old one. :)

> I'd say sysrq.txt should say:
> 
> On PowerPC - Press 'ALT - Print Screen (or F13) - <command key>
> On Newworld PPC - You press 'Keypad+ - Print Screen (or F13) - <command key>
> 
> I'm still trying to figure out how to do it with the F13-less Keyboard..

Er, I thought you just said you did?  What keycodes are you using?  Most
"Newworld" only have the F13-less keyboard.  Which sort of raises the question
of how 'Keypad +' worked instead of the "ALT" key (either option/alt or the
scroll key, whichever changes VC).  Which sounds more like a fluke then
anything else.  Which keyboard worked with 'Keypad +' ?  The ADB one?
After some quick playing with my oldworld machine, Just F13 - <command key>
is sufficient.  I'm not sure about PReP tho (so it's probably not worth
saying you don't need "ALT").

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
