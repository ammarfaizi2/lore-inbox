Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276411AbRI2CGJ>; Fri, 28 Sep 2001 22:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276415AbRI2CGA>; Fri, 28 Sep 2001 22:06:00 -0400
Received: from norwich.jmjones.com ([216.238.56.67]:55558 "EHLO
	mail.jmjones.com") by vger.kernel.org with ESMTP id <S276411AbRI2CFn>;
	Fri, 28 Sep 2001 22:05:43 -0400
Date: Fri, 28 Sep 2001 22:05:25 -0400 (EDT)
From: jmjones@jmjones.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, crispin@wirex.com,
        linux-security-module@wirex.com
Subject: Re: Binary only module overview
In-Reply-To: <E15n6Su-0000E0-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1010928213737.2854A-100000@dixie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It has been implied that I am not being "politically correct" on this
list.  Yeah, I know.  That's only one realm of the many ways to be
correct.  Read on...

--------

I have been reading everything I can access about GPL in the last few 
days, and, while I'm no snake[1], it seems to me that everything Greg's
additional "restriction" adds is probably already covered in the GPL.
It also seems to my somewhat-logical-but-not-legal-mind that Linus MAY
be stretching the GPL if he explicitly allows binary modules.

However, the way I understand copyright laws (admittedly "vague"): it is up
to the copyright holder to defend his product, not anybody else.  If Linus,
or anybody else, wants to say "okay, I won't file suit against people who 
abuse me in this manner ... XYZ", that's his/her right.  It's less
restrictive, and (it would seem) compatable to GPL, IMHO.  No government
agency is going to SWOOP in and challenge his right to "fail to prosecute."

The way this percolates down, in my mind, is that GPL is a pretty darn
good document.  If LSM just GPLs it's code, it can still decide (imho), in
the ultimate event, to pursue any violations of its licensing.  How the
courts may act on the "legacy" of the licensor above... is up to the
court. 

I think it's perfectly acceptable to implement any *legal-technical* means
to hide your interface that you choose (data isn't covered by GPL, can
somebody create a data-based key that stops GPL'd code from working? 
Um...  maaaaybeeee (^_^).  Is a module "code" or "data"?  maaaaaaaaaaaybe)
I also think, from my reading, that you are violating the GPL if you add
other "special restrictions." 

Suppose I add "You cannot copy or distribute this portion of the source to
anybody for any reason." to the license?  Would that be legal?  Strictly
NOT is my reading.  It's restrictive and, therefore, not "compatible." The
proposed few lines MAY someday be interpretted as such.  *BANG*, you're on
legal-quicksand.

Greg (et al), I have great respect for your opinion... but you just may be
breaking GPL by adding a "further restriction."  If you're not adding a
"further restriction", leave it out... it's already there.  If some court
somewhere finds that this is not part of the GPL restriction, you break from
GPL and ... well, then it's anybody's game.

Get out your pencil, draw the logic diagram... you're making a logical
mistake.

Um, and logic and law are not necessarily compatible. :)

Trust GPL,
J. Melvin Jones

P.S. -- I've got an interface for similar purposes spec'd and partly
written.  It is NOT efficient at doing what LSM does, but IS more flexible
and allows more things to be done (stipulation).  For certain purposes
(mine), it may actually be faster, but IN GENERAL, the special case I'm
addressing is NOT similar to LSM.  It might be better for my and some other
solutions.  Majority solutions?  Who knows?  Admittedly, I now see problems
with implementation that were cited before when some of my ideas were
"trampled."  I'm tackling them, not dismissing them.

No worries, I don't have even the REMOTEST desire to be included in the
Kernel... I just want something that works and enhances Linux Security.

That being said, I have been advised and believe that I will HAVE to GPL
the kernel-side patches, the code, and everything "south" of the API, and
gladly will so do.  I will also release (least-restrictively-as-possible)
any parts necessary to connect to my MPI (module programming interface.) 
Anything on the OUTSIDE of my interface belongs to whomever created it
IMHO.  Let the court decide how Linus' and anybody else's interest should
be protected, IF they sue... (and, I think I'm doing the RIGHT thing, so I
sleep at night and don't worry) ... so be it.  If they can build a better
mousetrap...  hey, KEWL!!!! 

Is this a political thing instead of a technical thing?  I think it may
be, at least for Greg (et al.)  Make Linux better and you can sleep at
night.  Don't let somebody make it worse: you are honorable.  But where
does LSM fit into that?  I'd like to see it make things better, AND open
to non-open solutions for making it better.  GPL gives you,
imh-nonlegal-opinion, the full right to band the Copyright holders
together to pursue "legal recoarse" to fight abuse.  REAL ABUSE, not just
some political ideal. 

If you can't sleep at night because somebody else can use your code for
purposes OTHER than you envisioned... you shouldn't be writing Open
Software.  Isn't that the real purpose... to let the next guy stand on
your shoulders?


--------

[1] SNAKE -- the best sort of thing to hire when your garden is full of 
    rats.  A "SNAKE" is a REPTILE, a term which is also euphemistically
used, by J. Melvin Jones, to describe Insurance Agents, CPA's, and any
other people who "bridge the gap between the logical, the ethical, and the
legal."  No disrespect intended, EVER.  Sometimes COLD BLOODEDNESS is a
very useful attribute for consultants to mammals.


|>------------------------------------------------------
||  J. MELVIN JONES            jmjones@jmjones.com 
|>------------------------------------------------------
||  Microcomputer Systems Consultant  
||  Software Developer
||  Web Site Design, Hosting, and Administration
||  Network and Systems Administration
|>------------------------------------------------------
||  http://www.jmjones.com/
|>------------------------------------------------------


