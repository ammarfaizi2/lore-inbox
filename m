Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262663AbTDARBS>; Tue, 1 Apr 2003 12:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262670AbTDARBS>; Tue, 1 Apr 2003 12:01:18 -0500
Received: from rth.ninka.net ([216.101.162.244]:8120 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S262663AbTDARBR> convert rfc822-to-8bit;
	Tue, 1 Apr 2003 12:01:17 -0500
Subject: Re: assertion failed in tcp.c & af_inet.c
From: "David S. Miller" <davem@redhat.com>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <yw1xy92wxt8c.fsf@zaphod.guide>
References: <yw1xy92wxt8c.fsf@zaphod.guide>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1049217138.3938.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Apr 2003 09:12:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-30 at 16:41, Måns Rullgård wrote:
> I keep getting these messages in the kernel log:
> 
> KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229)
> KERNEL: assertion ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed at af_inet.c(689)
> 
> It seems to be related to accepting an incoming connection.
> 
> The kernel is 2.4.21-pre4 on Alpha.  The machine is behind a firewall
> that forwards connections so some ports to this machine.

Fixed in 2.4.21-pre5 and later.

-- 
David S. Miller <davem@redhat.com>
