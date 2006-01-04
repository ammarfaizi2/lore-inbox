Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWADOQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWADOQp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 09:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWADOQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 09:16:45 -0500
Received: from mail.shareable.org ([81.29.64.88]:47830 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S932091AbWADOQn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 09:16:43 -0500
Date: Wed, 4 Jan 2006 14:16:07 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: Ben Slusky <sluskyb@paranoiacs.org>, Steven Rostedt <rostedt@goodmis.org>,
       linux-fsdevel@vger.kernel.org, legal@lists.gnumonks.org,
       "Robert W. Fuller" <garbageout@sbcglobal.net>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       Kyle Moffett <mrmacman_g4@mac.com>, info@crossmeta.com
Subject: Re: blatant GPL violation of ext2 and reiserfs filesystem drivers
Message-ID: <20060104141607.GA12824@mail.shareable.org>
References: <43AACF77.9020206@sbcglobal.net> <496FC071-3999-4E23-B1A2-1503DCAB65C0@mac.com> <1135283241.12761.19.camel@localhost.localdomain> <20051223153541.GA13111@paranoiacs.org> <20060104110929.GH4898@sunbeam.de.gnumonks.org> <20060104115422.GA2562@mail.shareable.org> <20060104131805.GM4898@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104131805.GM4898@sunbeam.de.gnumonks.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte wrote:
> > Ah, that depends on whether they provided the source code for download
> > to paying customers at the time those customers downloaded the binary.
> 
> yes.  but the point is (according to reports I have received) that the
> object code (without source code) was available for download on the
> crossmeta website. 

That sentence is not clear to me.  Are you're saying that it was
possible to download the object code without source code, or that
_only_ the object code was available?  The quoted GPL text means: the
distributor is allowed to offer the object code by itself, and the
source as a separate download from the same place at the same time.

> Therefore anyone could have obtained a binary copy with no included
> source code, and thus the 'any third party' clause implicitly comes into
> effect.

No.  They must provide the 'written offer' to the person downloading
the binary, if they did not make available source code to that person.

If they did not provide the 'written offer', they are infringing the
copyright.  A settlement might involve them having to provide that
offer to third parties; then again, it might not.

If they did provide the 'written offer', to the person downloading the
binary, then of course the 'third party' clause should be part of
that.  It doesn't mean you can demand source, until you have a copy of
that offer.

> As soon as you've even only once given a copy of the executable code
> without at the same time including the full corresponding source code,
> "any third party" is entitled to obtain a copy of the source code.

I won't claim to be 100% sure, I'm not a lawyer, but that is not my
interpretation of clause 3, and I have it right in front of me.

My interpretation is this:

   If they gave a copy of the executable and _made available_
   the source code from the same place, with equivalent access,
   they're in the clear.  Even if the person downloading the
   executable didn't download the source.

   If they didn't make available the source, then they should have
   accompany the executable with the written offer, to give any third
   party the source (+ small charge, 3 years etc.)

   Assuming they did provide the written offer (e.g. as a file with
   the downloaded executable), then that by itself doesn't grant any
   third party the right to demand the source.

   To demand the source: a third party must get that written offer
   from someone who received it.  A person who downloaded the
   executable could give it to them - indeed, they would _have_ to, if
   that person gave the third party a copy of the executable without
   source.  (Clause 3c).  Or, someone else who has received that offer
   could pass it along.  Someone might even be kind enough to pass
   that offer to everyone - i.e. publish it.

   So, if you are a third party, and you want to demand the source
   code, first get hold of that written offer to provide the source
   code from someone who downloaded the executable.

   The reason why the written offer is passed around is because the
   GPL is designed to ensure source code is available alongside
   executables; not to force source code of private projects to be
   made public.

   You can easily show that the passing around like this of the
   written offer is intended, if the GPL's clause 3b seems unclear:
   Look at clause 3c.  There would be no need for clause 3c if every
   third party automatically got to demand source without having been
   passed the written offer.

Of course, if crossmeta were offering the executable download to
everyone including non-paying customers (I don't know the whole
story), then of course all those people who downloaded it are entitled
to demand the source.  None of those people are third parties, by the
way, but they're all entitled to get the source somehow.

And, again, I'm not a lawyer.  FSF legals will presumably have a more
authoritative answer.

-- Jamie
