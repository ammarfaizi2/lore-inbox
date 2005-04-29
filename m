Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262836AbVD2Qt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbVD2Qt6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 12:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbVD2Qsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 12:48:35 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:59652 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262826AbVD2Qq7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 12:46:59 -0400
Message-ID: <427264F2.1040609@tmr.com>
Date: Fri, 29 Apr 2005 12:46:42 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Matt Mackall <mpm@selenic.com>, Sean <seanlkml@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
References: <20050429074043.GT21897@waste.org><Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 29 Apr 2005, Matt Mackall wrote:
> 
>>Mercurial is even younger (Linus had a few days' head start, not to
>>mention a bunch of help), and it is already as fast as git, relatively
>>easy to use, much simpler, and much more space and bandwidth
>>efficient.
> 
> 
> You've not mentioned two out of my three design goals:
>  - distribution
>  - reliability/trustability
> 
> ie does mercurial do distributed merges, which git was designed for, and 
> does mercurial notice single-bit errors in a reasonably secure manner, or 
> can people just mess with history willy-nilly?
> 
> For the latter, the cryptographic nature of sha1 is an added bonus - the
> _big_ issue is that it is a good hash, and an _exteremely_ effective CRC
> of the data. You can't mess up an archive and lie about it later. And if
> you have random memory or filesystem corruption, it's not a "shit happens"  
> kind of situation - it's a "uhhoh, we can catch it (and hopefully even fix
> it, thanks to distribution)" thing.
> 
> I had three design goals. "disk space" wasn't one of them, so you've
> concentrated on only one so far in your arguments.

Reliability is a must have, but disk space matters in the real world if 
all other things are roughly equal. And bandwidth requirements are 
certainly another real issue if they result in significant delay.

Isn't the important thing  having the SCC reliable and easy to use, as 
in supports the things you want to do without jumping through hoops? One 
advantage of Mercurial is that it can be the only major project for 
someone who seems to understand the problems, as opposed to taking the 
time of someone (you) who has a load of other things in the fire. And if 
there isn't time to do all the things you want, perhaps generating a 
wisj list and stepping back would be a good thing.

If you have the energy and time to stay with git, I'm sure it will be 
great, but you might want to provide input on Mercurial and let it run.

PS: I don't think the performance difference is enough to constitute a 
real advantage in either direction.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
