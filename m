Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135708AbRDSUwT>; Thu, 19 Apr 2001 16:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135707AbRDSUwK>; Thu, 19 Apr 2001 16:52:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54410 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135704AbRDSUvy>;
	Thu, 19 Apr 2001 16:51:54 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15071.20454.623976.549733@pizda.ninka.net>
Date: Thu, 19 Apr 2001 13:51:50 -0700 (PDT)
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sk->state_chage is not called for listening sockets
In-Reply-To: <20010413025143.A24741@devserv.devel.redhat.com>
In-Reply-To: <20010413025143.A24741@devserv.devel.redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pete Zaitcev writes:
 > With that in mind, would the following chage have any ill effects?
 > It does not seem to break anything obvious, but I am worried about
 > a performance degradation for some retarded benchmark.
 > 
 > diff -u -U 4 linux-2.4.3/net/ipv4/tcp_input.c linux-2.4.3-nfs/net/ipv4/tcp_input.c
 > --- linux-2.4.3/net/ipv4/tcp_input.c	Fri Feb  9 11:34:13 2001
 > +++ linux-2.4.3-nfs/net/ipv4/tcp_input.c	Thu Apr 12 23:23:59 2001

I've applied this patch, thanks.

Later,
David S. Miller
davem@redhat.com
