Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135899AbREDHrA>; Fri, 4 May 2001 03:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135900AbREDHqu>; Fri, 4 May 2001 03:46:50 -0400
Received: from [207.106.50.26] ([207.106.50.26]:3598 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135899AbREDHqj>;
	Fri, 4 May 2001 03:46:39 -0400
Date: Fri, 4 May 2001 03:47:19 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: Why recovering from broken configs is too hard
Message-ID: <20010504034719.B10356@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010503034755.A27693@thyrsus.com> <200105032358.f43NwOB84159@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105032358.f43NwOB84159@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Thu, May 03, 2001 at 07:58:24PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan <acahalan@cs.uml.edu>:
> Procedure:
> 
> 1. throw out all junk symbols (could try spell checking first)
> 2. mark non-default settings as read-only
> 3. add missing symbols as needed to meet constraints
> 4. add any additional missing symbols
> 5. mutate the config until it works... user may ^C when bored

You can't be serious.  You invite the poor user to sit through an
indefinite, unpredictable, and *large* number of mutation passes
hoping the stupid search will trip over a solution?  That's a far worse
waste of their time than telling them to correct by hand in the
exceedingly rare cases that would be necessary, in my considered
opinion.

A more egregious case of using a bazooka to swat a fly I've seldom seen.
Can we restore some sense of *proportion* here?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Rifles, muskets, long-bows and hand-grenades are inherently democratic
weapons.  A complex weapon makes the strong stronger, while a simple
weapon -- so long as there is no answer to it -- gives claws to the
weak.
        -- George Orwell, "You and the Atom Bomb", 1945
