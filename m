Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263981AbTDJBgQ (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 21:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263982AbTDJBgQ (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 21:36:16 -0400
Received: from mail.casabyte.com ([209.63.254.226]:40455 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S263981AbTDJBgI (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 21:36:08 -0400
From: "Robert White" <rwhite@casabyte.com>
To: <linux-kernel@vger.kernel.org>
Subject: The myth of the "sustainable closed software product" [WAS: BitBucket: GPL-ed KitBeeper clone]
Date: Wed, 9 Apr 2003 18:47:47 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGGEOICGAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Pre-Script: if this looks wrong to you, blame freaking outlook 8-)

-----Original Message-----
From: Larry McVoy [mailto:lm@bitmover.com]
Sent: Tuesday, April 08, 2003 7:17 PM
Subject: Re: BitBucket: GPL-ed KitBeeper clone

> I agree.  If you give it away, they'll copy it.
>
> The sad part is that that means it is impossible to give.  Solve that
> problem and you'll have my respect.

(With respect to various closed and open source business models)

Ah, but you are still stuck.  Even after the give or not give, the fact that
someone somewhere interacts with the code means that your ideas are out
there and subject to mimicry.

This makes the process very like thermodynamics.  You can't win, you can't
break even, and you can't get out of the game.

The way we win is by forgetting the ever-so-slightly negative-sum game and
concentrating on reaping the benefit of the concentrated parts of the system
while letting the larger part of the system mind its own business and
amortize the loss.

In the case of the software the model just confuses the average businessman,
in the same way that "hole current" in semiconductors can confuse someone
who only knows basic electronics.

Real World Case:

OSI Inc. had a product "NetExpert".  This horses-ass product was absolutely
*THE WORST* piece of software it was ever my displeasure to encounter.  It
was basically a big interpreter of a custom "rules" language that didn't
actually use rule semantics.  Their big claim was that you didn't have to be
a programmer to program their system (because the editor wouldn't allow you
to make a syntactical error... 8-)  The way this product sucks is legion and
I can literally rant for hours about how suckey it is.

How bad were their products?

This product was so bad, its core component (the "ideas" engine) was 19 meg,
linked to both the static and dynamic C libraries, and compiled with
optimization turned off and debugging symbols included so that you could
send them core dumps every week when it crashed.

They tried to sell some customers, through the company I worked for, an add
on that would let their rule results show on another computer running HP
OpenView.  Against the real customer's (DISA actually) data set this add on
took more than 14 minutes to initialize.  My boss asked me and one other
programmer to see what we could do about offering a contract product add-on
made in house to do the same thing.  Kind of a proof of concept thing.  A
week later I had a fully running product that out performed the $40,000 one
on every feature and loaded the data set in 2.83 SECONDS.  (We never "sold
the government" on using our product since they had already paid my salary
to create it, we wouldn't have made any money trying to get them to pay for
us to "invent it" after the fact... Talk about waste, fraud, and abuse...
but that's a side-story. 8-)

But OSI had customers.
Customers who had paid ~$250,000(USD) to start with the product and
~$40,000(USD), Customers who could not afford to switch away because they
were locked in.

Every 18 months or so this company would make, and sell, a new release that
*all* of their customers had to buy.  So every two years or so they would
have an income in the $22-million-USD range.

They *STILL* couldn't remain profitable over time because by the time of
each next release they had hemorrhaged away all their earnings in support
cost.

(Okay so that was two examples if you count the government thing. 8-)

The fundamental problem is that the whole "bring product to market" model of
doing business is unsustainable with respect to any business where that
product is just software.

See, OSI could afford to roll out their original product, but they couldn't
sustain it over the long term.  Software is divergent.  Ideas refine over
time.  They have to.  OSI could make their initial product, and they got
quite large, but they reached the critical mass and imploded.  Each time
they added a high-end customer they spread themselves thinner.  Each time
they reved their product they *had* to re-sell it to every previous customer
and some didn't want to go.  There was no support policy pricing schedule
that could possibly cover the expense and still be affordable to the
customers, let alone encourage those customers to buy the next revision.

===

One segment of the software industry that has fully realized this are (is?)
the game producers.  Games are dispose-ware.  A game comes out, you patch it
a few times, you hope it will pay out for a while, but if it hasn't made all
its expenses back in six months it likely never will.  Most games come out
with anti-piracy CDs (CD must be in the drive etc) and about six months
later there is an official "leak" of the hack that removes the restrictions.
This happens when the game, the IDEA of the game, has become commodity.
After that the game starts getting bundled with things and showing up on the
$5 shelf.  If the game producer is lucky he may spawn a franchise (see
"Unreal").

But if the game producer is *SMART* he puts out a level editor and a
mod-it-yourself API.  That is the only way the idea-set for his basic
product can keep up.

Once the engine is opened up, if it didn't suck, the game core (engine) and
community just keep it going.  Some significant fraction of the user base
takes up the entropy-cost of keeping the product alive.  The game publisher
keeps selling the $5.00 (ok, $9.95 8-) disks that cost him $0.35 cents and
the sustainable profit created by the publicly morphing game will see him
into the next cycle on the "new" game.

===

The entire DOT_Bomb happened because people "kind of got the idea" for the
first time that you *CAN'T* sustain a product past a certain point, but that
a good product can sustain itself across a user base.  The thing was, having
recognized that the positive-sum sub-system *WASN'T* related to trying to
sustain an idea,  unfortunately most companies never managed to find where
that positive-sum sub-system was.  They just said nonsensical things like
"we will make this great program that does this great thing, toss it out
onto the web, and make a fortune."

Well, duh, of course that was going to fail.

===

The way Red Hat managed to make a profitable business out of selling Linux
comes from the fact that they know that the "sale" isn't sustainable.  Linux
can't be sustained _commercially_, but the promise "if you pay us money, we
will do everything we can to make your life better (with this Linux thingy)"
*IS* sustainable once you achieve an economy of scale."

Linux (kernel, plus countless software tidbits and packages, I am speaking
of the phenomena here) sustains itself, in the person of all of us weasels
out here who are willing to nudge it.  It's like pushing a car around the
world, nobody can do that themselves and no small group would plan to as a
profitable venture, but if you just keep getting help from random folks...
Meaning, there are a bunch of us who use it, all for different reasons.  A
few people want to tinker, most needs what it already does *PLUS* "just one
more thing."  It is a huge self-sustaining thing built entirely out of
"small wish".  Some few people steer specific parts (e.g. kernel people
here, gcc project people there) along so that it doesn't just splatter
everywhere, but most of the fine-grain stuff that give it its continuous
smoothness filters in from tiny bits of effort done by diverse groups of
people.

So Red Hat (etc.) sees the large number of people carrying one glass full of
water up the mountain each, and builds itself a water-wheel along the most
likely path of sustainable runoff.  That being people who *want* to play but
need help, or need that first disk, or don't want to have to help
themselves.

===

But this cycles us back to the question of who is cloning whom and who
disserves what.

Quite frankly, if you are selling one idea, and it is out here six months
gone, if you haven't diversified by now, you are playing in a shallow well.
(love to mix them metaphors. 8-)

Anybody who has used your software knows how it works (As far as they are
concerned) and what they wish it did better.  You have chosen not to harvest
that expertise by keeping the original source closed.  You have likewise
chosen not to use the "Monkey See Monkey Do" effect to any of your own
benefit.  That is the closed source condition.  It will play, but not for
long without an enforced audience.  If you don't have a completely new
product in the pipeline, or a "buyer" already lined up to buy the company,
you are probably already falling behind your power curve.

You can flatten the power curve if you can get a nice juicy patent, but
didn't someone just patent version control a few weeks ago (search
slashdot.org if you didn't see it 8-). so you are probably already violating
someone else's patent.  So what if you did it first, they snatched up the
stick first, and in the thread game that is all that matters.  That is the
"material product" model thrashing around and soiling itself in your
swimming pool... 8-)

If you already "gave away" some of the code you are well and truly screwed.
You played through but didn't' set yourself up to harvest the result.

===

Actually, "harvest" is the *perfect* word.  You have to sow to harvest and
all that.

===

With respect to intellectual property law in general.  That pig won't hunt,
and soon everybody will know it.  This is directly analogous to what
happened with the airplane.  Originally, "flying" was, by law "inherently
dangerous" and so anybody who wanted to sue you for anything, if they could
prove that your-flying-some-airplane was involved, were guaranteed to win
and make you pay.

One day a man tried to sue another man for crashing his plane into something
(a barn I think) and frightening some animals.  He went to court and said,
he flew, he meant to fly, flying is inherently dangerous, give me money.

The court ruled that while the man intended to fly, he didn't intend to
crash, and since the crash was unintentional the damages weren't automatic.

And on that day, flying was instantly transformed from a dangerous stunt to
a viable business.

The patenting of software needs must fall in a similar way.  Then we will be
back to copyright which doesn't usefully attempt to protect someone from
(general) mimicry.  On that day there will be much rejoicing, and
pay-to-create general purpose software will take a header into the pool.

===

If you disagree, consider each of the following:

What did IBM  originally sell?  (service. originally you COULDN'T by an IBM
card sorter or mainframe to save your life, you bought hours on their
hardware that you also paid to power and house and insure their hardware,
talk about a scam... 8-)
What does IBM mostly sell now?  (services.)

Why does Microsoft fight to keep OEMs from shipping other OS(es)?
Why does Microsoft sell Mice, Keyboards, Joysticks, Hubs and so forth?

Why do game manufacturers have to turn out new titles as fast as clothing
designers turn out new lines?

Why did companies like PeachTree fail, or sell themselves to larger concerns
and then fail?

Why are companies like HP falling victim to merger?  (because they innovate
"fast enough" to be attractive in a must-evolve market place.)
Why do companies like HP suck after merger?  (because they have been
hoovered up by companies that don't understand the lifecycle of an Idea.  If
those companies *did* understand they wouldn't have had to buy and ruin
another company to have their own innovation.)

Why was Bell Labs so useful to AT&T when they gave away every technical
breakthrough they made?  (Because, having *invented* the transistor that
they needed, it was cheaper to let everyone know how to make it, and then
buy it cheap instead of trying to keep it to themselves and have to build
them in secret, at great expense, only to lose to someone who took one apart
and made it themselves.)

Why does the phrase "Planned Obsolescence" even exist?

===

The facts are simple, truly durable goods do not work in the traditional
economic model.  A car that lasted forever (or even for just one human
lifetime) with no need for maintenance would have been a DISASTER.  Same for
a washing machine or any other product.  Our "durable goods" are only "not
as consumable" as most other things.

You can only make money sustainable if your product is consumed by/during
use.  The "Candy bar" is the ultimate product because most people want it,
and when they have it, they use it up and want it again later.  There is no
"used candy bar market".  Each bar is a fresh sale.

Real "durable goods" last about what, eight years on average?

Unfortunately IDEAS are absolutely and perfectly durable, and once
manufactured, they are self distributing.  There is NO WAY to play the
product game and win (long term.)  The more lawyers and leverages you can
muster the longer you can rest on a piece of thought, but it isn't the smart
way to bet.

Just as there are no Rockefellers (sp?) today, there will never be another
Microsoft without a completely new hard technology.  The railroad barons
were possible only at the advent of long-haul direct transit.  The
pseudo-railroad barons, in the person of the airlines, didn't ever achieve
the same standing because "airplane" is really only "faster, less
constrained train".  AT&T was created by the telegraph and sustained through
the phone, their new hard-technology was "long distance communication."  IBM
was created by the "business machine" (circa card punch) and is sustained by
the business machine service need.  Microsoft was created by the "small
computer" but is really starting to die on the PDA/Cell phone vine because
they couldn't force their way into the "instant persistent information
transfer" technology.

In fact, we are in a lull here because "broadband" and "the internet" isn't
a new technology in the sense that a "train" was.  By the time "the
internet" came into public consciousness it was already old tech.  People
had been doing the same thing with BBSes and Usenet and so forth for
decades.  "The internet" was also just faxing and phoning and such and so
while it seemed different, everybody who gets email eventually realizes its
just mail but a little faster.  It was evolutionary, and not that far an
evolutionary step at that.

Now that the mystery has worn off the idea of software, creating it will
never really be a sustainable business proposition.  Software is just the
structured expression of ideas and biologically we are each incapable of
"learning absolutely nothing" when we are exposed to them/it.  Even the
games sell because the particulars of each new first-person shooter's set or
weapon is prettier or more realistic.  That's just a tired arms race in
fashion designer clothing.

===

My conclusions?

1) Nobody will never make "big money" selling proprietary software again.
The rest of the world can pick over and recycle their ideas too quickly.
You literally can't hire enough people to do the necessary thinking and
still pay them from the possible (let alone expected) proceeds.

2) Item one can only be superceded by a captive audience (like government
contracting, patent bullies, etc.)

3) No one piece/lineage of software can expect to be sustainable over the
long run unless it either directly controls someone's money or it operates
in a legally constrained arena.  (finance, government, patent etc.)

4) The Intellectual property stuck-pig (wrt/software and patents) will
continue to struggle and bleed in our pool until we are all quite wet and
bloody, but it will end up either bleeding to death or drowning.
Eventually, once every party involved decides to just say "go ahead and
sue," the courts will decide the cases aren't useful and they will cease to
hear them.

5) It isn't that "information wants to be free" or whatever, each persons
brain is *STARVING* for the new and interesting.  We can't help but feed at
the trough, and you cant stop a brain from functioning the way it will
without, say, crushing it with a hammer.

6) Complaints that it isn't fair when people mimic your ideas are specious
and unrealistic.

7) if you don't appreciate all of this, get in, suck out your money, and get
out damn fast, everyone will laugh at you or commiserate with your loss
(depending on their individual personalities) but after the blood settles
they will all, in their secret hearts, think "I told you so..."

Rob.


