Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287865AbSAIRA0>; Wed, 9 Jan 2002 12:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287866AbSAIRAV>; Wed, 9 Jan 2002 12:00:21 -0500
Received: from borg.org ([208.218.135.231]:26378 "HELO borg.org")
	by vger.kernel.org with SMTP id <S287865AbSAIQ7B>;
	Wed, 9 Jan 2002 11:59:01 -0500
Date: Wed, 9 Jan 2002 11:58:59 -0500
From: Kent Borg <kentborg@borg.org>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
        John Alvord <jalvo@mbay.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020109115859.C4902@borg.org>
In-Reply-To: <20020108173254.B9318@asooo.flowerfire.com> <E16O6KE-00087x-00@the-village.bc.nu> <1i3n3uct8fbh075ce99611tocgoe60oeqa@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1i3n3uct8fbh075ce99611tocgoe60oeqa@4ax.com>; from jalvo@mbay.net on Tue, Jan 08, 2002 at 04:29:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 04:29:59PM -0800, John Alvord wrote:
> Incidently human visual perception runs around 200 milliseconds
> minimum and hearing/touch perception around 100 milliseconds if the
> signal has to go through the brain. Of course we extend our
> perceptions with tools/programs etc.

Cool!  That means movies don't need to run faster than 5
frames/second.  Maybe 10 frames/second for plenty of overkill.  No
need to look at keyboard and mice any more frequently either, what a
relief.  (Any why do silly gamers want to go so much higher?)

Sarcasm mode "off" now...just because some experiments show it takes
humans a long time to push the correct button when you show them a
picture of a banana doesn't mean there is no reason to have a user
interface do anything any faster.  (I can come up with plenty of
examples if you would like.)


OK, now that I have pissed off a big hunk of the folks on the list,
let me bring up a different question: 

How does all this fit into doing a tick-less kernel?

There is something appealing about doing stuff only when there is
stuff to do, like: respond to input, handle some device that becomes
ready, or let another process run for a while.  Didn't IBM do some
nice work on this for Linux?  (*Was* it nice work?)  I was under the
impression that the current kernel isn't that far from being tickless.

A tickless kernel would be wonderful for battery powered devices that
could literally shut off when there be nothing to do, and it seems it
would (trivially?) help performance on high end power hogs too.

Why do we have regular HZ ticks?  (Other than I think I remember Linus
saying that he likes them.)  


Thanks,

-kb, the Kent who knows more about user interfaces than he does
preemption.
