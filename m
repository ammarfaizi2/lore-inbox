Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbTILSGi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTILSGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:06:37 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:25093 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261793AbTILSFa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:05:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bill Davidsen <davidsen@oddball.prodigy.com>
Reply-To: davidsen@tmr.com
To: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler policy v15
Date: Fri, 12 Sep 2003 14:05:02 -0400
User-Agent: KMail/1.4.1
References: <3F608807.9090705@cyberone.com.au>
In-Reply-To: <3F608807.9090705@cyberone.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200309121405.02327.davidsen@oddball.prodigy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 September 2003 10:34 am, Nick Piggin wrote:
> Hi,
> http://www.kerneltrap.org/~npiggin/v15/
>
> This was going to get high res timers, but instead fixed a bug that might
> be causing a few people oopses. Also very small interactivity tweaks.
>
> I'm starting to work on SMP and NUMA ideas now, so if any interactivity
> things are bothering you, please tell me soon. I should be getting access
> to a 32-way NUMA soon, so I'm sort of holding off chaning too much until
> then.
>
> Enjoy.

The only odd behaviour I see with v15 (and also with v10) is that X 
occasionally terminates when I unlock the screen. Haven't run pure test[45] 
enough to say for sure that it doesn't happen there. Load was setiathome, 
kernel make -j3, calculate PI to 20k places. System was responsive and 
pleasant to use before I locked it, when I came back X died, system was still 
stable.

RH 7.3 base, 2.6.0-test5+nick15, PII-350, 96MB, KDE

Next week I'll run pure test5 for a day and see what happens. I'll also get 
some actual numbers on responsiveness (I think). After stability test I'll 
run test5-mm1 (or latest) and look for the X oddity. So far Nick-v15 seems to 
do a better job than test5-mm1, I don't have a sound card the system will use 
at the moment.

-- 
Bill Davidsen
  machine name and IP do not reflect reality, stealth in progress
