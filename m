Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310619AbSCHAhY>; Thu, 7 Mar 2002 19:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310628AbSCHAhO>; Thu, 7 Mar 2002 19:37:14 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:29193 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310619AbSCHAhJ>;
	Thu, 7 Mar 2002 19:37:09 -0500
Date: Thu, 7 Mar 2002 21:36:53 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
Cc: "Jonathan A. George" <JGeorge@greshamstorage.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
In-Reply-To: <3C880541.E04EFAB3@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0203072134490.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, Andrew Morton wrote:
> Rik van Riel wrote:
> > On Thu, 7 Mar 2002, Jonathan A. George wrote:

> > 4) distributed repositories
> >
> > 5) ability to exchange changesets by email
>
> These can probably be in version 2...

Actually, I doubt Linus would let us use his repository,
aside from the scalability problems you get with 2000
people trying to use the same repository...  ;)

> 1: If I have two changesets applied to a file, and I make a change to
>    that file, which changeset is it to be associated with?

> 2: The ability to move a set of changes from one changeset into
>    another one.  ie: split that damn patch up!

Could be solved with branches, but that's not too clean
either. Splitting up patches is a hard problem ...

> But as a starting point I'd say: changesets as a first-class-concept,
> and lots of integration with tkdiff.

Agreed, changesets, branches and merging are the first
priority.

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

