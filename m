Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262743AbVGMT6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbVGMT6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVGMT5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:57:11 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:57412 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262729AbVGMTzw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:55:52 -0400
Date: Wed, 13 Jul 2005 21:43:37 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Ian Campbell <ijc@hellion.org.uk>
Cc: kai@germaschewski.name, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow cscope to index multiple architectures
Message-ID: <20050713214337.GC16374@mars.ravnborg.org>
References: <1119522355.2995.23.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119522355.2995.23.camel@icampbell-debian>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 11:25:54AM +0100, Ian Campbell wrote:
> Hi,
> 
> I have a single source tree which I cross compile for a couple of
> different architectures using ARHC=foo O=blah etc.
> 
> The existing cscope target is very handy but only indexes the current
> $(ARCH), which is a pain since inevitably I'm interested in the other
> one at any given time ;-). This patch allows me to pass a list of
> architectures for cscope to index. e.g.
> 	make ALLSOURCE_ARCHS="i386 arm" cscope
> 
> This change also works for etags etc, and I presume it is just as useful
> there.

I cannot see how it will index i386 if I do not specify ALLSOURCES_ARCHS
(and I am running on a i386).

	Sam
