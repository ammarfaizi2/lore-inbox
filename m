Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264968AbUEYQmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbUEYQmj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 12:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264969AbUEYQmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 12:42:39 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:54539 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S264968AbUEYQmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 12:42:35 -0400
Date: Tue, 25 May 2004 12:42:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040525164232.GD28169@fieldses.org>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 11:46:29PM -0700, Linus Torvalds wrote:
> This is not about proving authorship - it's about documenting the
> process. This does not replace or preclude things like PGP-signed
> emails, this is _documenting_ how we work, so that we can show people
> who don't understand the open source process.

What aspects of the process do you want to document?

The patch-submission process can be more complicated than a simple path
up a heirarchy of maintainers--patches get bounced around a lot
sometimes.

If you're trying to document who contributes "intellectual property" to
the kernel, then documenting the process of creating the patch would
seem more important than documenting the actual submission--any
significant change is often the result of complicated discussions
between multiple parties who wouldn't necessarily appear in the chain of
submittors.

I gues I'm still a little vague as to exactly what sort of questions we
expect to be able to answer using this new documentation.

A couple examples (which I think aren't too farfetched):
	* Developer A submits a patch which is dropped by maintainer B.
	  I later notice this and resubmit A's patch to B.  I don't
	  change the patch at all, and the resubmission is my only
	  contribution to the process.  Do I need to tag on my own
	  "Signed-off-by" line?
	* I write a patch.  Developers X and Y suggest significant
	  changes.  I make the changes before I submit them to maintainer
	  Z.  Suppose the changes are significant enough that I no longer
	  feel comfortable representing myself as the sole author of the
	  patch.  Should I also be asking developer X  and Y to add their
	  own "Signed-off-by" lines?

--Bruce Fields
