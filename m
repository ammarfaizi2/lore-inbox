Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272244AbTHDWFw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 18:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272265AbTHDWFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 18:05:52 -0400
Received: from tandu.perlsupport.com ([66.220.6.226]:22217 "EHLO
	tandu.perlsupport.com") by vger.kernel.org with ESMTP
	id S272244AbTHDWFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 18:05:51 -0400
Date: Mon, 4 Aug 2003 18:05:34 -0400
From: Chip Salzenberg <chip@pobox.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.22pre10: fs/aio.c should include <linux/poll.h>
Message-ID: <20030804220534.GE1751@perlsupport.com>
References: <20030804170900.GA8221@perlsupport.com> <20030804230213.B6566@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804230213.B6566@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Christoph Hellwig:
> On Mon, Aug 04, 2003 at 01:09:00PM -0400, Chip Salzenberg wrote:
> > Since fs/aio.c calls async_poll(), it should include <linux/poll.h> to
> > get its declaration.
> 
> There is no fs/aio.c in 2.4.22-pre10.

Oops.  It must be an 'aa' thing.  I'll take this off line with Andrea.
-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
