Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbTETJil (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 05:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263657AbTETJil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 05:38:41 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:8714 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263654AbTETJik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 05:38:40 -0400
Date: Tue, 20 May 2003 10:51:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
Message-ID: <20030520105116.A4609@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
	Ulrich Drepper <drepper@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030520085911.90EE72C232@lists.samba.org> <Pine.LNX.4.44.0305201100390.6448-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0305201100390.6448-100000@localhost.localdomain>; from mingo@elte.hu on Tue, May 20, 2003 at 11:03:36AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 11:03:36AM +0200, Ingo Molnar wrote:
> have you all gone nuts??? It's not an option to break perfectly working
> binaries out there.

Of course it is.  Linux has enough problem problems due to past mainline
stupidities, now we don't need to codify vendor braindamages aswell.  E.g
mainline doesn't have the RH AS aio vsyscall crap or suse's get dev_t behind
/dev/console stuff either.  If Red Hat thinks it needs to live with more interfaces
than what the stable kernel release provide their on their own luck.

And it's a lot of time to 2.6 anyway, don't tell me Jakub isn't smart enough to
get a glibc rpm out by then that works with the new and the old futex stuff.

