Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288882AbSAQOqV>; Thu, 17 Jan 2002 09:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288871AbSAQOqL>; Thu, 17 Jan 2002 09:46:11 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:29320
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288882AbSAQOqB>; Thu, 17 Jan 2002 09:46:01 -0500
Date: Thu, 17 Jan 2002 09:29:17 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Message-ID: <20020117092917.A7905@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20020116204345.A22055@thyrsus.com> <20020116164758.F12306@thyrsus.com> <esr@thyrsus.com> <200201162156.g0GLukCj017833@tigger.cs.uni-dortmund.de> <20020116164758.F12306@thyrsus.com> <26592.1011230762@redhat.com> <20020116204345.A22055@thyrsus.com> <3515.1011257639@redhat.com> <20020117083757.A7299@thyrsus.com> <13681.1011276592@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <13681.1011276592@redhat.com>; from dwmw2@infradead.org on Thu, Jan 17, 2002 at 02:09:52PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> Utter crap. CML2 makes them possible, and is a step in the right direction.
> I'm not suggesting that you never make these changes - just that you do them
> separately from the change in mechanism.

Sorry, it's *way* too late for that.  In fact, it was already way too
late for that at the kernel summit last March when Linus issued his ukase.
The "change in mechanism" phase of the project was essentially complete
almost a year ago now.  If you had been paying attention, you would 
have noticed this.

The idea that a pure change in mechanism could ever have been cleanly 
separated from changes in behavior was a fantasy anyway.  Large changes in
a software architecture just don't work that way, as we rediscover every
time a significant subsystem gets reworked to fix bugs.

I have held off on many things that I think badly need to be done in
order to pacify the conservative instincts of people like yourself --
for example, I think the device menus cry out to be reorganized on a
functional basis rather than on the basis of internal distinctions
like "block" vs. "character" devices that are pointless to anyone 
but a kernel implementor.

But if attempting that implausibility of no behavioral changes is what
you think I "agreed" to, we'd best both forget the "agreement" --
because it would be hypocrisy if I agreed falsely and an absurd,
project-strangling shackle if I agreed sincerely.

Continuity, avoiding gratuitous changes, and a good-faith effort to
emulate the interfaces people are expecting is one thing; artificial
stasis is entirely another.  I'm doing my best to give you the former.
You won't get the latter, no way, nohow.

If you have spotted errors, the time to tell me about them is *now*.
It's unfair to me and to other developers to artificially hold off
until we pass some mythical point at which it will suddenly be OK for
behavior to change.  The real world doesn't work that way, and I am
sure you are too experienced to believe it does.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

If a thousand men were not to pay their tax-bills this year, that would
... [be] the definition of a peaceable revolution, if any such is possible.
	-- Henry David Thoreau
