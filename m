Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVJBPdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVJBPdJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 11:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVJBPdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 11:33:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9377 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751106AbVJBPdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 11:33:08 -0400
Date: Sun, 2 Oct 2005 08:33:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@sgi.com>
cc: "Antonino A. Daplas" <adaplas@gmail.com>, akpm@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net
Subject: Re: [PATCH] Document from line in patch format
In-Reply-To: <20051002000712.4689bbb2.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0510020831290.31407@g5.osdl.org>
References: <20051002062135.32334.32895.sendpatchset@jackhammer.engr.sgi.com>
 <433F860C.7050807@gmail.com> <20051002000712.4689bbb2.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2 Oct 2005, Paul Jackson wrote:

> Tony wrote:
> > > +    listed in the last "Signed-off-by:" line in the message when Linus
> >                      ^^^^ 
> > Shouldn't this be the first?
> 
> When I sent a patch with no "from" line, and two "Signed-off-by"
> lines (the patch that prompted this excursion into documentation
> excellence) Linus stated that the patch author ended up coming from
> the second "Signed-off-by" line.
> 
> Perhaps it "should" be the first (actually - I tend to agree),
> but it seems that it "is" the last.

No. If there is no "From:" at the top of the body, the authorship is taken 
from the "From:" from the _email_.

Which _usually_ matches the last Signed-off-line:, of course. But can be 
anything.

		Linus
