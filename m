Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278659AbRJSU7S>; Fri, 19 Oct 2001 16:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278660AbRJSU7J>; Fri, 19 Oct 2001 16:59:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46213 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278659AbRJSU65>;
	Fri, 19 Oct 2001 16:58:57 -0400
Date: Fri, 19 Oct 2001 13:59:24 -0700 (PDT)
Message-Id: <20011019.135924.112609345.davem@redhat.com>
To: ak@muc.de
Cc: sim@netnation.com, linux-kernel@vger.kernel.org
Subject: Re: Awfully slow /proc/net/tcp, netstat, in.identd in 2.4 (updated)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <k23d4fwkv6.fsf@zero.aec.at>
In-Reply-To: <20011019145750.A22193@zero.firstfloor.org>
	<20011019085944.A16467@netnation.com>
	<k23d4fwkv6.fsf@zero.aec.at>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think Alexey's netlink socket querying mechanism is the way
to go for this.  Once Alexey sends me an updated version of
these changes, I will put them in and identd can be fixed to
make use of it.  BTW, what does identd need netstat information
for?

And, for a 640MB ram machine, a 4MB hash table is perfectly
reasonable.

Franks a lot,
David S. Miller
davem@redhat.com
