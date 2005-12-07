Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVLGKRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVLGKRU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVLGKRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:17:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40422 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750775AbVLGKRT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:17:19 -0500
Date: Wed, 7 Dec 2005 10:17:08 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Arnd Bergmann <arnd@arndb.de>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [PATCH 02/14] spufs: fix local store page refcounting
Message-ID: <20051207101708.GJ27946@ftp.linux.org.uk>
References: <20051206035220.097737000@localhost> <200512061118.19633.arnd@arndb.de> <1133869108.7968.1.camel@localhost> <200512061949.33482.arnd@arndb.de> <1133895947.3279.4.camel@localhost> <17301.65082.251692.675360@cargo.ozlabs.ibm.com> <1133905298.8027.13.camel@localhost> <17302.3696.364669.18755@cargo.ozlabs.ibm.com> <20051207022610.GI27946@ftp.linux.org.uk> <17302.21437.608048.64857@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17302.21437.608048.64857@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 02:15:09PM +1100, Paul Mackerras wrote:
> Al Viro writes:
> 
> > FWIW, I think it's not a serious argument.  Interface changes => grep time.
> > And that means grep over the tree anyway.
> 
> OK, well, where would you prefer the spufs code to go?

Up to ppc folks, really - I don't see any serious objections to arch/powerpc/
variants; it could go there, it could go to fs/*.  Objections along the lines
of "it won't be found" are BS - any interface change is going to start with
grep over the entire tree anyway.
 
> > That's solved by asking for review...
> 
> Could you review the spufs code (i.e. the patches posted by Arnd
> recently to linuxppc64-dev@ozlabs.org) please?

If it's what you have in powerpc.git - see comments on IRC yesterday...
