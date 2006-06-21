Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWFURio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWFURio (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWFURio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:38:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18440 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932286AbWFURin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:38:43 -0400
Date: Wed, 21 Jun 2006 19:38:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Theodore Tso <tytso@mit.edu>, Randy Dunlap <randy.dunlap@oracle.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       bcollins@ubuntu.com, akpm@osdl.org
Subject: Re: reviewing Ubuntu kernel patches
Message-ID: <20060621173841.GH9111@stusta.de>
References: <44909A1D.3030404@oracle.com> <1150386150.2987.9.camel@laptopd505.fenrus.org> <44924425.1040501@oracle.com> <20060616140334.GA24491@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060616140334.GA24491@thunk.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 10:03:34AM -0400, Theodore Tso wrote:
> On Thu, Jun 15, 2006 at 10:39:49PM -0700, Randy Dunlap wrote:
> > Certainly a good question IMO.  If Andrew or Linus knows whether
> > I need to add my Signed-off-by, I'll be glad to listen.
> > (That's not a general call for opinions.)
> 
> If you're submitting the patch, then surely you need to add your
> Signed-off-by:, since you're asserting either (b) or (c):
> 
>         (b) The contribution is based upon previous work that, to the best
>             of my knowledge, is covered under an appropriate open source
>             license and I have the right under that license to submit that
>             work with modifications, whether created in whole or in part
>             by me, under the same open source license (unless I am
>             permitted to submit under a different license), as indicated
>             in the file; or
> 
>         (c) The contribution was provided directly to me by some other
>             person who certified (a), (b) or (c) and I have not modified
>             it.
> 
> We've gotten into the habit of assuming the Signed-off-by: also has
> the meaning of "I vouch for it from technical point of view", but
> really, that's presumably true since otherwise you wouldn't have
> e-mailed it to Andrew or Linus.  The original meaning of the
> Signed-off-by: is in the Developer's Certificate of Origin
> statement...

Re-reading this text, I'm getting some doubts whether the way Andrew 
handles this when merging patches is correct:

When Andrew merges some small fix into an existing patch in -mm
(e.g. "make a function static" or "fix a compile error"), he adds the 
Signed-off-by line of the small fix to the Signed-off-by lines of the 
patch.

But the submitter of the fix does not necessarly have checked the 
legal or technical status of the rest of the patch.

As an example, my only contribution to commit 
6b3934ef52712ece50605dfc72e55d00c580831a was making signal_cachep 
static, and I do refuse any legal or technical responsibility for 
the rest of the patch (this shouldn't imply the rest of the patch was 
bad - it's simply not me who can is responsible for it).

> 						- Ted

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

