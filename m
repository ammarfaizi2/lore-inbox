Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143703AbRA1SIT>; Sun, 28 Jan 2001 13:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143675AbRA1SIK>; Sun, 28 Jan 2001 13:08:10 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:62901 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S143704AbRA1SIA>;
	Sun, 28 Jan 2001 13:08:00 -0500
Date: Sun, 28 Jan 2001 13:07:01 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: James Sutherland <jas88@cam.ac.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <Pine.SOL.4.21.0101281704430.16734-100000@green.csi.cam.ac.uk>
Message-ID: <Pine.GSO.4.30.0101281225520.24762-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jan 2001, James Sutherland wrote:

> On Sun, 28 Jan 2001, jamal wrote:
> > We are allowing two rules to be broken, one is RFC 793 which
> > clearly and unambigously defines what a RST means. the second is
>
> This is NOT being violated: the RST is honoured as normal.

You are interpreting RST to mean "it says RST but maybe it was not RST;
let me try again"
I dont think thats honoring it ;->
[Just like the anti-harassment campaign goes: What part of NO dont
you understand, is it the N or the O?]

>
> > the firewall or IDS box which clearly is in violation.
>
> Disagreed: it is complying with firewall RFCs, rejecting suspect
> packets. Sending an RST isn't a very bright way to do it, but that's
> irrelevant: it happens. Deal with it.

It is what some idiot designer thought it meant.
If the administrator configured it, that is complying with RFCs.

> > I see that we mostly have philosphical differences. You'd rather adapt
> > to the criminal and most people would rather have the criminal adjust to
> > society.
>
> There is no "criminal": no rules are being broken. Since it is
> "society" (or a tiny minority thereof) which has changed the rules, it is
> "society" which must adapt to be compatible with existing rules.
>

;-> We are on different extremes for sure. It is "society" which clearly
says now that if you misunderstood the rule and didnt pay attention to
the definition of "reserved", here's the definition. You understand it
better? good, please conform.
You are saying that "society" should now say ok, since you misunderstood
we'll make our lives a lot more miserable and just live with your
ignorance.

>
> I'd have said that's still true - only "hackers" are qualified. The
> problem is just that the staff doing (or attempting) the job aren't
> necessarily qualified to do it properly...

The internet is growing so fast and the shortage of people is affecting
it. Look at what happened to MS ;-> ;->

>
> > If you think the CISCOs were bad sending RSTs, i am sure you havent heard
> > about the Raptor firewalls. They dont even bother to send you anything if
> > you have ECN enabled ;-> Simply swallow your SYNs.
>
> That's regarded as a better response, actually: just drop suspect packets.
>

But then how do you "degrade" nicely from it? If you want Linux to be
able to degrade nicely, what do you do in this case?


> > So tell me, what do you propose we deal with these? Do we further
> > disambiguate or assume the packet was lost?
> > I actually bothered calling Raptor, they chose to ignore me.
>
> You mean they are still shipping a firewall which drops ECN
> packets? Hrm...
>

Yeah, as far as i know

> No, just use English properly. "Must be zero" doesn't actually mean "must
> be set to zero when sending, and ignored when receiving/processing", which
> is probably what the standard SHOULD have said.
>
> However, it's too late now: ECN-disabled routes exist. ECN implementations
> should degrade as well as possible when handling these circumstances.


I think this is the right moment for this to be fixed. Way before it is
too late.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
