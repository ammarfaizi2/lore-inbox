Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130634AbRAHWdN>; Mon, 8 Jan 2001 17:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135453AbRAHWdD>; Mon, 8 Jan 2001 17:33:03 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:59914 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130634AbRAHWc4>;
	Mon, 8 Jan 2001 17:32:56 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <200101080124.RAA08134@pizda.ninka.net> <d366jp4sin.fsf@lxplus015.cern.ch> <200101082148.NAA21738@pizda.ninka.net>
From: Jes Sorensen <jes@linuxcare.com>
Date: 08 Jan 2001 23:32:48 +0100
In-Reply-To: "David S. Miller"'s message of "Mon, 8 Jan 2001 13:48:08 -0800"
Message-ID: <d31yud4qun.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David> We _had_ to change some drivers to show how to support this new
David> SKB api for transmit sg+csum support.  If you can think of a
David> way for us to effectively do this work without changing at
David> least a few drivers as examples (and proof of concept), please
David> let us know.

Dave, I am not complaining about drivers having to be changed for this
to work I am fully aware of this need. My complaints are about how
this is being done, ie. I some people try to maintain drivers and have
certain ideas about how they structure their code etc. If you had sent
me a short email saying this is what we plan to do and this is what we
think should be done to your code, whats your oppinion. I would have
volunteered to help write the code and get the stuff integrated much
earlier as well as given you my input on how I would like to see the
changes implemented. Instead we now have a fairly large patch which
will take me a long time to merge into the driver version that I
maintain.

David> In the process we hit real bugs in your driver, and tried to
David> deal with them as best we could so that we could continue
David> testing and debugging our own code.

I would have appreciated a simple email saying "we found bug X in your
driver" with either a patch attached or a short note of your
observations.

David> As a side note, as much as you may hate some of Alexey's
David> changes to your driver, several things he does fixes long
David> standing real bugs in the Acenic driver that you've been
David> papering over with workarounds for quite some time.  I would
David> even go so far as to say that in many regards Alexey
David> understands the Acenic much better than you, and you would be
David> wise to work with Alexey and not against him.  Thanks.

I don't question Alexey's skills and I have no intentions of working
against him. All I am asking is that someone lets me know if they make
major changes to my code so I can keep track of whats happening. It is
really hard to maintain code if you work on major changes while
someone else branches off in a different direction without you
knowing. It's simply a waste of everybody's time.

Thanks
Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
