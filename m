Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262706AbRFMJy7>; Wed, 13 Jun 2001 05:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262715AbRFMJyj>; Wed, 13 Jun 2001 05:54:39 -0400
Received: from gandalf.uznam.net.pl ([195.205.28.2]:5907 "EHLO
	gandalf.uznam.net.pl") by vger.kernel.org with ESMTP
	id <S262706AbRFMJyi>; Wed, 13 Jun 2001 05:54:38 -0400
Date: Wed, 13 Jun 2001 11:52:27 +0200
From: Michal Margula <alchemyx@uznam.net.pl>
To: linux-kernel@vger.kernel.org
Subject: Summary of Error no buffer space available
Message-ID: <20010613115227.A3023@cerber.uznam.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux 2.2.19 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I got plenty of replies. Thanks. Playing with
/proc/sys/net/ipv4/neigh/default/gc_thresh{2,3} helped. The funny thing
is that there are no more ENOBUFS problems - I am guessing that in
2.2.19 buffer of TCP is bigger than in 2.4.x, or something...

People asked me about more details of oopses I had with 2.4.5. Sorry I
don't have any data that could help and I won't try 2.4.x again, until 2.4.20 comes out :)

Andi Kleen said that my problems with 2.4.x and ENOBUFS should be fixed
after changing some things in /proc/sys/net/ipv4/tcp_mem, net/core/[rw]mem_{max,default}.

Thank you once again :)

-- 
Michal Margula, alchemyx@uznam.net.pl, ICQ UIN 12267440, +)
http://uznam.net.pl/~alchemyx/, Polish section of Linux Counter maintainer
