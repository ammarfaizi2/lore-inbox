Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbTBQEeX>; Sun, 16 Feb 2003 23:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbTBQEeX>; Sun, 16 Feb 2003 23:34:23 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:22656 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S266718AbTBQEeX>; Sun, 16 Feb 2003 23:34:23 -0500
Date: Mon, 17 Feb 2003 04:46:59 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Werner Almesberger <wa@almesberger.net>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
Message-ID: <20030217044659.GB16137@bjl1.jlokier.co.uk>
References: <Pine.LNX.4.44.0302131120280.2076-100000@home.transmeta.com> <Pine.LNX.4.50.0302131215140.1869-100000@blue1.dev.mcafeelabs.com> <20030215010837.D2791@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030215010837.D2791@almesberger.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> Davide Libenzi wrote:
> > What do you think about having timers through a file interface ?
> 
> Maybe I'm missing something obvious, but couldn't you simply
> do this with a signal handler that writes to (a) pipe(s) ?

You can do that, and sometimes it is done, but the point is to provide
a mechanism with is _fast_, as epoll() is.

-- Jamie
