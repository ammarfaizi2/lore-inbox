Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313762AbSDUSZB>; Sun, 21 Apr 2002 14:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313760AbSDUSYw>; Sun, 21 Apr 2002 14:24:52 -0400
Received: from dsl-213-023-040-105.arcor-ip.net ([213.23.40.105]:49556 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313773AbSDUSYS>;
	Sun, 21 Apr 2002 14:24:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <garzik@havoc.gtf.org>, CaT <cat@zip.com.au>
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux tree
Date: Sat, 20 Apr 2002 20:23:49 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Larry McVoy <lm@bitmover.com>, Anton Altaparmakov <aia21@cantab.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <20020421175404.GL4640@zip.com.au> <20020421141200.D8142@havoc.gtf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16yzWX-0000lZ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 April 2002 20:12, Jeff Garzik wrote:
> On Mon, Apr 22, 2002 at 03:54:04AM +1000, CaT wrote:
> > That's what I meant. Email gets sent out to LKML when the patch gets sent
> > to BK for approval by Linus. Another email can then be sent out (unless
> > it's felt that it's too verbose to do so) when Linus accepts it into the
> > tree. (unless I'm missing something about BK ;)
> 
> This doesn't work -- there is no BK _push_ to Linus.  There is no "sent
> to BK for approval."
> 
> Traditional RFC822 email is sent to Linus, telling him that there are BK
> changesets to be picked up.  A human-defined length of time ensues,
> after which Linus either ignores or comments on the email, and either
> does a 'bk pull' or not.

At the moment I'm thinking about returning to the patchbot project (by the
way, code *is* available now) and reworking it to handle both BK and GNU
patches.  The advantage of the patchbot is, it can do things like sniff
patches for NOTIFYMEONCHANGE directives, auto-CC a linux-patches list,
etc.  It could act as an accumulator of GNU patches into a BK repository,
waiting for Linus to pull, and in the interim, all interested observers
could also peek into the repository.

Hmm, I'm sensing a practical project here.

> Very similar to the way GNU patches are handled, strangely enough ;-)

Yes, well that was never completely satisfying to say the least.  IMHO, BK
is helping improve the situation, but comes with its own issues, not all of
them technical.

-- 
Daniel
