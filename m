Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290619AbSA3VVJ>; Wed, 30 Jan 2002 16:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290618AbSA3VVH>; Wed, 30 Jan 2002 16:21:07 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:17243 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S290611AbSA3VUz>; Wed, 30 Jan 2002 16:20:55 -0500
Date: Wed, 30 Jan 2002 21:23:12 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 18pre7aa1 pagetable corroops
In-Reply-To: <20020130212757.K1309@athlon.random>
Message-ID: <Pine.LNX.4.21.0201302119130.1357-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Andrea Arcangeli wrote:
> 
> right, thanks. BTW, I kept the other fixmap_init code beause of the many
> more BUG() checks (like the PTRS_PER_PMD checks with PAE) and because
> it is equivalent after all.

No, not equivalent, see other mail.  Do add BUG()s to mine if you like,
but they've not served well so far, and are not very helpful that early:
more a sign of insecurity.

Hugh

