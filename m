Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbTETNzc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 09:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263785AbTETNzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 09:55:32 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:47883 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263781AbTETNzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 09:55:31 -0400
Date: Tue, 20 May 2003 15:08:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] futex patches, futex-2.5.69-A2
Message-ID: <20030520150826.A18282@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
	Ulrich Drepper <drepper@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030520105116.A4609@infradead.org> <Pine.LNX.4.44.0305201412260.10571-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0305201412260.10571-100000@localhost.localdomain>; from mingo@elte.hu on Tue, May 20, 2003 at 02:56:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 02:56:42PM +0200, Ingo Molnar wrote:
> it's not vendor braindamage.

I didn't sayd sys_futex is vendor braindamage.  The problem is that vendors
think they need to put all the unstable features into their release tree.
There's a reaaon those aren';t in the released stable kernels.

> you dont understand, do you? There are very valid and perfectly working
> glibc installations [and maybe NGPT installations, futex users, etc.] out
> there that will break if you remove sys_futex(). No amount of rpm hacking
> will fix them up.

And they'll break if you run _any_ released stable kernel, so what?
Let the vendors fix the mess they introduced by backporting unstable features
instead of burdening it up on mainline.

