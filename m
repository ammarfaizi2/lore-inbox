Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290306AbSA3SO2>; Wed, 30 Jan 2002 13:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290282AbSA3SND>; Wed, 30 Jan 2002 13:13:03 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:21510 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289912AbSA3QPP>;
	Wed, 30 Jan 2002 11:15:15 -0500
Date: Wed, 30 Jan 2002 14:14:52 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>, <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020130080308.D18381@work.bitmover.com>
Message-ID: <Pine.LNX.4.33L.0201301408540.11594-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Larry McVoy wrote:
> On Wed, Jan 30, 2002 at 08:42:33AM -0700, Tom Rini wrote:
> > On Tue, Jan 29, 2002 at 11:48:05PM -0800, Linus Torvalds wrote:
> > It does in some ways anyhow.  Following things downstream is rather
> > painless, but one of the things we in the PPC tree hit alot is when we
> > have a new file in one of the sub trees and want to move it up to the
> > 'stable' tree
>
> Summary: only an issue because Linus isn't using BK.

Bitkeeper also seems to have some problems applying out-of-order
changesets or applying them partially.

Changesets sent by 'bk send' are also much harder to read than
unidiffs ;)

I think for bitkeeper to be useful for the kernel we really need:

1) 'bk send' format Linus can read easily

2) the ability to send individual changes (for example, the
   foo_net.c fixes from 1.324 and 1.350) in one nice unidiff

3) the ability for Linus to apply patches that are slightly
   "out of order" - a direct consequence of (2)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

