Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTLUV5h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 16:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTLUV5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 16:57:36 -0500
Received: from mail.shareable.org ([81.29.64.88]:65415 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264147AbTLUV5W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 16:57:22 -0500
Date: Sun, 21 Dec 2003 21:57:17 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Stan Bubrouski <stan@ccs.neu.edu>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [OT] use of patented algorithms in the kernel ok or not?
Message-ID: <20031221215717.GA6507@mail.shareable.org>
References: <1071969177.1742.112.camel@cube> <20031221105333.GC3438@mail.shareable.org> <1072034966.1286.119.camel@duergar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072034966.1286.119.camel@duergar>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stan Bubrouski wrote:
> > I expect this was said in jest, but it would be delightful to see this
> > done for real.  To the best of my knowlege it's uncharted territory,
> > so perhaps what you suggest _would_ be upheld in a court of law as
> > permissible?
> 
> No No No No No...do you really think including code for a patented
> algorithm(s) is a good idea?  You are still distributing the code and
> allowing people to illegally use it in countries where they are not
> allowed to.  In essence you are providing a catalyst for them to violate
> a patent and making yourself and other liable along the way.

That is equally true if I publish a book explaining the algorithm in
great detail - enough detail that you could practically copy working
code from the book.  Yet, publishing books seems to be fine.

That's why I said it's uncharted territory.  We don't know how safe it
is to publish code that *doesn't do anything* but does embody a
patented technique *only if the recipient deliberately modifies the
code*.

Please explain the difference between publishing a book that doesn't
do anything itself, but might "catalyse" a person to using a patented
technique, and publishing source text that doesn't do anything, but
might "catalyse" a person to using a patented technique *if they
deliberately decide to infring the patent themselves*.

If anything, the book is more irresponsible because usually books
don't tell the reader about patents on the methods they describe.  On
the other hand, we are very responsible and propose to tell the reader
_exactly_ what their responsibilities are and the consequences of
their actions if they choose to modify the work.  We give them the
knowledge and the choice.

> US law is sick and fucked up, and if someone sues you for patent
> infringement you're most likely fucked, because you can never have
> enough money to defend yourself...

That's true.  And they can sue you _even if you didn't do anything
wrong_ and you're most likely fucked too.  Innocence is no excuse.

So it has little to do with obeying the law, which is totally
ambiguous in this area anyway, and a lot to do with being an
undesirable target, doesn't it?

> for the sake of us stuck in this so-called free
> country (though we can be arrested and jailed without trial?)

You can be arrested and jailed even if you _don't_ infringe any
patents, too.

You have to be pragmatic, but if you are totally ruled by fear of what
they _might_ do, you'll never do anything interesting.  So we push the
envelope a little bit and see how it works out.  See if people find it
acceptable practice, or if it's not a good time to encode that much
personal freedom and responsibility.

It's not at all clear that !CONFIG_USA || CONFIG_PATENT_nnnnnnnnnn
would be "illegal" in the USA.  As you saw from the help text, there
are many people and organisations _in the USA_ which would be permitted
to enable the options.

It's a lot like the binary modules question, only this time it's the
companies with patent portfolios that like to keep the status quo
ambiguous, because it suits their position.  We can recoil from the
ambiguity, or we can take advantage of it to produce better software.

-- Jamie
