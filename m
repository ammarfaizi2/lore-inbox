Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbSIXFjw>; Tue, 24 Sep 2002 01:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSIXFjw>; Tue, 24 Sep 2002 01:39:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:6812 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261572AbSIXFjv>;
	Tue, 24 Sep 2002 01:39:51 -0400
Date: Tue, 24 Sep 2002 07:53:31 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Larry McVoy <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <20020923190306.D13340@hexapodia.org>
Message-ID: <Pine.LNX.4.44.0209240748480.8943-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Sep 2002, Andy Isaacson wrote:

> > 90% of the programs that matter behave exactly like Larry has described.
> > IO is the main source of blocking. Go and profile a busy webserver or
> > mailserver or database server yourself if you dont believe it.
> 
> There are heavily-threaded programs out there that do not behave this
> way, and for which a N:M thread model is completely appropriate. [...]

of course, that's the other 10%. [or even smaller.] I never claimed M:N
cannot be viable for certain specific applications. But a generic
threading library should rather concentrate on the common 90% of the
applications.

(obviously for simulations the absolute fastest implementation would be a
pure userspace state-machine, not a threaded application - M:N or 1:1.)

	Ingo

