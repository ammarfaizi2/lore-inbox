Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273098AbRIIXo4>; Sun, 9 Sep 2001 19:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273099AbRIIXoq>; Sun, 9 Sep 2001 19:44:46 -0400
Received: from femail35.sdc1.sfba.home.com ([24.254.60.25]:45820 "EHLO
	femail35.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S273098AbRIIXoe>; Sun, 9 Sep 2001 19:44:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: "J. Dow" <jdow@earthlink.net>, "Carsten Leonhardt" <leo@debian.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Athlon/K7-Opimisation problems
Date: Sun, 9 Sep 2001 16:44:12 -0700
X-Mailer: KMail [version 1.2]
In-Reply-To: <87g09w70o4.fsf@cymoril.oche.de> <01090915292502.00173@c779218-a> <066701c13981$b9e91830$1125a8c0@wednesday>
In-Reply-To: <066701c13981$b9e91830$1125a8c0@wednesday>
MIME-Version: 1.0
Message-Id: <01090916441200.00423@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 September 2001 03:49 pm, J. Dow wrote:
> From: "Nicholas Knight" <tegeran@home.com>
>
> > > What about the power supply. If it is at all marginal the power
> > > consumption boost going to 1.4G is likely a killer.
> >
> > Well, he didn't mention the amperage outputs, but he said 431W
> > Enermax, from what I hear Enermax PSU's are good.
> > I still have trouble dealing with the idea that the optimizations
> > cause power consumption like this, but then, I have trouble with my
> > own idea that it causes sufficient heat increase in the chipset that
> > soon after boot.
> >
> > Do most people that experience this problem also experience after a
> > cold-boot where the system had been off for at least 10-15 minutes?
> > And has ANYONE sucsesfully cured this problem by changing power
> > supplies?
>
> Don't forget that there are two regulators involved. First there is the
> primary power supply's regulator down to either 3.3 or 5 volts. Then
> there is the motherboard regulator down to the 1.7 volt range. If THAT
> one is not up to handling the required oompf during certain CPU loads
> that is a sure way to glitch the machine.

Now THAT I'll buy... It would certainly explain why some KT133A 
motherboards work and some don't, but the relation would be a little 
complex, the chipset might be exposing general problems with regulators 
used in motherboards.
Verifying this would require both extensive analysis of the motherboards 
and chipsets, and the regulators.
You'd also need to verify the manufacturing place, batch and time/date 
for at least 50 to 100 motherboards to begin verifying this.
