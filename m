Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265269AbSJRRb7>; Fri, 18 Oct 2002 13:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265325AbSJRR1d>; Fri, 18 Oct 2002 13:27:33 -0400
Received: from sentry.gw.tislabs.com ([192.94.214.100]:52698 "EHLO
	sentry.gw.tislabs.com") by vger.kernel.org with ESMTP
	id <S265269AbSJRRJY>; Fri, 18 Oct 2002 13:09:24 -0400
Date: Fri, 18 Oct 2002 13:15:04 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
X-X-Sender: <sds@raven>
To: Christoph Hellwig <hch@infradead.org>
cc: <linux-kernel@vger.kernel.org>, <linux-security-module@wirex.com>
Subject: Re: [PATCH] remove sys_security
In-Reply-To: <20021018173339.A7481@infradead.org>
Message-ID: <Pine.GSO.4.33.0210181239310.9847-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Oct 2002, Christoph Hellwig wrote:

> It adds infrastructure to implement syscalls without peer review.
> And then it ends being crap like the selinux syscalls.

Yes, I think you've made your point.  Go ahead, remove sys_security.
We can look into revising the SELinux syscalls, hopefully with some
constructive suggestions from people, to make them more acceptable.
Feel free to send specific suggestions, or at least explain further why
you hate the current ones.

> And exactly these hooks harm.  They are all over the place, have performance
> and code size impact and mess up readability.  Why can't you just maintain
> an external patch like i.e. mosix folks that nead similar deep changes?

LSM only came into existence based on Linus' statements about what he
would be willing to consider for inclusion in the mainstream kernel.  Of
course, if LSM has diverged from Linus' expectations, then that divergence
should be corrected.  But that doesn't mean that LSM should be dropped out
entirely, just pruned and refined.  If the whole of LSM has to be
maintained as a separate patch, then the various security projects have
largely wasted their time transitioning to it.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







