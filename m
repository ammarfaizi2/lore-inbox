Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265758AbSJTEO4>; Sun, 20 Oct 2002 00:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265760AbSJTEO4>; Sun, 20 Oct 2002 00:14:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9176 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265758AbSJTEO4>;
	Sun, 20 Oct 2002 00:14:56 -0400
Date: Sat, 19 Oct 2002 21:13:07 -0700 (PDT)
Message-Id: <20021019.211307.00017347.davem@redhat.com>
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: only produce one record in fib_seq_show
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021020010331.GB15254@conectiva.com.br>
References: <20021020000943.GL14009@conectiva.com.br>
	<20021019.173806.111570656.davem@redhat.com>
	<20021020010331.GB15254@conectiva.com.br>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Sat, 19 Oct 2002 22:03:31 -0300
   
   We'll, if everybody stopped using net-tools and started using iproute2 the
   world would be a better place

'iproute2' would need to be able to obtain things, such as
the snmp statistics, some other way.  Currently /proc/net/snmp
is the only place these values are provided.

Ditto for UDP socket listings et al.  Only tcp_diag has moved
the TCP socket information into the non-proc realm of netlink.

If these facilities existed already, I'd agree with you.
:-)
