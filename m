Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289803AbSA2TX2>; Tue, 29 Jan 2002 14:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289813AbSA2TXS>; Tue, 29 Jan 2002 14:23:18 -0500
Received: from air-1.osdl.org ([65.201.151.5]:56984 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S289803AbSA2TXD>;
	Tue, 29 Jan 2002 14:23:03 -0500
Date: Tue, 29 Jan 2002 11:24:01 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Stuart Young <sgy@amc.com.au>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>,
        Rob Landley <landley@trommello.org>, <smurf@osdl.org>,
        <wookie@osdl.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <5.1.0.14.0.20020129173507.01fa2a00@mail.amc.localnet>
Message-ID: <Pine.LNX.4.33.0201291003310.800-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Jan 2002, Stuart Young wrote:
> Perhaps what we need is a patch maintenance system? Now I'm not talking 
> CVS, I'm talking about something that is, in reality, pretty simple. 
> Something that does the following:

Ah, the old Patch Management Problem. It's like an old friend (or a bad 
rash). 

AFAIK, something like this was first proposed here:

http://lists.insecure.org/linux-kernel/2000/Sep/2468.html

At that time, we were in the midst of the 2.4.0-test? series. Many things 
were unstable and/or volatile. Linus was receiving an ungodly number of 
patches, and releasing a new -pre patch about every day. 

One of the main problems was that many patches simply didn't apply. What 
a patch was diffed against would become obsolete so quickly, that many 
patches were rendered useless by the time they were even read. And, there 
was the same limitation concerning Linus's ability and desire to reply to 
every single email. 

The concept is very simple and described well in the email. So, I will not 
expound on it here. Unfortunately, the project was dropped internally. 

The problem has come up a few times in the last few months. Several people 
have expressed interest in having something like it. Some already do. 
Several people have said they were working on something like it. 
Unfortunately, I think most of those people got distracted with their 
other full-time jobs or more intersting work.

I brought the topic up here at OSDL a few months ago for use both 
internally and externally. Also, with the notion of integrating our STP 
(Scalable Test Platform). We've had several discussions about it, what it 
would look like, and how it would work. We've also had the chance to talk 
with a few of the other kernel maintainers in the area (face-to-face 
meetings really do a long way).

The conclusions were this:

Is it necessary?	No.
Could it be useful?	Yes.
Would people use it?	Probably. 
Would everyone use it?	No.
Would Linus use it?	Probably Not. 


Which is all pretty obvious. You can't please everyone.

We're going to develop a system internally and are willing to host a 
system for the rest of the world to use. We're not looking to design a 
be-all, end-all solution. Basically, just a system that can automate 
things like applying patches and compiling. 

If a patch succeeds, it then goes to the maintainer to which it was sent. 
The maintainer can then accept or reject the patch. Either with 
explanation or not. The submitter can then track what patches were 
accepted. 

Submitted patches can also go to a public mailing list and/or exported via 
a public (read: web) interface. Of course, there should be ways to 
override the publicity for OOB patches and sensitive items. 

Writing the software is really not that difficult. But, we want something 
that people like and can use, as well as modular and extensible. So, we're 
aiming for simplicity and modularity. 

So, the obvious question is 'So, where is it at now?'. Not much further 
than the conceptualizing stage. The two people actually writing the 
software are a bit over-subscribed ATM, though we do have some pretty 
pictures. 

I'm currently in the waiting queue for a Sourceforge project. Once that is 
live, there will be a mailing list to which the discussion can be moved 
and kept alive. Anyone and everyone interested is welcome to submit their 
ideas and suggestions. Via the SF project, we will submit our designs and 
post our progress on the system. 

If you prefer a more private forum, feel free to email me and/or the Man 
with the Plan: Nathan Dabney at smurf@osdl.org.

	-pat




