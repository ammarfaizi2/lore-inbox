Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261201AbRERRSi>; Fri, 18 May 2001 13:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261219AbRERRS2>; Fri, 18 May 2001 13:18:28 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:12553 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S261201AbRERRSK>;
	Fri, 18 May 2001 13:18:10 -0400
Date: Fri, 18 May 2001 13:17:07 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
Message-ID: <20010518131707.N14309@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010518115839.E14309@thyrsus.com> <E150mhR-0007Ig-00@the-village.bc.nu> <20010518123413.I14309@thyrsus.com> <3B0551B4.CB251F64@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B0551B4.CB251F64@redhat.com>; from arjanv@redhat.com on Fri, May 18, 2001 at 05:45:40PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com>:
> I hereby volunteer to maintain at least make oldconfig and make config, 
> and perhaps make menuconfig.

That's the easy part; the CML1 config code may be ugly and broken, but
at least it's relatively stable.  What you'd also have to do is maintain an
entire CML1 ruleset in parallel with the canonical CML2 one.  That's 
the hard part.

I've been keeping the CML2 ruleset synced with CML1 for a year now. 
It's been an ugly, nasty, horrible job -- *much* nastier, by an order
of magnitude, than designing and writing the CML2 engine.  Going the
other direction would be worse.  "Like chewing razor blades" is the
simile that leaps to mind.

(And no, dropping back to CML1 format for the masters wouldn't be an
option; it doesn't have the semantic strength to enable CML2's new
capabilities.)
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Certainly one of the chief guarantees of freedom under any government,
no matter how popular and respected, is the right of the citizens to
keep and bear arms.  [...] the right of the citizens to bear arms is
just one guarantee against arbitrary government and one more safeguard
against a tyranny which now appears remote in America, but which
historically has proved to be always possible.
        -- Hubert H. Humphrey, 1960
