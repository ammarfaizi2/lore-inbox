Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbUEJWv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUEJWv1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUEJWtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:49:39 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:11793 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262810AbUEJWsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:48:20 -0400
Date: Mon, 10 May 2004 23:48:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040510234819.A8743@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040510024506.1a9023b6.akpm@osdl.org> <20040510223755.A7773@infradead.org> <20040510150203.3257ccac.akpm@osdl.org> <20040510230558.A8159@infradead.org> <20040510151554.49965f1d.akpm@osdl.org> <20040510232038.A8331@infradead.org> <20040510154706.6291e264.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040510154706.6291e264.akpm@osdl.org>; from akpm@osdl.org on Mon, May 10, 2004 at 03:47:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 03:47:06PM -0700, Andrew Morton wrote:
> > So yeah, although it's a hack too it's
> > much much better than the junk that just went into Linus tree.
> 
> Untrue.  With the system-wide thing unprivileged local users can
> trivially DoS the database.

Well, that's your problem if you oracle.  At least we don't get magic
groups.

> > Why btw do we have a staging tree if such sensitive patches go into
> > mainline without proper review after just one day?
> 
> It was discussed on lkml, then later was dicussed extensively off-list
> and I lost track of how long it had been in -mm.  Sorry.

Umm, the two patches appeared in -mm yesterday..

> > When did shm segments come into the play?  I know we bolted hugetlb
> > support onto the back of the already horrible sysv shm interface, but
> > if people want additional interfaces ontop of that they should use
> > the proper mmap api.
> 
> Rewriting Oracle isn't a practical alternative.

So we can rewrite the kernel but oracle can be fixed?  I mean they
have thousands of programmers and can't fix they Database to use a sane
API?  I'd even fix it up for them in an hour or two if they gave me the
sources..
