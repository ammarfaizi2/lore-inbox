Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbVLLOp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbVLLOp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 09:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVLLOp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 09:45:58 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:7432
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1751089AbVLLOp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 09:45:57 -0500
Date: Mon, 12 Dec 2005 15:45:45 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051212144545.GN3092@opteron.random>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01EE9BB3@otce2k03.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F01EE9BB3@otce2k03.adaptec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 04:06:44PM -0500, Salyzyn, Mark wrote:
> Don't you mean 'leaving it political', kernel.org is hardly neutral.
> Neutrality is usually handled by a single trusted entity such as a Judge
> ;-/ and not by a committee or a democracy.

;)

kernel.org is better than a dot com website, that's what I meant by
neutral.

> This issue is hardly black-and-white. The Hardware Vendors are hardly
> monolithic. Markets are not always just horizontal, or just vertical.
> 
> For instance, there are reasons, somewhat outside the control of the
> Hardware Vendor, for binary drivers. Often, in the hopes of achieving
> standards compliance, Hardware vendors are cornered by legalities over
> the copyright associated with those standards that ties their hands
> either from releasing interface documentation or from releasing source
> code. Yet all these vendors would be overjoyed to have Linux drivers for
> their Hardware in order to increase the sales of their products.

A standard that ties the hands and requires not releasing the source
should be obsoleted by a new one that is based on open information and
open source.

I understand the tainting problem, but for the future you really should
create a new standard whose objective is "interoperability" and not
to tie hands.

Note that even as programmers it's very easy to be tainted, and it
requires skills to avoid it. Companies have the same problem, if they
accept the tainting they may have to pay for the conseguences eventually
(i.e. presumably lower sale of their products).

So if something this should be a lesson to remind.

Binary only drivers in such a tainting legal condition sounds reasonable
for the current generation of hardware (accepting the perhaps
unavoidable lower sales), but for new hardware you must find a way out
of it. Found a new standard body, ask your competitors to join it and
see what is their reaction, create sane legalities (like NDA with
expiration after which GPL source can be released) or similar better
choices.

If you did a mistake it's not me who has the duty to help resolving it.
I can only suggest you not to do the same mistake again and again, while
the "standard that ties the hands" is banking on it.

> The users are overjoyed when they have a wide variety of useful hardware
> products to select. The market is overjoyed when there is competition.
> 
> Linux gains popularity when the users are placated, increasing the
> interest in funding projects, engineers and organizations associated
> with Linux. Call this trickle down economics if you want.

Sure.

> Locking out the Hardware is counterproductive for all to varying degrees
> (I agree that locking out the details is also counterproductive, do not
> misconstrue my argument). The current state of affairs where binary-only
> drivers are grudgingly handled and politically sensitive offers the
> balance that urges these Hardware Vendors to pursue open source variants
> or to move initial binary-only offerings eventually in the future
> towards an open-source solution when conditions change to permit it.
> Thus without hurting the OS, the users or the Hardware vendors; with the
> timely delivery of advanced hardware. Without an open door, that piece
> of hardware, or the market window, will pass Linux by. Despise the
> results, by all means. Plan to protect copyrights that binaries may
> violate, that is a noble duty. Remain forever vigilant against
> encroachment. But please stop planning a revolt, locking the door,
> constructing conspiracy theories or creating scenarios of utter
> destruction and mayhem.

Even today you can check when a driver has an open source driver. I do,
it takes time, sometime I have to annoy to the developers to be sure I
read the pciids correctly. If there was a way to find it more easily it
would be helpful and hopefully it will allow more people to choose
hardware with open source drivers.

I don't agree with the revolt of breaking all drivers and I think
reversing that patch was the right thing to do (because doing so all
users would suffer), I only want your revenue to shrink over time
in order to give a business reason to care about open source drivers.
Technical reasons are always secondary to business reasons.

> Sleep with the enemy when you have mutual gain (keep a loaded gun under
> the pillow to keep him honest ;-> ).

;)
