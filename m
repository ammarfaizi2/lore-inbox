Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289867AbSA3QN1>; Wed, 30 Jan 2002 11:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289735AbSA3QNA>; Wed, 30 Jan 2002 11:13:00 -0500
Received: from bitmover.com ([192.132.92.2]:28325 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S289395AbSA3QLj>;
	Wed, 30 Jan 2002 11:11:39 -0500
Date: Wed, 30 Jan 2002 08:11:34 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130081134.F18381@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
	Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
	Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <E16Vp2w-0000CA-00@starship.berlin> <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com> <20020130154233.GK25973@opus.bloom.county> <20020130080308.D18381@work.bitmover.com> <20020130160707.GL25973@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020130160707.GL25973@opus.bloom.county>; from trini@kernel.crashing.org on Wed, Jan 30, 2002 at 09:07:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 09:07:07AM -0700, Tom Rini wrote:
> On Wed, Jan 30, 2002 at 08:03:08AM -0800, Larry McVoy wrote:
> > On Wed, Jan 30, 2002 at 08:42:33AM -0700, Tom Rini wrote:
> > > On Tue, Jan 29, 2002 at 11:48:05PM -0800, Linus Torvalds wrote:
> > > It does in some ways anyhow.  Following things downstream is rather
> > > painless, but one of the things we in the PPC tree hit alot is when we
> > > have a new file in one of the sub trees and want to move it up to the
> > > 'stable' tree
> > 
> > Summary: only an issue because Linus isn't using BK.
> 
> Then how do we do this in the bk trees period?  To give a concrete
> example, I want to move arch/ppc/platforms/prpmc750_setup.c from
> 2_4_devel into 2_4, without loosing history.  How?  And just this file
> and not all of _devel.

That question doesn't parse.  There are multiple ways you can do it but 
once you do patches will no longer import cleanly from Linus.  The whole
point of the pristine tree is to give yourself a tree into which you can
import Linus patches.  If you start putting extra stuff in there you will
get patch rejects.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
