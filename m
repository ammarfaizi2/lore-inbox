Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261807AbTCLVdg>; Wed, 12 Mar 2003 16:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261876AbTCLVdg>; Wed, 12 Mar 2003 16:33:36 -0500
Received: from willow.seitz.com ([146.145.147.180]:16144 "EHLO
	willow.seitz.com") by vger.kernel.org with ESMTP id <S261807AbTCLVdf>;
	Wed, 12 Mar 2003 16:33:35 -0500
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Wed, 12 Mar 2003 16:44:21 -0500
To: linux-kernel@vger.kernel.org
Subject: assertion (newsk->state != TCP_SYN_RECV)
Message-ID: <20030312214421.GB20408@willow.seitz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently noticed these messages bouncing up in my logs every now
and again.  It's always with a particular machine, one that runs 2.4.20.

Google turns up one other post, made on Mon Jan 13
(http://hypermail.idiosynkrasia.net/linux-kernel/archived/2003/week02/0308.html)
but no responses or explanations followed.

Any word on what this means or if it's a problem?

Mar 11 12:56:51 ash kernel: KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229) 
Mar 11 12:56:51 ash kernel: KERNEL: assertion ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed at af_inet.c(689) 
Mar 11 12:56:51 ash kernel: KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229) 
Mar 11 12:56:51 ash kernel: KERNEL: assertion ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed at af_inet.c(689) 
Mar 11 12:56:51 ash kernel: KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229) 
Mar 11 12:56:51 ash kernel: KERNEL: assertion ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed at af_inet.c(689) 
Mar 11 12:57:01 ash kernel: KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229) 
Mar 11 12:57:01 ash kernel: KERNEL: assertion ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed at af_inet.c(689) 
Mar 11 12:57:01 ash kernel: KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229) 
Mar 11 12:57:01 ash kernel: KERNEL: assertion ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed at af_inet.c(689) 
Mar 11 12:57:01 ash kernel: KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229) 
Mar 11 12:57:01 ash kernel: KERNEL: assertion ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed at af_inet.c(689) 

-- 
Ross Vandegrift
ross@willow.seitz.com

A Pope has a Water Cannon.                               It is a Water Cannon.
He fires Holy-Water from it.                        It is a Holy-Water Cannon.
He Blesses it.                                 It is a Holy Holy-Water Cannon.
He Blesses the Hell out of it.          It is a Wholly Holy Holy-Water Cannon.
He has it pierced.                It is a Holey Wholly Holy Holy-Water Cannon.
He makes it official.       It is a Canon Holey Wholly Holy Holy-Water Cannon.
Batman and Robin arrive.                                       He shoots them.
