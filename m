Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129235AbRA1Rj7>; Sun, 28 Jan 2001 12:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135459AbRA1Rjt>; Sun, 28 Jan 2001 12:39:49 -0500
Received: from 13dyn128.delft.casema.net ([212.64.76.128]:45837 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129235AbRA1Rjj>; Sun, 28 Jan 2001 12:39:39 -0500
Message-Id: <200101281739.SAA05979@cave.bitwizard.nl>
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <Pine.GSO.4.30.0101280700580.24762-100000@shell.cyberus.ca> from
 jamal at "Jan 28, 2001 07:18:54 am"
To: jamal <hadi@cyberus.ca>
Date: Sun, 28 Jan 2001 18:39:32 +0100 (MET)
CC: James Sutherland <jas88@cam.ac.uk>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> > Yes,
> > those firewalls should be updated to allow ECN-enabled packets
> > through. However, to break connectivity to such sites deliberately just
> > because they are not supporting an *experimental* extension to the current
> > protocols is rather silly.
> >
> 
> This is the way it's done with all protocols. or i should say the way it
> used to be done. How do you expect ECN to be deployed otherwise?

Thinking about this a bit more:

A sufficiently paranoid firewall should block requests that he doesn't
fully understand. ECN was in this category, so old firewalls are
"right" to block these. (Sending an 'RST' is not elegant. So be it.)

However, ECN is now "understood", and operators are now in a position
to configure their firewall to "do the right thing". This is
subjective.  If the firewall operator is sufficiently paranoid, they
can say: "We don't trust the ECN implementation on our hosts behind
the firewall, so we want to disable it.". Firewall operators make
"lose connectivity to certain hosts/ports" decisions all the time.
That's what a firewall is about.

So... I think that the hotmail operators (or was it somewhere else
that started this debate?) simply get to chose. Lose connectivity to
part of the world because they block ECN or not.

But let it be known that it is THEIR decision. 


- If you implement a standard badly, you can get to be inoperable if
the standard gets expanded. That's what's happening here. Happens all
the time. 

- Note that Dave politely waited with announcing the impending
"cutoff" until he verified for sure that they did have a CHOICE.  

- The users (/customers) have gotten two weeks to bother the operators
into action, and the operators then have two weeks left to schedule
the upgrade. That seems pretty fair and resonable to me. 


			Roger.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
