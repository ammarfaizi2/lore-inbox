Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVCUWpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVCUWpV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVCUWot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:44:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:38860 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262162AbVCUWoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:44:22 -0500
Date: Mon, 21 Mar 2005 14:44:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: 2.6.11-rc4: Alps touchpad too slow
Message-Id: <20050321144412.5e6d9398.akpm@osdl.org>
In-Reply-To: <20050304221523.GA32685@hexapodia.org>
References: <20050304221523.GA32685@hexapodia.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson <adi@hexapodia.org> wrote:
>
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
> 

Andy, could you please test 2.6.12-rc1 and let us know which problems
remain?

Thanks.

