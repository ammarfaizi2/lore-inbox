Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSEXV4r>; Fri, 24 May 2002 17:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312279AbSEXV4q>; Fri, 24 May 2002 17:56:46 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:40604 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312254AbSEXV4q>;
	Fri, 24 May 2002 17:56:46 -0400
Date: Fri, 24 May 2002 17:56:32 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@e-mind.com>
cc: Dan Kegel <dank@kegel.com>, Andrew Morton <akpm@zip.com.au>,
        Hugh Dickins <hugh@veritas.com>, Christoph Rohland <cr@sap.com>,
        Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <20020524202658.GI15703@dualathlon.random>
Message-ID: <Pine.GSO.4.21.0205241637500.9792-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Andrea Arcangeli wrote:

> Now dropping this feature from tux is a matter of a few hours and it
> cannot make difference if your vfs working set fits in dcache, but
> that's not the problem. I wonder what's next, should I apply for a
> patent for the classzone algorithm in the memory balancing or is Ingo
> going to patent the O1 scheduler too? Ingo, Alan, Arjan, DaveM are so much
> worried about binary only modules, Alan even speaks about the DMCA all
> over the place, this is an order of magnitude worse, this even forbids
> you to use this tequnique despite you may invented it too from scratch
> and it's your own idea too. To make the opposite example despite IBM is
> a big patent producer IBM even allowed the usage of their RCU patents in
> the linux kernel (I've the paperwork under my desk and Linus should have
> received too), and other stuff donated to gcc and probably much more
> that I don't know about, IMHO exactly to avoid linux to be castrated by
> patents. So this news is totally stunning from my part.

	For once I have to agree with Andrea.  Software patents do not
magically become better if you allow GPLed software to make use of them.
It's one thing to put your _code_ under whatever license you like.  That
defines what you consider acceptable use and what - inexcusable plagiarism.

	"Using what I'd learnt from your work" and "lending the book I've
bought to a friend" are equally old and respectable things.  Hell, the former
might very well be older, for all we know.  Both may be inconvenient to, ahem,
producers of intellectual property.  It doesn't make attempts to limit them
morally acceptable.

	Don't get me wrong - I despise the "let's abolish IP rights" crowd.
Plagiarism is Wrong and author has absolute right to choose the conditions
for use of the things he'd written.  However, there is a line between "you
are using my code" and "you had learnt something from my code".

	Patenting crosses that line - it puts restriction on the way one
could use the things he'd learnt from your code.  Yes, mere putting your
code under GPL doesn't stop somebody from using the results of your efforts
in the ways you don't approve - he still can learn from your work and use
what he'd learnt in a work of his own.  Yes, I can see the attraction of
prohibiting that.  Just as I can see the attraction of bribery that had
created DMCA - with fairly close motivations behind it.

	Both DMCA and software patents may be legal, but that doesn't make
use of either of them morally acceptable from my point of view.  YMMV.  It's
sad to see Ingo pulling that crap - I believe that he has reasons that sound
good to him, but... reasons don't make results smell any sweeter.

	I've heard an excuse for playing these games (not from Ingo, so I have
no idea whether it has any relation to this case).  It goes along the lines
"commercial companies are doing that anyway and that poses a threat; having
patents of our own gives ammo for defence against that threat".  That sounds
nice, but...  there's an old saying - "don't play games with the devil".  It's
not that you can't win - devil is a piss-poor player.  But those who do win
tend to find the rules suddenly changed under them.  And then there are
bystanders caught in crossfire...

