Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265272AbSJaS1D>; Thu, 31 Oct 2002 13:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265289AbSJaS1D>; Thu, 31 Oct 2002 13:27:03 -0500
Received: from otter.mbay.net ([206.55.237.2]:39695 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S265272AbSJaS0E> convert rfc822-to-8bit;
	Thu, 31 Oct 2002 13:26:04 -0500
From: John Alvord <jalvo@mbay.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
Date: Thu, 31 Oct 2002 10:31:59 -0800
Message-ID: <77t2suc7q7dtjvnm7p44d43mribai1d23i@4ax.com>
References: <Pine.LNX.4.44.0210310941310.20412-100000@nakedeye.aparity.com> <Pine.LNX.4.44.0210310951180.1410-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0210310951180.1410-100000@penguin.transmeta.com>
X-Mailer: Forte Agent 1.92/32.570
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002 09:54:54 -0800 (PST), Linus Torvalds
<torvalds@transmeta.com> wrote:


>Guys, why do you even bother trying to convince me? If you are right, you 
>will be able to convince other people, and that's the whole point of open 
>source.
>
>Being "vendor-driven" is _not_ a bad thing. It only means that _I_ am not
>personally convinced. I'm only one person.

It sounds to me like there needs to be L-K traffic when problems are
solved using LKCD.

Personally I love crash dumps... in 33 years of computing I have spent
a total of 1-2 years doing nothing but enhancing and developing
post-processing facilities. The true benefit is not just the "crashed
here, add a null check nonsense". It is the ability to examine the
whole system state. With an inboard trace table, you can even go back
in time. You can look at call stacks, locks held, state of allocated
memory, etc etc. If you save callstacks and time with allocated
memory, you can track down storage growth problems. I have spent weeks
winkling problems out of crash dumps, solving problems the developers
didn't even know existed.

With the right facility you can take crash dump snapshots and keep on
running. It is a great tool for understanding a system.

But until there is a flow of results - good quality fixes - resulting
from such analysis, I can see exactly why LT is doubtful. 

john alvord
