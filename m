Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbRETUsv>; Sun, 20 May 2001 16:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbRETUsm>; Sun, 20 May 2001 16:48:42 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:12559 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S261509AbRETUsY>;
	Sun, 20 May 2001 16:48:24 -0400
Date: Sun, 20 May 2001 16:47:00 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy
Message-ID: <20010520164700.H4488@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010518112625.A14309@thyrsus.com> <20010518113726.A29617@devserv.devel.redhat.com> <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com> <20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com> <20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com> <20010520131457.A3769@thyrsus.com> <18686.990380851@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <18686.990380851@redhat.com>; from dwmw2@infradead.org on Sun, May 20, 2001 at 06:47:31PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> I think you already have the mechanism required to answer this - in NOVICE 
> mode you disallow the strange choices, in EXPERT mode you allow them.

That pushes the third button.  I'm nervous that if we go down this path
we will end up with a thicket of modes and a combinatorial explosion
in ruleset complexity, leading immediately to a user configuration
experience that is more complex than necessary, and eventually to an
unmaintainable mess in the rulesfiles.

In order to prevent that happening, I would like to have some recognized
criterion for configuration cases that are so perverse that it is a 
net loss to accept the additional complexity of handling them within the
configurator.

A lot of people (including, apparently, you) are saying there are no such
cases.  I wonder if you'll change your minds when you have to handle the
overhead yourselves?

Sigh...
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Government is not reason, it is not eloquence, it is force; like fire, a
troublesome servant and a fearful master. Never for a moment should it be left
to irresponsible action."
	-- George Washington, in a speech of January 7, 1790
