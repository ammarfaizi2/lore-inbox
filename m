Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263208AbSJaQ6K>; Thu, 31 Oct 2002 11:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSJaQ6K>; Thu, 31 Oct 2002 11:58:10 -0500
Received: from fe1.rdc-kc.rr.com ([24.94.163.48]:62994 "EHLO mail1.kc.rr.com")
	by vger.kernel.org with ESMTP id <S263208AbSJaQ6K>;
	Thu, 31 Oct 2002 11:58:10 -0500
Date: Thu, 31 Oct 2002 11:04:56 -0600 (CST)
From: Ognen Duzlevski <ognen@kc.rr.com>
X-X-Sender: ognen@gemelli.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: include/net/dst.h and linux 2.5.45
Message-ID: <Pine.LNX.4.44.0210311102400.15692-100000@gemelli.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/ipv4/netfilter/ipt_TCPMSS.c: In function `ipt_tcpmss_target':
net/ipv4/netfilter/ipt_TCPMSS.c:88: structure has no member named `pmtu'
net/ipv4/netfilter/ipt_TCPMSS.c:91: structure has no member named `pmtu'
net/ipv4/netfilter/ipt_TCPMSS.c:95: structure has no member named `pmtu'
make[3]: *** [net/ipv4/netfilter/ipt_TCPMSS.o] Error 1
make[2]: *** [net/ipv4/netfilter] Error 2
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2
--

unsigned pmtu; has been removed from the dst_entry structure in
include/net/dsh.h. I am not a kernel hacker so I am not sure what the
problem is.

Thank you,
Ognen

