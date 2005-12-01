Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbVLAQwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVLAQwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 11:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVLAQwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 11:52:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16653 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932324AbVLAQwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 11:52:00 -0500
Date: Thu, 1 Dec 2005 16:51:44 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: ray-gmail@madrabbit.org, Roman Zippel <zippel@linux-m68k.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       george@mvista.com, johnstul@us.ibm.com
Subject: Re: [patch 00/43] ktimer reworked
Message-ID: <20051201165144.GC31551@flint.arm.linux.org.uk>
Mail-Followup-To: ray-gmail@madrabbit.org,
	Roman Zippel <zippel@linux-m68k.org>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, mingo@elte.hu, george@mvista.com,
	johnstul@us.ibm.com
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512010118200.1609@scrub.home> <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com> <Pine.LNX.4.61.0512011352590.1609@scrub.home> <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 08:22:01AM -0800, Ray Lee wrote:
> On 12/1/05, Roman Zippel <zippel@linux-m68k.org> wrote:
> > The human language is a bit more complicated than this (at least English
> > and related languages). Depending on the context a word can have different
> > meanings, e.g. if you ask an athlete what "timeout" means, you'll get a
> > different answer than you would get from an engineer.
> 
> Actually, no you won't. The athlete will say "A timeout? Something out
> of the ordinary happened, and coach wants me to go to the sidelines to
> talk." Timeouts are unexpected and exceptional, whether you're an
> athlete or a piece of code. On the other hand, they have a timer that
> everyone *expects* to expire at the end of the quarter or game.
> 
> Ray, who is both an athlete and a native English speaker, who thinks
> the naming is the clearest of anything to come across this list in
> ages.

rmk, also a native English speaker, agrees with Ray, Thomas and Ingo.
As does dictionary.reference.com's definitions of timeout and timer:

 timeout

  A period of time after which an error condition is raised if some event
  has not occured. A common example is sending a message. If the receiver
  does not acknowledge the message within some preset timeout period, a
  transmission error is assumed to have occured.

 timer

  a timepiece that measures a time interval and signals its end

Hence, timers have the implication that they are _expected_ to expire.
Timeouts have the implication that their expiry is an exceptional
condition.

So can we stop rehashing this stupid discussion?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
