Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290028AbSA3Q07>; Wed, 30 Jan 2002 11:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289975AbSA3QZM>; Wed, 30 Jan 2002 11:25:12 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:48800
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S290018AbSA3QYS>; Wed, 30 Jan 2002 11:24:18 -0500
Date: Wed, 30 Jan 2002 09:23:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130162303.GN25973@opus.bloom.county>
In-Reply-To: <20020130080308.D18381@work.bitmover.com> <Pine.LNX.4.33L.0201301408540.11594-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0201301408540.11594-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 02:14:52PM -0200, Rik van Riel wrote:
> On Wed, 30 Jan 2002, Larry McVoy wrote:
> > On Wed, Jan 30, 2002 at 08:42:33AM -0700, Tom Rini wrote:
> > > On Tue, Jan 29, 2002 at 11:48:05PM -0800, Linus Torvalds wrote:
> > > It does in some ways anyhow.  Following things downstream is rather
> > > painless, but one of the things we in the PPC tree hit alot is when we
> > > have a new file in one of the sub trees and want to move it up to the
> > > 'stable' tree
> >
> > Summary: only an issue because Linus isn't using BK.
> 
> Bitkeeper also seems to have some problems applying out-of-order
> changesets or applying them partially.
> 
> Changesets sent by 'bk send' are also much harder to read than
> unidiffs ;)
> 
> I think for bitkeeper to be useful for the kernel we really need:
> 
> 1) 'bk send' format Linus can read easily

I think you can do bk send -u which spits out a unified diff in the
comments of the file or so.

> 2) the ability to send individual changes (for example, the
>    foo_net.c fixes from 1.324 and 1.350) in one nice unidiff

This is sort of what I was getting at, execpt in this case foo_net.c is
also a new file as well.  Myself and Paul haven't found a good way to do
this :(

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
