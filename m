Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265429AbRFVO1B>; Fri, 22 Jun 2001 10:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265435AbRFVO0v>; Fri, 22 Jun 2001 10:26:51 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:53000 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S265429AbRFVO0d>;
	Fri, 22 Jun 2001 10:26:33 -0400
Date: Fri, 22 Jun 2001 10:24:58 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Russell King <rmk@arm.linux.org.uk>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Missing help entries in 2.4.6pre5
Message-ID: <20010622102458.A13435@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Russell King <rmk@arm.linux.org.uk>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010622094934.A13075@thyrsus.com> <20010621160309.A6744@thyrsus.com> <20010621154934.A6582@thyrsus.com> <20010621205537.X18978@flint.arm.linux.org.uk> <20010621160309.A6744@thyrsus.com> <7987.993197604@redhat.com> <20010622094934.A13075@thyrsus.com> <10604.993218210@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <10604.993218210@redhat.com>; from dwmw2@infradead.org on Fri, Jun 22, 2001 at 02:56:50PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> The irritation only happened because you seem to have ignored the remainder
> of my original response and patch - which explained the status of the Ocelot
> and XScale options, and which removed the other offending option from
> Config.in completely. I'd removed the corresponding code before syncing up
> with Linus because it wanted rewriting before it could be submitted, just
> forgotten to remove the config option for it.

No, I remember that.  But if I don't remind lkml periodically that there is
work not done on this, I fear it will slide to the bottom of peoples'
to-do lists and fall off.  That's how we got to the distressing state where
about 1/4 of the configuration symbols weren't documented.  

I solved this problem by (a) working like a dog at writing help
entries myself, and (b) using a combination of supplication and
irritation on configuration maintainers to get them to hold up their
end.  This was effective; we've gone from 537 undocumented symbols to 2.

In any situation like this, supplication tends to work well initially;
you catch the cooperative people who would almost have done what you
needed anyway, which is usually 60% or more of them.  As you get
towards the bottom of the barrel, (subtle) irritation becomes more
important.  While it isn't *necessarily* the case that the last few
holdouts won't move unless you're a persistent pain in the butt about
it, that's the smart way to bet.

(I've done jobs like this before.  Couldn't you tell?  :-))

> I'm already rejecting patches which add new config entries but don't add 
> the corresponding help text. What more do you want?

That's very good, and I thank you for that policy.   From *you*, I don't
want anything else.  From the person(s) reponsible for the missing symbols,
I want documentation.  The problem is that, lacking a detailed database
of who is responsible for what, I don't know how to prod each of the
people I really want to supplicate/irritate without having you see it
also.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Rifles, muskets, long-bows and hand-grenades are inherently democratic
weapons.  A complex weapon makes the strong stronger, while a simple
weapon -- so long as there is no answer to it -- gives claws to the
weak.
        -- George Orwell, "You and the Atom Bomb", 1945
