Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbVCEMy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbVCEMy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 07:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbVCEMy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 07:54:58 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:16797 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262902AbVCEMxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 07:53:00 -0500
Date: Sat, 5 Mar 2005 13:53:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4: Alps touchpad too slow
Message-ID: <20050305125346.GA2592@ucw.cz>
References: <20050304221523.GA32685@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304221523.GA32685@hexapodia.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 02:15:23PM -0800, Andy Isaacson wrote:
> My Vaio r505te comes up with an unusably slow touchpad if I allow the
> ALPS driver to drive it.  It says
> 
> > ALPS Touchpad (Glidepoint) detected
> >   Disabling hardware tapping
> > input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
> 
> and then the trackpad operates at about 1/8 the speed I've gotten used
> to.
> 
> I'm running 2.6.11-rc4; this started happening somewhere between
> 2.6.10 and 2.6.11-rc3.
> 
> I've toyed with 'xset m', but nothing I've done there seems to have
> any effect.  (I suspect that Linux never generates the appropriate
> sequence of mouse events to trigger the X cursor acceleration regime.)
> 
> I can restore the original behavior by passing "proto=exps" to
> psmouse.o, in which case I get
> > input: PS/2 Generic Mouse on isa0060/serio1
> 
> On a related note, how are users supposed to control this newfangled
> PS2 driver?  I'd like at least the *option* to turn tapping back on,
> but I can't find any knobs *anywhere*.  And of course I'd like to
> adjust the tracking speed, too.

You can install the synaptics X driver

	http://web.telia.com/~u89404340/touchpad/

Which has all the knobs available and works with ALPSes too.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
