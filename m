Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbTFBQYB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 12:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTFBQXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 12:23:54 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:28138 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264498AbTFBQXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 12:23:51 -0400
Date: Mon, 2 Jun 2003 18:37:04 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org, matsunaga <matsunaga_kazuhisa@yahoo.co.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
Message-ID: <20030602163704.GC679@wohnheim.fh-wedel.de>
References: <20030530144959.GA4736@wohnheim.fh-wedel.de> <002901c32919$ddc37000$570486da@w0a3t0> <20030602153656.GA679@wohnheim.fh-wedel.de> <1054568407.20369.382.camel@passion.cambridge.redhat.com> <20030602155353.GB679@wohnheim.fh-wedel.de> <1054569564.20369.385.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1054569564.20369.385.camel@passion.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 June 2003 16:59:25 +0100, David Woodhouse wrote:
> On Mon, 2003-06-02 at 16:53, Jörn Engel wrote:
> > Maybe lazy allocation.  vmalloc() it with the first write(), which
> > should be never in production use.  So the extra overhead doesn't
> > really matter.
> 
> Seems reasonable.

Patch is in CVS.

Not 100% sure about the correct return code, if the lazy allocation
fails.  Can you check that?

Matsunaga, I guess that the extra memory you now have on your machine
has more impact on performance than statical allocation would have.
Translate the saved memory into a monetary unit and you even have a
lart that works for managers.

Jörn

-- 
You can't tell where a program is going to spend its time. Bottlenecks
occur in surprising places, so don't try to second guess and put in a
speed hack until you've proven that's where the bottleneck is.
-- Rob Pike
