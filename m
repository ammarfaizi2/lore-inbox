Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbSLXPKG>; Tue, 24 Dec 2002 10:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264647AbSLXPKG>; Tue, 24 Dec 2002 10:10:06 -0500
Received: from mail.ifip.com ([63.113.106.66]:26071 "EHLO mail.ifip.com")
	by vger.kernel.org with ESMTP id <S264628AbSLXPKE>;
	Tue, 24 Dec 2002 10:10:04 -0500
Message-ID: <3E087C19.3000307@markerman.com>
Date: Tue, 24 Dec 2002 10:24:09 -0500
From: Byron Albert <byron@markerman.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: KERNEL: assertion tcp.c in 2.4.20
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been seeing some odd errors in 2.4.20.
KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229)
KERNEL: assertion 
((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed 
at af_inet.c(689)
KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229)
KERNEL: assertion 
((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed 
at af_inet.c(689)
KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229)
KERNEL: assertion 
((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed 
at af_inet.c(689)

Could some one tell me what that means and if I should be worried.

Also  I get alot other TCP: messages  Could some one explain to me what 
these mean?
TCP: drop open request from 63.65.68.246/33287
TCP: drop open request from 24.184.185.85/3568
TCP: drop open request from 24.184.185.85/3569
TCP: drop open request from 24.184.185.85/3567
TCP: drop open request from 24.184.185.85/3570
TCP: drop open request from 24.184.185.85/3571
TCP: drop open request from 24.184.185.85/3572
TCP: drop open request from 24.184.185.85/3573
TCP: drop open request from 24.184.185.85/3574
TCP: drop open request from 24.184.185.85/3575
NET: 147 messages suppressed.
TCP: Treason uncloaked! Peer 140.209.113.48:1925/80 shrinks window 
3097980073:3097986643. Repaired.
TCP: Treason uncloaked! Peer 140.209.113.48:1926/80 shrinks window 
3100043056:3100045976. Repaired.
TCP: Treason uncloaked! Peer 63.239.93.2:59895/80 shrinks window 
2412715752:2412716256. Repaired.
TCP: Treason uncloaked! Peer 207.191.34.140:38341/80 shrinks window 
3633908228:3633911148. Repaired.
TCP: Treason uncloaked! Peer 140.198.144.111:1510/80 shrinks window 
185415981:185424093. Repaired.
TCP: Treason uncloaked! Peer 140.198.144.111:1510/80 shrinks window 
185415981:185424093. Repaired.
TCP: Treason uncloaked! Peer 140.198.144.111:1546/80 shrinks window 
1260894648:1260899637. Repaired.
TCP: Treason uncloaked! Peer 140.198.144.111:1546/80 shrinks window 
1260894648:1260899637. Repaired.
TCP: Treason uncloaked! Peer 140.198.144.111:49159/80 shrinks window 
1415173927:1415183499. Repaired.
TCP: Treason uncloaked! Peer 140.198.144.111:49159/80 shrinks window 
1415173927:1415183499. Repaired.



Thanks
Byron

