Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUGKUTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUGKUTh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 16:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266652AbUGKUTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 16:19:37 -0400
Received: from hera.kernel.org ([63.209.29.2]:54665 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266650AbUGKUTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 16:19:34 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH] Fix building on Solaris (and don't break Cygwin)
Date: Sun, 11 Jul 2004 20:19:14 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ccs7c2$bef$1@terminus.zytor.com>
References: <20040709210011.GG28002@smtp.west.cox.net> <20040709211605.GA6126@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1089577154 11728 127.0.0.1 (11 Jul 2004 20:19:14 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 11 Jul 2004 20:19:14 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040709211605.GA6126@infradead.org>
By author:    Christoph Hellwig <hch@infradead.org>
In newsgroup: linux.dev.kernel
>
> On Fri, Jul 09, 2004 at 02:00:11PM -0700, Tom Rini wrote:
> > The following is from Jean-Christophe Dubois <jdubois@mc.com>.  On
> > Solaris 2.8, <stdint.h> does not exist, but <inttypes.h> does.  However,
> > on cygwin (the other odd place that the kernel is compiled on)
> > <inttypes.h> doesn't exist.  So we end up with something like the
> > following.
> > Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> 
> Yikes.  <stdint.h> is mandated by C99, please complain to sun instead or
> write up the header yourself - it's not that difficult anyway.
> 

<inttypes.h> is also mandated by C99, and is a more complete header
(it includes stdint.h).

	-hpa
