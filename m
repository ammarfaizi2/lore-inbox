Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVEVSov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVEVSov (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 14:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVEVSov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 14:44:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24595 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261556AbVEVSor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 14:44:47 -0400
Date: Sun, 22 May 2005 19:44:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: When we detect that a 16550 was in fact part of a NatSemi SuperIO chip
Message-ID: <20050522194438.A9854@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <200505220008.j4M08uE9025378@hera.kernel.org> <1116763033.19183.14.camel@localhost.localdomain> <Pine.LNX.4.58.0505220953300.2307@ppc970.osdl.org> <1116785646.6285.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1116785646.6285.24.camel@laptopd505.fenrus.org>; from arjan@infradead.org on Sun, May 22, 2005 at 08:14:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2005 at 08:14:06PM +0200, Arjan van de Ven wrote:
> On Sun, 2005-05-22 at 09:59 -0700, Linus Torvalds wrote:
> > 
> > On Sun, 22 May 2005, David Woodhouse wrote:
> > > 
> > > Linus, please do not apply patches from me which have my personal
> > > information mangled or removed.
> > 
> > I've asked Russell not to do it, but the fact is, he's worried about legal 
> > issues, and while I've also tried to resolve those (by having the OSDL 
> > lawyer try to contact some lawyers in the UK), that hasn't been clarified 
> > yet.
> 
> there is a potential nasty interaction with the UK moral rights thing
> where an author can demand that his authorship claim remains intact...
> so if David objects to his authorship being mangled (and partially
> removed) he may have a strong legal position to do so.

Actually, that only depends on whether you decide that Signed-off-by:
reflects authorship.  There's evidence to say that it may not:

1. There can be multiple Signed-off-by: lines in a patch - many of whom
   are not authors of the code.

2. The first Signed-off-by: line may not be the author of the code if
   the author has not added that himself.  It may be a subsystem
   maintainers.

If you don't believe either of those, I suggest you re-read the original
discussions about Signed-off-by: and refresh your memory that, in fact,
all Signed-off-by: is saying is that _someone_ accepts responsibility
for submitting the patch.

If you still don't accept that, here's the actual text in
SubmittingPatches - maybe it's wrong?

| The sign-off is a simple line at the end of the explanation for the
| patch, which certifies that you wrote it or otherwise have the right to
                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^
| pass it on as a open-source patch.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Let's look at it another way.  Signed-off-by: is a mark of attributation
and authorship.  If someone were to receive an un-signedoff patch but
had the right to pass it on as an open-source patch, according to your
position it would be wrong to add a "Signed-off-by:" line, because that's
like falsely claiming your the author of the code.  And what about all
the other Signed-off-by: lines which are subsequently added by Andrew
and Linus?  Aren't they falsely claiming authorship as well?

Therefore, claiming that Signed-off-by: is a mark of attributation
or authorship is obviously nonsense.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
