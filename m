Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265001AbUEYRtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265001AbUEYRtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265005AbUEYRtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:49:33 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:39042 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265001AbUEYRtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:49:31 -0400
Date: Tue, 25 May 2004 13:18:05 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040525171805.GG1286@phunnypharm.org>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <20040525131139.GW1286@phunnypharm.org> <Pine.LNX.4.58.0405251012260.9951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405251012260.9951@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 10:15:15AM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 25 May 2004, Ben Collins wrote:
> >
> > I've got a question about this. A lot of times I get patches that are
> > just one/two-liners and the explanation is somewhat self-explantory,
> > etc. Say the patch comes to me from some patch collection maintainer,
> > who got it from the original author.
> > 
> > So the original person never put a Signed-off-by, and neither did the
> > person who sent me the patch, should I still add the eplicit
> > Signed-off-by's to the patch, and add myself, before sending it to you?
> 
> You should never sign off for somebody else.
> 
> You _can_ sign off as yourself, and just add a note of "From xxxx". That's
> what the (b) case is all about (ie "to the best of my knowledge it's
> already under a open-source license").
> 
> Of course, if it's a _big_ work with lots of original content, and you're 
> unsure of exactly what the original author wanted to do with this, you 
> obviously should _not_ sign off on it. But you knew that.

I know you want this simple, but should we keep the paper-trail momentum
going by adding a "Submitted-by"? Like if I get a one-liner fix, which
is obviously not adding new code, rather than go through the whole
process of asking for them to agree to the signoff deal, could I do:

Submitted-by: Jimmy Janitor <jimmy@janitor.blah>
Signed-off-by: Ben Collins <bcollins@debian.org>

? I like the idea of knowing where a patch came from and via who. This
would make it easier to analyze that info, but keep it simple for
trivial patches that so many of us get (in the (b) case).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
