Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292231AbSBTT1r>; Wed, 20 Feb 2002 14:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292229AbSBTT1h>; Wed, 20 Feb 2002 14:27:37 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:23559 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S292223AbSBTT1W>; Wed, 20 Feb 2002 14:27:22 -0500
Date: Wed, 20 Feb 2002 16:27:00 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Larry McVoy <lm@work.bitmover.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Larry McVoy <lm@bitmover.com>
Subject: Re: [PATCH] struct page, new bk tree
In-Reply-To: <20020220120751.B1506@lynx.adilger.int>
Message-ID: <Pine.LNX.4.44L.0202201625140.1413-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Andreas Dilger wrote:
> On Feb 19, 2002  15:57 -0800, Larry McVoy wrote:
> > On Tue, Feb 19, 2002 at 08:47:17PM -0300, Rik van Riel wrote:
> > > I've removed the old (broken) bitkeeper tree with the
> > > struct page changes and have put a new one in the same
> > > place ... with the struct page changes in one changeset
> > > with ready checkin comment.

> > developer goes back, cleans up the change, and repeats.  That's fine for
> > Linus & Rik because Linus tosses the changeset and Rik tosses it, but
> > what about the other people who have pulled?  Those changesets are now
> > wandering around in the network, just waiting to pop back into a tree.

> > We could have a --blacklist option to undo which says "undo these
> > changes but remember their "names" in the BitKeeper/etc/blacklist file.

> So what happens to the person who pulled the (now-blacklited) CSET in
> the first place?  If they do a pull from the repository where the original
> CSET lived, will the blacklisted CSET be undone and the replacement CSET
> be used in its place?

That's a good question.  I hadn't answered Larry before because
I just couldn't come up with what the implications of a blacklist
would be or how it would ever work ...

regards,

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

