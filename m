Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278349AbRJMShG>; Sat, 13 Oct 2001 14:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278352AbRJMSg5>; Sat, 13 Oct 2001 14:36:57 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:27909 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S278349AbRJMSgx>; Sat, 13 Oct 2001 14:36:53 -0400
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Which is better at vm, and why? 2.2 or 2.4
Date: Sat, 13 Oct 2001 11:37:22 -0700
Message-ID: <HBEHIIBBKKNOBLMPKCBBCEOLDOAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20011013141709.L249@localhost>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Patrick
> McFarland
> Sent: Saturday, October 13, 2001 11:17 AM
> To: M. Edward Borasky
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Which is better at vm, and why? 2.2 or 2.4
>
>
> Hmm, I see that as very bad. There should be a bunch of sysctls
> to do that easily. Also, I heard that 2.4 (and I'm assuming 2.2
> as well) swaps pages on a last-used-age basis, instead of either
> a number-of-times-used or a hybrid of the two. That kinda seems
> stupid, especially if you get a bunch of apps running that just
> cycle thru pages, instead of the most used pages staying in
> memory, and the least used being swapped back and forth with
> about 2 or 3 megs of memory used to store the least used pages in memory

What do you see as bad? The ability to change tuning parameters on the fly
or the lack of such ability? At the very least, I need to be able to poke
settings with a debugger, and a more systematic and user-friendly interface
would be preferable.

Your example is exactly what I'm talking about! Neither the applications nor
the kernel are "stupid"; they are doing exactly what they're being paid to
do. My job as a system tuner is to make sure that the users get the response
times and throughputs they need, given the inherent limits of how much they
can afford to pay for processors, memory and disk. As an aside, I also need
to be able to figure out what those limits are -- when it's time to add
capacity rather than just tune the system.
--
M. Edward (Ed) Borasky, Chief Scientist, Borasky Research
http://www.borasky-research.net
mailto:znmeb@borasky-research.net
http://groups.yahoo.com/group/BoraskyResearchJournal

Q: How do you tell when a pineapple is ready to eat?
A: It picks up its knife and fork.

