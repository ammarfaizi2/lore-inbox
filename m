Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVARWZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVARWZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 17:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVARWZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 17:25:56 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:59264 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261450AbVARWZi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 17:25:38 -0500
Message-ID: <41ED8D5F.5030409@tmr.com>
Date: Tue, 18 Jan 2005 17:27:43 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Theodore Ts'o" <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@redhat.com>, Marek Habersack <grendel@caudium.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <20050114183415.GA17481@thunk.org><Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <Pine.LNX.4.58.0501141047470.2310@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501141047470.2310@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With no disrespect, I don't believe you have ever been a full-time 
employee system administrator for any commercial or government 
organization, and I don't believe you have any experience trying to do 
security when change must be reviewed by technically naive management to 
justify cost, time, and policy implications. The people on the list who 
disagree may view the security information issue in a very different 
context.


Linus Torvalds wrote:

> What vendor-sec does is to make it "socially acceptable" to be a parasite. 
> 
> I personally think that such behaviour simply should not be encouraged. If
> you have a security "researcher" that has some reason to delay his
> disclosure, you should see for for what he is: looking for cheap PR. You
> shouldn't make excuses for it. Any research organization that sees PR as a
> primary objective is just misguided.

There are damn fine reasons for not having immediate public disclosure, 
it allows vandors and administrators to close the hole before the script 
kiddies get a hold of it. And they are the real problem, because there 
are so MANY of them, and they tend to do slash and burn stuff, wipe out 
your files, steal your identity, and other things you have to notice. 
They aren't smart enough to find holes themselves in most cases, they 
are too lazy in many cases to read the high-level hacker boards, and a 
few weeks of delay in many cases lets the careful avoid damage.

Security through obscurity doesn't work, but a small delay for a fix to 
be developed can prevent a lot of problems. And of course the 
information should be released, it encourages the creation and 
installation of fixes.

Oh, and many of the problem reports result in "cheap PR" consisting of a 
single line mention in a CERT report or similar. Most people are not 
doing it for the glory.

> What's the alternative? I'd like to foster a culture of
> 
>  (a) accepting that bugs happen, and that they aren't news, but making 
>      sure that the very openness of the process means that people know
>      what's going on exactly because it is _open_, not because some news 
>      organization had to make a big stink about it just to make a vendor
>      take notice.

Linux vendors aside, many vendors react in direct proportion to the bad 
publicity engendered. I'd like the world to work that way, but in many 
places it doesn't.
> 
>      Right now, people seem to think that big news media warnings on 
>      cnet.com about SP2 fixing 15 vulnerabilities or similar is the proper
>      way to get people to upgrade. That just -cannot- be right.

Unfortunately reality doesn't agree with you. Many organizations have no 
other effective way to convince management of the need for a fix except 
newspaper articles and magazine articles. A sometimes that has to get to 
the horror story stage before action is possible.


> And let's not kid ourselves: the security firms may have resources that 
> they put into it, but the worst-case schenario is actual criminal intent. 
> People who really have resources to study security problems, and who have 
> _no_ advantage of using vendor-sec at all. And in that case, vendor-sec is 
> _REALLY_ a huge mistake. 

I think you are still missing the point, I don't care if a security firm 
reads mailing lists or tea leaves, does research or just knows where to 
find it, they are paid to do it and if they do it well and report the 
problems which apply to me and the source of the fixes they keep me from 
missing something and at the same time save me time. Even reading only 
good mailing lists and newsgroups it takes a lot of time to keep 
current, and you see a lot of stuff you don't need.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
