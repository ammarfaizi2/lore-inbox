Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSH0VOs>; Tue, 27 Aug 2002 17:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSH0VOr>; Tue, 27 Aug 2002 17:14:47 -0400
Received: from [195.223.140.120] ([195.223.140.120]:17784 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317215AbSH0VOp>; Tue, 27 Aug 2002 17:14:45 -0400
Date: Tue, 27 Aug 2002 23:18:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Matthew Dobson <colpatch@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Martin Bligh <mjbligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] SImple Topology API v0.3 (1/2)
Message-ID: <20020827211814.GU25092@dualathlon.random>
References: <3D6537D3.3080905@us.ibm.com> <20020827143115.B39@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020827143115.B39@toy.ucw.cz>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 02:31:16PM +0000, Pavel Machek wrote:
> Hi!
> 
> > Andrew, Linus, et al:
> > 	Here's the latest version of the Simple Topology API.  I've broken the patches 
> > into a solely in-kernel portion, and a portion that exposes the API to 
> > userspace via syscalls and prctl.  This patch (part 1) is the in-kernel part. 
> > I hope that the smaller versions of these patches will draw more feedback, 
> > comments, flames, etc.  Other than that, the patch remains relatively unchanged 
> > from the last posting.
> 
> > -   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
> > +   bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
> 
> Why not simply CONFIG_NUMA?

that is just used by the common code, it fits well for that usage and it
has different semantics.

Andrea
