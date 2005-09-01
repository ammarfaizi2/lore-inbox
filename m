Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbVIAP7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbVIAP7d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVIAP7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:59:33 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:58072 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030217AbVIAP7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:59:33 -0400
Subject: Re: State of Linux graphics
From: Jim Gettys <jg@freedesktop.org>
Reply-To: jg@freedesktop.org
To: Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <43171D33.9020802@tungstengraphics.com>
References: <9e47339105083009037c24f6de@mail.gmail.com>
	 <1125422813.20488.43.camel@localhost>
	 <20050831063355.GE27940@tuolumne.arden.org>
	 <1125512970.4798.180.camel@evo.keithp.com>
	 <20050831200641.GH27940@tuolumne.arden.org>
	 <1125522414.4798.222.camel@evo.keithp.com>
	 <20050901015859.GA11367@tuolumne.arden.org>
	 <1125547173.4798.289.camel@evo.keithp.com>
	 <43171D33.9020802@tungstengraphics.com>
Content-Type: text/plain
Date: Thu, 01 Sep 2005 11:59:33 -0400
Message-Id: <1125590374.9419.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-01 at 09:24 -0600, Brian Paul wrote:

> 
> If the blending is for screen-aligned rects, glDrawPixels would be a 
> far easier path to optimize than texturing.  The number of state 
> combinations related to texturing is pretty overwhelming.
> 
> 
> Anyway, I think we're all in agreement about the desirability of 
> having a single, unified driver in the future.
> 

Certainly for most hardware in the developed world I think we all agree
with this. The argument is about when we get to one driver model, not if
we get there, and not what the end state is.

In my view, the battle is on legacy systems and the very low end, not in
hardware we hackers use that might run Windows Vista or Mac OS X....  

I've had the (friendly) argument with Allen Akin for 15 years that due
to reduction of hardware costs we can't presume OpenGL.  Someday, he'll
be right, and I'll be wrong.  I'm betting I'll be right for a few more
years, and I nothing would tickle me pink more to lose the argument
soon...

Legacy hardware and that being proposed/built for the developing world
is tougher; we have code in hand for existing chips, and the price point
is even well below cell phones on those devices. They don't have
anything beyond basic blit and, miracles of miracles, alpha blending.
These are built on one or two generation back fabs, again for cost.
And as there are no carriers subsidizing the hardware cost, the real
hardware cost has to be met, at very low price points.  They don't come
with the features Allen admires in the latest cell phone chips.

I think the onus of proof that we can immediately completely ditch a
second driver framework in favor of everything being OpenGL, even a
software tuned one, is in my view on those who claim that is viable.
Waving one's hands and claiming there are 100 kbyte closed source
OpenGL/ES implementations doesn't cut it in my view, given where we are
today with the code we already have in hand.  So far, the case hasn't
been made.

Existence proof that we're wrong and can move *entirely* to OpenGL
sooner rather than later would be gratefully accepted..
		Regards,
			Jim


