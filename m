Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265010AbUEYSDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265010AbUEYSDu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265016AbUEYSDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:03:49 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:1671 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265010AbUEYSDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:03:47 -0400
Date: Tue, 25 May 2004 19:02:25 +0100
From: Dave Jones <davej@redhat.com>
To: Ben Collins <bcollins@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040525180225.GA2668@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ben Collins <bcollins@debian.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <20040525131139.GW1286@phunnypharm.org> <Pine.LNX.4.58.0405251012260.9951@ppc970.osdl.org> <20040525171805.GG1286@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525171805.GG1286@phunnypharm.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 01:18:05PM -0400, Ben Collins wrote:

 > I know you want this simple, but should we keep the paper-trail momentum
 > going by adding a "Submitted-by"? Like if I get a one-liner fix, which
 > is obviously not adding new code, rather than go through the whole
 > process of asking for them to agree to the signoff deal, could I do:
 > 
 > Submitted-by: Jimmy Janitor <jimmy@janitor.blah>
 > Signed-off-by: Ben Collins <bcollins@debian.org>
 > 
 > ? I like the idea of knowing where a patch came from and via who. This
 > would make it easier to analyze that info, but keep it simple for
 > trivial patches that so many of us get (in the (b) case).

For trivial one liners, it's usually quicker for me to
just hack the file myself than to save the diff, run it through
patch, delete the diff when I'm done etc.  When I do this
I usually put in the changelog "pointed out by Joe Hacker".
My reasoning behind this is that all typos are then mine 8-)
whilst still crediting the person who did the original.

Likewise if I fix something in a slightly different way
to how the patch that was submitted did it, as the person
reporting still did some work which they should be credited for,
even if ultimately their solution wasn't used, but was used
as a basis for the real fix.

In these cases, I think it'd be reasonable to have..

Signed-off-by: Dave Jones <davej@redhat.com>
Spotted-by: Joe Hacker <joe@scoblows.com>

As asking submitters to sign off on modified versions
of their patch would be silly overhead IMO.

Linus?

		Dave

