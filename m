Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289314AbSA3PoG>; Wed, 30 Jan 2002 10:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289315AbSA3Pn4>; Wed, 30 Jan 2002 10:43:56 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:23712
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289314AbSA3Pnv>; Wed, 30 Jan 2002 10:43:51 -0500
Date: Wed, 30 Jan 2002 08:42:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130154233.GK25973@opus.bloom.county>
In-Reply-To: <E16Vp2w-0000CA-00@starship.berlin> <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 11:48:05PM -0800, Linus Torvalds wrote:
 
> -- tangential --
> 
> One thing intrigued me in this thread - which was not the discussion
> itself, but the fact that Rik is using bitkeeper.
> 
> How many other people are actually using bitkeeper already for the kernel?
> I know the ppc guys have, for a long time, but who else is? bk, unlike
> CVS, should at least be _able_ to handle a "network of people" kind of
> approach.

It does in some ways anyhow.  Following things downstream is rather
painless, but one of the things we in the PPC tree hit alot is when we
have a new file in one of the sub trees and want to move it up to the
'stable' tree, or when it shows up in your/marcelo's tree.  bk send only
works for same base tree type things (ie a clone of tree X, some
changes, not a clone of tree Y, which was a clone of tree X but has lots
of changes and has tree X changes pulled in frequently).  Unfortunaly I
don't think this is an easy problem to work on either.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
