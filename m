Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265728AbSKAUIB>; Fri, 1 Nov 2002 15:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265729AbSKAUIB>; Fri, 1 Nov 2002 15:08:01 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:24502 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265728AbSKAUIA>;
	Fri, 1 Nov 2002 15:08:00 -0500
Date: Fri, 1 Nov 2002 20:14:14 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Charlie Krasic <krasic@acm.org>
Cc: Dan Kegel <dank@kegel.com>, Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021101201414.GB1654@bjl1.asuk.net>
References: <Pine.LNX.4.44.0210311043380.1562-100000@blue1.dev.mcafeelabs.com> <3DC2BCF5.5010607@kegel.com> <20021101191643.GA1471@bjl1.asuk.net> <xu43cqlys2r.fsf@turing.cse.ogi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xu43cqlys2r.fsf@turing.cse.ogi.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charlie Krasic wrote:
> I would like to see a new kind of nonblocking flag that implies the
> use of epoll.  So instead of giving O_NONBLOCK to fctnl(F_SETFL), you
> give O_NONBLOCK_EPOLL.  In addition to becoming non-blocking, the
> socket is added to epoll interest set.  Furthermore, if the socket is
> a "listener" socket, all connections accepted on the socket inherit
> the non-blocking status and are added automatically to the same epoll
> interest set.  It's true that this can get silly though.  I'd like to
> do the same with other flags, like TCP_CORK.

... and close-on-exec.

-- Jamie
