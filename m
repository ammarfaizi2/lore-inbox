Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286137AbRLZCzV>; Tue, 25 Dec 2001 21:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286140AbRLZCzM>; Tue, 25 Dec 2001 21:55:12 -0500
Received: from f112.law9.hotmail.com ([64.4.9.112]:57361 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S286137AbRLZCzI>;
	Tue, 25 Dec 2001 21:55:08 -0500
X-Originating-IP: [66.92.149.187]
From: "William Knop" <w_knop@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: LKML signal to noise ratio-- improvement
Date: Tue, 25 Dec 2001 21:55:01 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F112MFAONTUR4NQJyaL0000f6ad@hotmail.com>
X-OriginalArrivalTime: 26 Dec 2001 02:55:02.0410 (UTC) FILETIME=[B6D696A0:01C18DB8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
I have recently been reading new and archived posts regarding the wish for a 
more organized development system for the kernel. Some people want 
centralized version control and bug tracking, some want sophisticated tools 
to accomplish something close to what we already have, some just don't feel 
like investing the effort to devise a better system, and some insist the way 
things are done are the best way to do them.

I happen to know there is a better way of doing things, because a major 
complaint is the 'signal to noise ratio'. The proverb, "One man's trash is 
another man's treasure" is a great way to think about the problem.

For instance, some people like discussing major reworks of the kernel, where 
the change is not necessary. Hackers like to screw around in this area, and 
most of the time developers and maintainers do not. In fact, developers and 
maintainers rather appreciate bug and patch submissions, but do not 
appreciate updating their kill lists.

I believe Alan Cox put it well when he said, "Did you have to change the 
subject line. It makes it harder to kill file when people keep doing that," 
regarding the /proc reworking. Correct me if I am wrong, but he probably 
does not want to hear the rework/overhaul discussions.

Since this is a mailing list, I don't believe the correct solution is to let 
search tools evolve our problems away. If you read from an archive, that 
would be acceptable, but if you subscribe it is not.

So, where am I going with this? Well, the solution is that lkml be split 
into sublists, namely linux-kernel-bug, linux-kernel-patch, 
linux-kernel-help, and linux-kernel-discussion (or perhaps -misc or 
-general, although -discussion seems to encourage posting more, which IMHO 
is a good thing). I like to think of it as a "non-invasive" solution. One 
could have a symbolic "linux-kernel" which subscribes to all the lists so 
the current lkml list of subscribers could be preserved.

Discussion related to bugs and patches would spawn from the posts of bugs 
and patches in their respective lists, and misc ones would start and be 
contained in the general -discussion list.

A bonus is the honey pot technique used to discover network viruses could be 
used to kill spam from lkml. Presumably the advertisers would post to more 
than one of the l-k lists, so if a post goes to more than one list within a 
minute of eachother, delete them both. The list could generate and store 
(for a minute) a checksum and maybe length for each message to compare to 
new messages incoming on the other lists. So the message would be delayed a 
minute before being sent, but less spam. Of course this requires extra 
development/programming of the mailing system, so I consider it low-priority 
compared to simply separating the list. It could be that vger already does 
this, using the other lists; I don't know.

-Will

PS I am not subscribed anymore, so if you could CC responses to me, I'd 
appreciate it.

_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

