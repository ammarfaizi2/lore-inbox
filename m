Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTETPx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 11:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263825AbTETPx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 11:53:56 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60334 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id S263775AbTETPxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 11:53:55 -0400
Date: Tue, 20 May 2003 18:02:07 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] futex patches, futex-2.5.69-A2
In-Reply-To: <20030520150826.A18282@infradead.org>
Message-ID: <Pine.LNX.4.44.0305201748020.14480-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 May 2003, Christoph Hellwig wrote:

> > you dont understand, do you? There are very valid and perfectly working
> > glibc installations [and maybe NGPT installations, futex users, etc.] out
> > there that will break if you remove sys_futex(). No amount of rpm hacking
> > will fix them up.
>
> And they'll break if you run _any_ released stable kernel, so what?

you havent ever used Ulrich's nptl-enabled glibc, have you? It will boot
on any 2.4.1+ kernel, with and without nptl/tls support. It switches the
threading implementation depending on the kernel features it detects.

	Ingo

