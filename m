Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318855AbSH1OpS>; Wed, 28 Aug 2002 10:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318856AbSH1OpR>; Wed, 28 Aug 2002 10:45:17 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:38821 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318855AbSH1OpR>;
	Wed, 28 Aug 2002 10:45:17 -0400
Date: Wed, 28 Aug 2002 16:49:08 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Gerhard Mack <gmack@innerfire.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Mikael Pettersson <mikpe@csd.uu.se>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.32 doesn't beep?
Message-ID: <20020828164908.B17287@ucw.cz>
References: <20020828150522.A13090@ucw.cz> <Pine.LNX.4.44.0208280957530.14061-100000@innerfire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0208280957530.14061-100000@innerfire.net>; from gmack@innerfire.net on Wed, Aug 28, 2002 at 09:58:42AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 09:58:42AM -0400, Gerhard Mack wrote:
> On Wed, 28 Aug 2002, Vojtech Pavlik wrote:
> 
> > 2.5.32 still has quite complex input core config options - sorry, my
> > fault, and I'll fix it soon. You have to enable CONFIG_INPUT_MISC and
> > CONFIG_INPUT_PCSPKR.
> 
> That begs the question:
> How do I input using the PC speaker ?

Reverse the time? Anyway, it makes sense, since for example Sun
keyboards (and others) have a beeper built into them, and those are
input devices. So the easiest way is to define PC speaker to be an input
device as well and then the common code can be the same.

-- 
Vojtech Pavlik
SuSE Labs
