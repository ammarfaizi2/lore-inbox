Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143451AbRA1QQn>; Sun, 28 Jan 2001 11:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143436AbRA1QQd>; Sun, 28 Jan 2001 11:16:33 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:60597 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S143435AbRA1QQ0>;
	Sun, 28 Jan 2001 11:16:26 -0500
Date: Sun, 28 Jan 2001 11:15:24 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: James Sutherland <jas88@cam.ac.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <Pine.SOL.4.21.0101281324210.26837-100000@yellow.csi.cam.ac.uk>
Message-ID: <Pine.GSO.4.30.0101281039440.24762-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jan 2001, James Sutherland wrote:

> On Sun, 28 Jan 2001, jamal wrote:
> > There were people who made the suggestion that TCP should retry after a
> > RST because it "might be an anti-ECN path"
>
> That depends what you mean by "retry"; I wanted the ability to attempt a
> non-ECN connection. i.e. if I'm a mailserver, and try connecting to one of
> Hotmail's MX hosts with ECN, I'll get RST every time. I would like to be
> able to retry with ECN disabled for that connection.
>

We are allowing two rules to be broken, one is RFC 793 which
clearly and unambigously defines what a RST means. the second is
the firewall or IDS box which clearly is in violation.
The simplest thing in this chaos is to fix the firewall because it is in
violation to begin with.
I think it is silly to try to be "robust against RSTs" because of ECN.
What if the RST was genuine?

I see that we mostly have philosphical differences. You'd rather adapt
to the criminal and most people would rather have the criminal adjust to
society.

I think CISCO have been very good in responding fast. I blame the site
owners who dont want to go beyond their 9-5 job and upgrade their boxes.
In the old internet where only hackers were qualified for such jobs, the
upgrade would have happened by now at hotmail. I suppose it's part of
growing pains.
If you think the CISCOs were bad sending RSTs, i am sure you havent heard
about the Raptor firewalls. They dont even bother to send you anything if
you have ECN enabled ;-> Simply swallow your SYNs.
So tell me, what do you propose we deal with these? Do we further
disambiguate or assume the packet was lost?
I actually bothered calling Raptor, they chose to ignore me.

You should never ASSume anything about something that is "reserved".
I posted the definition from the collegiate dictionary, but i am sure most
dictionaries would give the same definition.

It's too bad we end up defining protocols using English. We should use
mathematical equations to remove any ambiguity ;->

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
