Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319074AbSH1XTa>; Wed, 28 Aug 2002 19:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319076AbSH1XTa>; Wed, 28 Aug 2002 19:19:30 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:43512 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319074AbSH1XT2>; Wed, 28 Aug 2002 19:19:28 -0400
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dominik Brodowski <devel@brodo.de>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0208281327140.8978-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0208281327140.8978-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 29 Aug 2002 00:26:18 +0100
Message-Id: <1030577178.7190.85.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-28 at 21:29, Linus Torvalds wrote:
> It's ok to tell the kernel these "long-term" policies. But it has to be 
> told as a POLICY, not as a random number. Because I can show you a hundred 
> other cases where the user mode code does _not_have_a_clue_.

Right and for the one in one hundred that is does I need a policy that
suits it

> That's my argument. The kernel should be given a _policy_, not a "this 
> frequency". Because a frequency is provably not enough, and can be quite 
> hurtful.

One of the policies I need from the kernel is "run at the frequency I
told you to run". Its a policy, its not the general case policy. The
/proc file is that policy.

> And I do not want to get people used to passing in frequencies, when I can 
> absolutely _prove_ that it's the wrong thing for 99% of all uses.

99% of people should be using something like ACPI. 

cpufreq is cpu speed control not power management policy. I agree
entirely that most people should not be using echo "500" >/proc/... as a
power management policy. 

Likewise /dev/hda is not a file system and peopel should not be using dd
to store there files.

In both cases the ability to do so is sometimes useful and shouldnt be
excluded.




