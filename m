Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292249AbSBTTxu>; Wed, 20 Feb 2002 14:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292254AbSBTTxl>; Wed, 20 Feb 2002 14:53:41 -0500
Received: from waste.org ([209.173.204.2]:33962 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S292249AbSBTTx3>;
	Wed, 20 Feb 2002 14:53:29 -0500
Date: Wed, 20 Feb 2002 13:53:06 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alexander Viro <viro@math.psu.edu>
cc: "Eric S. Raymond" <esr@thyrsus.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Of Bundling, Dao and Cowardice
In-Reply-To: <Pine.GSO.4.21.0202161146160.29124-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0202201308290.17985-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Feb 2002, Alexander Viro wrote:

> 	How does it work?  Simple - look at the path from original
> tree to tree with your modifications.  And no, "one big jump" doesn't
> count.  Think of the way your ideas can be split into parts.

At least the rule base change from imperative -> inferential seems to
necessarily entail a single very large atomic change, given the arch-wide
rules present in the rulebase. This is the heart of the thing, and
ignoring for a moment Alan's claim that it's unnecessary, it's not at all
obvious that there's an incremental approach here. Any hints?

Hanging off the translation are things like the interpreter for the new
language bringing it up to parity with the old interpreter, which is a
meaningless delta by itself, but without which the core change is useless.
The orthogonal changes are relatively minor.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

