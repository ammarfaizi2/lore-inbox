Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282058AbRKVHJI>; Thu, 22 Nov 2001 02:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282059AbRKVHI6>; Thu, 22 Nov 2001 02:08:58 -0500
Received: from krista.yaroslavl.ru ([217.15.132.26]:10003 "EHLO
	mailserv.rybinsk.ru") by vger.kernel.org with ESMTP
	id <S282058AbRKVHIo>; Thu, 22 Nov 2001 02:08:44 -0500
Date: Thu, 22 Nov 2001 10:08:34 +0300 (MSK)
From: Dmitri Popov <popov@krista.ru>
To: Robert Love <rml@tech9.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/Changes
In-Reply-To: <1006361415.1307.3.camel@icbm>
Message-ID: <Pine.LNX.4.31.0111221003100.24032-100000@popov.krista.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Nov 2001, Robert Love wrote:

> > I'd like to note that there is nothing abount quota tools in
> > Documentation/Changes. I tried to use one of Alan Cox kernels some weeks
> > ago, and was very surprised, when quota utilities 2.00 stopped working.
> > And I didn't find any information about correct quota tools in all the
> > source tree! At last I searched for the latest quota-tools in the Internet
> > (ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/utils/)
> > and installed it. Now it works. As I can understand, the current 2.4.*
> > will also need new utilities.
>
> I believe Alan's tree had 32-bit quota support, which requires a
> different version of quota-tools. If you return to Linus's tree, your
> original version will work.
>
> For what its worth, Linus has finally merged much of Alan's tree into
> his own, and is pretty much done as of 2.4.15-pre.  32-bit quotas were
> _not_ merged.

Thank you for this information. According to documentation, new
quota-tools know about both old and new quota formats, so I don't need to
downgrade now. My personal part of the problem is solved. But I can't
didn't find any information about minimum quota-tools version in
neither Linus's, nor Alan's kernel. Although versions of other utilities
are listed in Changes.

-- 
Dmitri Popov, mailto:popov@krista.ru

