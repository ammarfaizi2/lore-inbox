Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264904AbUFRVwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264904AbUFRVwp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbUFRVuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:50:17 -0400
Received: from lakermmtao12.cox.net ([68.230.240.27]:60869 "EHLO
	lakermmtao12.cox.net") by vger.kernel.org with ESMTP
	id S264500AbUFRVhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:37:20 -0400
In-Reply-To: <Pine.LNX.4.58.0406182301060.20412@zeus.compusonic.fi>
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay> <40D23701.1030302@opensound.com> <1087573691.19400.116.camel@winden.suse.de> <40D32C1D.80309@opensound.com> <40D33464.6030403@techsource.com> <40D33338.6050001@opensound.com> <F1B17570-C158-11D8-9A43-000393ACC76E@mac.com> <Pine.LNX.4.58.0406182301060.20412@zeus.compusonic.fi>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AD103103-C16F-11D8-9A43-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Timothy Miller <miller@techsource.com>,
       4Front Technologies <dev@opensound.com>,
       Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Stop the Linux kernel madness
Date: Fri, 18 Jun 2004 17:37:19 -0400
To: Hannu Savolainen <hannu@opensound.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 18, 2004, at 16:31, Hannu Savolainen wrote:
> A minor correction. We have not contributed much recently (if not  
> counting
> few minor patches that have been rejected). However the oldest layers
> (until 1996/1997) of the kernel OSS drivers are mostly our work.

Ahh, my apologies then. I am sincerely sorry for any offense I may have  
caused.

>> you've done is demand things of the LKML, but why should we listen to
>> your demands instead of our own.
> It depends on if you are developing just for yourself and few of your
> friends. However if you like your work being used by majority of  
> computer
> users then it would be a good idea to listen all kind of input. Even
> input you don't like to hear.

The original poster did not provide a specific set of issues that  
needed to be
resolved, they just posted a very messy email with several statements  
that
didn't make sense.  Even later, when they were asked what issues they  
were
having, they just dodged the question.  Then the email that I responded  
to
had the attitude of "You guys are only here to fix my problems," which  
is
totally unacceptable.

>> Besides, a lack of
>> organization is
>> sometimes a good thing. (See _The_Cathedral_and_the_Bazaar_:
>> <http://www.catb.org/~esr/writings/cathedral-bazaar/cathedral-bazaar/ 
>> >).
> Lack of organization is good thing in the right place. However lack of
> standardization in a wrong place is not good. For example the ls  
> command
> cannot be renamed to "dir", "stat", "list-files" or anything else.

Well of course!  I said "lack of organization is _sometimes_ a good  
thing."  I
agree wholeheartedly.  And I'd actually rather not have ls named "dir",  
cause
I'd rather avoid my painful DOS memories. :-D

> Equally well it's going to be usefull to have a standardized command  
> (say
> /lib/modules/`uname -r`/build/scripts/kbuild /my/source/directory)  
> rather
> than having different make commands required by each Linux  
> distribution.
> Nothing prevents the distribution maintainers from optimizing that  
> command
> in a way they like as long as the usage remains the same.

Ahh, see, from the original poster's comments it was not apparent that  
their
problem was the lack of a standardized build system.  In any case, the
primary problem is the lack of a configured kernel source tree.  My  
advice
to them is to just use the standard module building mechanism:
1)	User decides that he/she wants a module
2)	User cd's to wherever his/her kernel source tree is
3)	User runs "make-kpkg" or whatever his/her distro's kernel tool is.
4)	User installs the package generated.

It seems to me that there should not be an automated kernel or module  
build
procedure.  Either the user knows what they're doing, is following  
directions
over the phone from somebody who knows what their doing, or has no clue.
The users that have no clue should probably not be trying to compile  
their
own modules anyway.

Cheers,
Kyle Moffett


