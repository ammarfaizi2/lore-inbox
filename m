Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUAAVsk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 16:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUAAVoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 16:44:44 -0500
Received: from h24-76-142-122.wp.shawcable.net ([24.76.142.122]:19974 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S265388AbUAAVoH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 16:44:07 -0500
Date: Thu, 1 Jan 2004 15:44:01 -0600 (CST)
From: Derek Foreman <manmower@signalmarketing.com>
X-X-Sender: manmower@uberdeity
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: best AMD motherboard for Linux
In-Reply-To: <3FF45307.7070508@inet6.fr>
Message-ID: <Pine.LNX.4.58.0401011516110.437@uberdeity>
References: <3FEF0AFD.4040109@yahoo.com> <20031228172008.GA9089@c0re.hysteria.sk>
 <3FEF0AFD.4040109@yahoo.com> <20031228174828.GF3386@DervishD>
 <20031229165620.GF30794@louise.pinerecords.com> <Pine.LNX.4.58.0312301144340.467@uberdeity>
 <20031230194203.GA8062@louise.pinerecords.com> <Pine.LNX.4.58.0312301354130.765@uberdeity>
 <20031231093929.GC8062@louise.pinerecords.com> <Pine.LNX.4.58.0312310914170.473@uberdeity>
 <3FF45307.7070508@inet6.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for cutting down on the CCs, this is getting out of hand.

On Thu, 1 Jan 2004, Lionel Bouton wrote:

> Linux isn't a closed-source system where binary APIs are frozen, so
> working best with a set of specific kernels (and I don't even say kernel
> versions, I *mean* kernels, just search for threads on nvidia with
> kernels built with some perfectly legit gcc flags) doesn't mean it is
> working best with Linux.

There are features available in both the ati and nvidia closed source
drivers that are not available in DRI.  If I want "full use" of my
hardware, then DRI is does not "work best" for me.

Regardless, I should not have used the word "political" in my response to
Tomas.

> What if Nvidia goes bankrupt in the future like 3DFX did, what do you do
> with your card ? throw it away ?

What would probably happen, as has happened with the aureal vortex, is
that someone would maintain the open source wrapper.  Possibly until
someone reverse engineered the driver (as happened with the aureal vortex)
- but I wouldn't hold my breath on that for something as complicated as a
graphics card.

> I type this e-mail on a Sony PCG-GRT785B laptop which happen to use a
> Geforce Go 420 chip. Until the 5328 nvidia driver, I couldn't even
> switch to a text console after starting X (search for this type of
> problems and you'll see that the laptop support is really lacking in
> their drivers). Even now software suspend is out of the question when
> the nvidia kernel module is loaded (even with X stopped). I was aware of
> the fact that I could encounter these problems when I purchased the
> laptop and was ready to use the OSS XFree driver without 3D support
> (unfortunately I found out that the ones shipped with RH9 don't work),
> so I assume them, but it's hardly what I'll call "working best"...

Is nvidia aware of this issue?  If you're forced to keep that laptop, it
might be worth your time to bring it up with them.

Better would be to return the laptop and follow Joel Jaeggli's advice
from earlier in this same thread, but unfortunately that's probably not an
option.

> There's nothing political in saying that binary drivers don't work best.
> In fact it assumes a minimum understanding of the technical aspects
> involved in a Linux kernel to understand *why* they can't work best...

The closed source modules "work best" for me, as some of the code I play
with uses vertex buffer objects.

I realize that tomorrow nvidia could drop linux support, next week someone
could discover that echo HI\ MOM > /dev/nvidiactl gives them a root shell.

But for my situation, these things are an acceptable trade for the added
toys.
