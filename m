Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319184AbSHNDy4>; Tue, 13 Aug 2002 23:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319186AbSHNDyz>; Tue, 13 Aug 2002 23:54:55 -0400
Received: from dp.samba.org ([66.70.73.150]:33723 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319184AbSHNDyx>;
	Tue, 13 Aug 2002 23:54:53 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       marcelo@conectiva.com.br
Subject: Re: Trivial Patch Policy (trivial@rustcorp.com.au) 
In-reply-to: Your message of "Tue, 13 Aug 2002 18:52:33 +0200."
             <20020813185233.J13598@suse.de> 
Date: Wed, 14 Aug 2002 13:56:02 +1000
Message-Id: <20020813225913.8F8CE2C205@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020813185233.J13598@suse.de> you write:
> On Mon, Aug 12, 2002 at 05:07:05PM +1000, Rusty Russell wrote:
>  > 2) The patch will not be forwarded to anyone until a new kernel has
>  >    been released after I receive the patch, *unless* noone else is
>  >    sent the patch.  So if you cc: the trivial patch monkey, it'll only
>  >    be forwarded from there if it doesn't make the next kernel.
> 
> What happens in this case..
> 
> person a sends the monkey a patch.
> person b replies to l-k (cc'ing monkey) with a "no do it this way" ?
> 
> do you have a hand-operated means to say "this patch supercedes the
> previous" ?

Yes, I close the old patch, and add the new one.  Low-tech, I know 8).
The original person will get a one-liner on why the patch was closed
(like, "obsoleted by new patch").

>  > 3) The first time the patch is forwarded, it will be sent to the
>  >    author and/or maintainer.  If they say they've included it in their
>  >    tree, no more forwards will occur (modulo some timeout eventually).
>  >    If they NAK it, the patch will be closed.  Otherwise, the patch
>  >    will be sent directly to Linus or Marcelo on future forwards (the
>  >    maintainer will still be cc'd).
> 
> What would be *really* good, for the case where retransmits are
> necessary, if Alan hasn't picked it up for 2.4 (or me for 2.5),
> you could add us to the relevant Cc's, (and remove after Alan/Myself
> takes it).

Hmmm, but it also adds the "multiple path to Linus problem" (yeah, I
could use BK, and I could start using Borland compilers too).

I currently don't track -ac and -dj trees at all, so I'd have to add
them.  It's certainly possible.

> This could however get tricky, as the same patch may need a bit
> of hand-merging to fit against -ac/-dj.

That's something I've simply refused to get into: patches either apply
or they don't.  With about 40 patches a week and other
responsibilities, I rely on the author seeing that something broke and
retransmitting.

> Maybe just simpler to remove us when Alan/I send an ACK ?

In total, I'm not convinced it's worth the effort.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
