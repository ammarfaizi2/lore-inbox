Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263795AbREYQ1x>; Fri, 25 May 2001 12:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263796AbREYQ1n>; Fri, 25 May 2001 12:27:43 -0400
Received: from idiom.com ([216.240.32.1]:17162 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S263795AbREYQ1j>;
	Fri, 25 May 2001 12:27:39 -0400
Message-ID: <3B0E8696.5B1F304@namesys.com>
Date: Fri, 25 May 2001 09:21:42 -0700
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Andi Kleen <ak@suse.de>, Andreas Dilger <adilger@turbolinux.com>,
        monkeyiq <monkeyiq@users.sourceforge.net>,
        linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: Dying disk and filesystem choice.
In-Reply-To: <208080000.990796886@tiny>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> On Thursday, May 24, 2001 11:16:58 PM +0100 Alan Cox
> <alan@lxorguk.ukuu.org.uk> wrote:
> 
> >> IMHO we are not that deep into code freeze anymore. Freevxfs got added
> >> in linux-2.4.5-pre*, so I think that a patch that adds a useful feature
> >> like badblock support would be OK.
> >
> > FreeVxFS changes precisely nothing in the behaviour of any other fs - its
> > like adding a new driver.
> >
> > Updating Reiserfs requires a lot more care because it has the potential to
> > harm existing stable setups
> 
> This has been mostly covered, but just in case.  There are two different
> freezes, the kernel, and in reiserfs.  The reiserfs part isn't something
> Alan or Linus have imposed on us, we just wanted to limit the reiserfs
> changes as much as possible during the early kernel releases.
> 
> The end result is that some larger scale issues are unfixed (memory
> pressure from VM, lost files after a crash), but we have been able to focus
> on the critical hoses-my-files/crashes-my-box kinds of bugs.
> 
> -chris
No, our policy is strictly in sync with and reflective of that of the rest of
the linux-kernel.  Since the ac series has a different policy, we can be
different in regards to the ac series.  

And I don't begin to comprehend your not sending in the lost disk space after
crash bug fix (I assume it is what you mean when you refer to lost files after a
crash, because I know of no lost files after a crash bug, please phrase things
more carefully), and it really annoys me and the users, frankly.  Why you
consider that a feature is beyond me.

monstr, could you fix it please and send the fix in?  We can't wait for Chris to
send it in any longer.

Thx,

Hans
