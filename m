Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132046AbRDAIHY>; Sun, 1 Apr 2001 04:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132048AbRDAIHP>; Sun, 1 Apr 2001 04:07:15 -0400
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:60838 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S132046AbRDAIHC>; Sun, 1 Apr 2001 04:07:02 -0400
Reply-To: <torvalds@transmeta.com>
From: "Linus Torvalds" <torvalds@transmeta.com>
To: <linux-kernel@vger.kernel.org>
Subject: New directions for kernel development
Date: Sun, 1 Apr 2001 00:05:32 -0800
Message-ID: <BFECLKCMHDOFPPMBMMDKAEALCAAA.torvalds@transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	Recently, I've been thinking a lot about where Linux development should
head now that 2.4 is out.  Specifically, I've been thinking about how we
ought to make some cultural changes as well as technical changes.  Now I'm
not *entirely* sure what directions we should head in as we move towards
3.0, but I'd like to point out a few areas that need to be addressed as well
as propose some possible solutions.  Nothing is set in stone yet, but these
are definitely issues we need to work on.

	First off, I don't like a lot of the elitism that does on among Linux
hackers.  Just because you can tell what the following script does without
executing it, doesn't mean that you're some kind of god.

#! /usr/bin/perl
@k = unpack "a"x5,'x_,d@';@o = unpack "a"x19,'Q8>tUxLm\@`Y%N@cIq]';
while ($i<19){print chr((ord($o[$i])-ord($k[$i++%5])+91)%91+32);}

	Learning to hack Un*x is an impressive accomplishment, but it's closer kin
to solving a Rubik’s cube than scaling Everest.  If you think using Un*x
makes you some kind of super genius who should be feared by mere mortals and
end users, either get over it or start using *BSD.  *BSD users (and
developers) are all complete jackasses, so you'll fit right in.

	Secondly, I'd like to address the issue of cleanliness.  Quite frankly, the
standards of personal hygiene practiced by many members of this community
are simply unacceptable.  As you all know, I am a fairly clean cut,
well-kempt person (I know, I have a bit of a gut, but compared to Maddog,
Nick Petreley or ESR, I'm a modern Adonis.), and in the Linux community that
is something of an anomaly.  Virtually all users of Linux (and all other
forms of Un*x) are unkempt, longhaired, beast-bearded dirty GNU hippies, and
I am sick and tired of having to deal with them.

	The person I have the greatest problem with is that (in)famous communist
RMS.  Now, RMS may have been responsible for GNU, the GPL, GCC and many
other contributions to the computing community, but his stance, as well as
stench, displayed in his essays and actions, nauseates me.  I mean, with
that filth-ridden beard of his, where does he have room to demand that
people refer to Linux as GNU / Linux?  When he is as clean-shaven as I, he
may claim that right, but until then, he should go back to playing his
little flute and dropping acid like there’s no tomorrow.  Honestly, if he
doesn’t shut his mouth and go back to reading Marx, I’m going to shut it for
him.  I am sorry to sound so harsh, but a little hygiene every once in a
while is a Good Thing(TM).  Makes me wish I'd gone with a closed source
license back in the day.

	Next in line of dirty scuzz-balls I have to deal with, and probably the
worst thorn in my side, is Alan Cox, the primary coder of my kernel's TCP/IP
stack (ha, what a joke!) and all around dirty GNU hippy.  Alan views
toothpaste the same way a vampire views garlic.  The man's wife (who I spent
a few years with at the University of Helsinki) often calls me crying in the
middle of the night to complain of the rank, unbearable stench the man
exudes after sex.  On several occasions at trade shows, exhibitions and beer
bashes, I have nearly fainted from the torrent of rotten odor that pours
from every inch of his toxic person.  Along with the typical GNU hygiene
(mis)habits he practices, he also bitches and whines about... well,
everything.  He lies a lot too; evidence for this can be seen in the fact he
almost always wears cheap black sunglasses when talking to people he knows
are better than him (such as myself).

	And then we come to ESR. I won't reiterate the sewer-dweller like cleansing
habits he practices as well, but I would like to focus on his general
lifestyle.  I like to refer to ESR as AGB or “Arrogant Gas Baron.”  The man’
s flatulence is legendary.  I honestly believe that given a meal of refried
beans and a match, he could reach low earth orbit.  If you have to meet with
ESR for any reason, arrange for the meeting to be outdoors and try to stay
upwind.  And his flatulence isn’t limited to his posterior either.
Frequently it comes out his mouth or even out of his keyboard.  (Those of
you who have read “The Cathedral and the Bazaar” or “Meditations of Sudden
Wealth” will know exactly what I’m talking about here.)   Additionally, he
is a complete hillbilly.  You know, the kind that goes to inner-city
computer stores and buys 386s to set up as servers all over his house, with
cigarette smoke-stained 14" monitors piled high upon his kitchen table.  He
has neither grace nor charm and can't last 15 seconds in conversation with
educated company without drifting into a tirade on gun rights or the best
methods for tanning road kill.  Couple the above facts with his ruddy
complexion (from drinking Jagermeister like it’s water) and his
child-molester mustache and you’ve got the makings of one more person who
pisses me off.

Well, that's it for now. Hopefully with these feelings off my chest and into
the Open Source community, things will change for the better. I'd like just
once to talk to a Linux user or advocate who washes and changes their
clothes at least weekly. Until then, I will be rejecting patches from anyone
whose grooming standards do not measure up.

Also, I have submitted this to slashdot with the title "A Proposed Remedy
Involving Lingering Fud and Organizational Objections to Linux Systems."  Be
on the lookout for it.

Thank you,
--Linus Torvalds

