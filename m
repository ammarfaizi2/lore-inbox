Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261964AbTCLVfC>; Wed, 12 Mar 2003 16:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262065AbTCLVfC>; Wed, 12 Mar 2003 16:35:02 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:46762 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261964AbTCLVe4>; Wed, 12 Mar 2003 16:34:56 -0500
Date: Wed, 12 Mar 2003 15:45:39 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
In-Reply-To: <20030312211832.GA6587@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0303121541190.19251-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Mar 2003, Larry McVoy wrote:

> > Larry, this brings up something I was meaning to ask you before this
> > thread exploded.  What happens to those "logical change" numbers over
> > time?
> 
> They are stable in the CVS tree because the CVS tree isn't distributed.
> So "Logical change 1.900" in the context of the exported CVS tree is 
> always the same thing.  That's one advantage centralized has, things
> don't shift around on you.

Isn't there a more general problem, though? (I hope I'm wrong)

You want to update the CVS tree near-realtime. However, the longest-path
through your graph may change with new merges, but CVS of course cannot
cope with already committed data changing (already committed csets may 
all of a sudden not be in the longest path anymore)? This is a CVS 
limitation, of course, but still a problem AFAICS.

--Kai


