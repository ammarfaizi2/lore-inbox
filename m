Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263380AbUEWTEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbUEWTEI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 15:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbUEWTEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 15:04:07 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:26765 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263380AbUEWTBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 15:01:43 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 23 May 2004 12:01:42 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0405231159240.512@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2004, Linus Torvalds wrote:

> The plan is to make this very light-weight, and to fit in with how we 
> already pass patches around - just add the sign-off to the end of the 
> explanation part of the patch. That sign-off would be just a single line 
> at the end (possibly after _other_ peoples sign-offs), saying:
> 
> 	Signed-off-by: Random J Developer <random@developer.org>
> 
> To keep the rules as simple as possible, and yet making it clear what it
> means to sign off on the patch, I've been discussing a "Developer's
> Certificate of Origin" with a random collection of other kernel
> developers (mainly subsystem maintainers).  This would basically be what
> a developer (or a maintainer that passes through a patch) signs up for
> when he signs off, so that the downstream (upstream?) developers know
> that it's all ok:
> 
> 	Developer's Certificate of Origin 1.0
> 
> 	By making a contribution to this project, I certify that:
> 
> 	(a) The contribution was created in whole or in part by me and I
>             have the right to submit it under the open source license
> 	    indicated in the file; or
> 
> 	(b) The contribution is based upon previous work that, to the best
> 	    of my knowledge, is covered under an appropriate open source
> 	    license and I have the right under that license to submit that
> 	    work with modifications, whether created in whole or in part
> 	    by me, under the same open source license (unless I am
> 	    permitted to submit under a different license), as indicated
> 	    in the file; or
> 
> 	(c) The contribution was provided directly to me by some other
> 	    person who certified (a), (b) or (c) and I have not modified
> 	    it.

Andrew already puts the "From:" thing in the patch comment, so this should 
be simply a matter of replacing "From:" with "Signed-off-by:", preserving 
it in logs, and documenting the thing in the patch submission doc. No?



- Davide

