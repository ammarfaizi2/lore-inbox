Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273894AbRIRUSJ>; Tue, 18 Sep 2001 16:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273895AbRIRUR7>; Tue, 18 Sep 2001 16:17:59 -0400
Received: from ns.ithnet.com ([217.64.64.10]:8 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S273894AbRIRURy>;
	Tue, 18 Sep 2001 16:17:54 -0400
Date: Tue, 18 Sep 2001 22:17:48 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-pre11
Message-Id: <20010918221748.1f51f801.skraw@ithnet.com>
In-Reply-To: <20010918131419.A14526@turbolinux.com>
In-Reply-To: <Pine.GSO.4.21.0109181354470.27125-100000@weyl.math.psu.edu>
	<Pine.LNX.4.33.0109181122550.9711-100000@penguin.transmeta.com>
	<20010918131419.A14526@turbolinux.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2001 13:14:19 -0600 Andreas Dilger <adilger@turbolabs.com>
wrote:

> On Sep 18, 2001  11:27 -0700, Linus Torvalds wrote:
> [...]
> The real question is why can't we just open 2.5 and only fix the VM to
> start with?

Hm, I guess if anybody would be capable of _really_ fixing vm in upto-pre10
state, he would have done it already. It's not that people would not have
tried, but it looks like nobody is able to get the _whole_ picture of this.
Surely there are people that know a lot about certain parts of the (old) vm
code, and thats exactly what leads to this Linus' statements here sounding like
"I had a look at part xyz of it and it's a mess. Patch appended." (see pre10 vm
patch).
You have to keep in mind that a lot of people on the planet try to use 2.4 in a
unbelievably broad variety of setups - and quite a number of them relies on
released kernels. If you take a close look at 2.4.7, 2.4.8, 2.4.9 you may well
find out, that they're unusable compared to 2.2.19. You cannot go on like this.
I really do back Andrea and Linus for this step, because I can _see_ a great
win in performance _and_ things got less complex in this code. So there is a
much bigger chance to tilt the last remaining problems in short time (hopefully
before 2.4.10 or .11). 
So I guess the right thing to do now is give Andrea good input of leftover,
reproducible problems to give him a chance to fix them. A major discussion
about "doing it all the way round" makes only sense, if someone comes up with
something _at least_ as good as Andrea's code. 
Then its "Lonely Linus"' decision to choose. Whatever he will choose, a good
percentage LKML will be against it. This is a normal thing, the guy that has to
make the decision is alone most of the time. The only way for you to find out
if he is right is to _try_ it. If he is, tell him. If he isn't, send a patch.
He couldn't have been that wrong the last years, though.

</end sermon>

Just _one_ opinion from an unimportant guy,

Stephan

