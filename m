Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTLUKx5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 05:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTLUKx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 05:53:57 -0500
Received: from mail.shareable.org ([81.29.64.88]:36999 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262687AbTLUKxy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 05:53:54 -0500
Date: Sun, 21 Dec 2003 10:53:33 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [OT] use of patented algorithms in the kernel ok or not?
Message-ID: <20031221105333.GC3438@mail.shareable.org>
References: <1071969177.1742.112.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071969177.1742.112.camel@cube>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> What about the obvious Kconfig option?
> 
> config PATENT_1234567890
>         bool "Patent 1234567890"
>         default n
>         help
>           Say Y here if you have the right to use
>           patent 1234567890 (the foo patent). Some
>           countries do not recognise this patent, an
>           educational or research exemption may apply,
>           you may be the patent holder, the patent
>           may have expired, or you may have aquired
>           rights via licensing. Seek legal help if you
>           need advice concerning your rights. If unsure,
>           say N.

I expect this was said in jest, but it would be delightful to see this
done for real.  To the best of my knowlege it's uncharted territory,
so perhaps what you suggest _would_ be upheld in a court of law as
permissible?

    1. You seggragate code using the feature so that if it is not
       explicitly activated, then the patented method will not be used.

    2. You are clearly informing the recipient of the software of their
       need to determine for themselves whether they are permitted to
       use the feature, and suggest how they can go about this.

    3. Using the patented method requires a clear, explicit step by
       the recipient of the software, with no potential for
       misunderstanding.  It is just as clear as those disclaimer
       buttons, ensuring that a user knows their rights and duties and
       agrees to them before they are allowed access to something.


Closed source commercial software already does this sort of thing.
Was it not the case that if you purchased the appropriate license from
Unisys, you were then permitted to activate the GIF writing support of
Photoshop or some similar product, and that was done with an
activation code that you typed in to the program.

CONFIG_PATENT_nnnnnnnnn is the same thing, yet we are wary of
distributing open source software like that.  Is the significant
difference that it's too easy to enable without a license?  That may
well prove to be the determining factor in clarifying the legal
boundary of of who is liable - the sender of disabled code, or the
recipient who enables it without permission.

Certainly it cannot be justified under law that, even as closed source
implementations are distributed using activation code methods, the
open source implementations are not distributable solely because they
can be read by anyone.  Patent holders do not have the power, at least
not in law, to prevent sharing written explanations of a method, do
they?  I thought it had something to do with _using_ the methods,
although it continues to be a bit ambiguous what a patent holder may
restrict and what they have no legal right to restrict in this field.

-- Jamie

