Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290751AbSA3XiV>; Wed, 30 Jan 2002 18:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290747AbSA3Xhd>; Wed, 30 Jan 2002 18:37:33 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24912 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S290746AbSA3XhP>; Wed, 30 Jan 2002 18:37:15 -0500
Date: Thu, 31 Jan 2002 00:38:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 18pre7aa1 pagetable corroops
Message-ID: <20020131003829.N1309@athlon.random>
In-Reply-To: <20020130212757.K1309@athlon.random> <Pine.LNX.4.21.0201302119130.1357-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0201302119130.1357-100000@localhost.localdomain>; from hugh@veritas.com on Wed, Jan 30, 2002 at 09:23:12PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 09:23:12PM +0000, Hugh Dickins wrote:
> On Wed, 30 Jan 2002, Andrea Arcangeli wrote:
> > 
> > right, thanks. BTW, I kept the other fixmap_init code beause of the many
> > more BUG() checks (like the PTRS_PER_PMD checks with PAE) and because
> > it is equivalent after all.
> 
> No, not equivalent, see other mail.  Do add BUG()s to mine if you like,
> but they've not served well so far, and are not very helpful that early:
> more a sign of insecurity.

I don't agree they're a sign of insecurity, I think it's the other way
around. anyways I'll check your other email in detail now, thanks.

Andrea
