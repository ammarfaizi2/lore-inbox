Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271537AbRHUEeA>; Tue, 21 Aug 2001 00:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271538AbRHUEdk>; Tue, 21 Aug 2001 00:33:40 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:21793 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271537AbRHUEdf>; Tue, 21 Aug 2001 00:33:35 -0400
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
From: Robert Love <rml@tech9.net>
To: Theodore Tso <tytso@mit.edu>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Johan Adolfsson <johan.adolfsson@axis.com>,
        Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br
In-Reply-To: <20010820211107.A20957@thunk.org>
In-Reply-To: <3B80EADC.234B39F0@evision-ventures.com>
	<2248596630.998319423@[10.132.112.53]>
	<3B811DD6.9648BE0E@evision-ventures.com>  <20010820211107.A20957@thunk.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.20.07.08 (Preview Release)
Date: 21 Aug 2001 00:33:30 -0400
Message-Id: <998368415.3120.11.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-08-20 at 21:11, Theodore Tso wrote:
> A number of other people helped me with the design and development of
> the /dev/random driver, including one of the primary authors of the
> random number generation routines in PGP 2.x and 5.0.  Most folks feel
> that it does a good job.

It does :)

Thank you for adding to this thread.  I want your opinion: as the author
of /dev/random, its your turf.  What do you think of the patch?  It has
been posted for various kernel versions, the newest patches are at
http://tech9.net/rml/linux

Obviously there is a theoretical risk, that is why it is configurable.
Is the need or the practical risk sufficient that the patch is useful?
I have gotten a lot of positive feedback.

If the patch were to be merged into the kernel, would you like anything
changed?  Would a /proc interface be useful (this would add overhead,
right now there is zero extra code after compile)?  What about changing
the entropy estimate to reflect the possible less entropy from net
devices?

Personally, I like the patch as is, but these have been issues raised.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

