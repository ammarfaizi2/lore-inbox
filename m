Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbRA1MUQ>; Sun, 28 Jan 2001 07:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137015AbRA1MUG>; Sun, 28 Jan 2001 07:20:06 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:54709 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S129729AbRA1MTz>;
	Sun, 28 Jan 2001 07:19:55 -0500
Date: Sun, 28 Jan 2001 07:18:54 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: James Sutherland <jas88@cam.ac.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <Pine.SOL.4.21.0101280852470.14226-100000@green.csi.cam.ac.uk>
Message-ID: <Pine.GSO.4.30.0101280700580.24762-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jan 2001, James Sutherland wrote:

> I'm sure we all know what the IETF is, and where ECN came from. I haven't
> seen anyone suggesting ignoring RST, either: DM just imagined that,
> AFAICS.

The email was not necessarily intended for you. You just pulled the pin.
There were people who made the suggestion that TCP should retry after a
RST because it "might be an anti-ECN path"

>
> The one point I would like to make, though, is that firewalls are NOT
> "brain-damaged" for blocking ECN: according to the RFCs governing
> firewalls, and the logic behind their design, blocking packets in an
> unknown format (i.e. with reserved bits set) is perfectly legitimate.

I dont agree that unknown format == reserved. I think it is bad design to
assume that. You may be forgiven if you provide the operator
opportunities to reset your assumptions via a config option.
It has nothing to do with a paranoia setting, just a bad design. Nothing
legit about that.

> Yes,
> those firewalls should be updated to allow ECN-enabled packets
> through. However, to break connectivity to such sites deliberately just
> because they are not supporting an *experimental* extension to the current
> protocols is rather silly.
>

This is the way it's done with all protocols. or i should say the way it
used to be done. How do you expect ECN to be deployed otherwise?
The internet is a form of organized chaos, sometimes you gotta make
these type of decisions to get things done. Imagine the joy _most_
people would get flogging all firewall admins who block all ICMP.
There is nothing silly with the decision, davem is simply a modern day
internet hero.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
