Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271419AbRHUE45>; Tue, 21 Aug 2001 00:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269351AbRHUE4r>; Tue, 21 Aug 2001 00:56:47 -0400
Received: from mx1.sac.fedex.com ([199.81.208.10]:12562 "EHLO
	mx1.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S271419AbRHUE4j>; Tue, 21 Aug 2001 00:56:39 -0400
Date: Tue, 21 Aug 2001 12:57:58 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Chua <jchua@fedex.com>
Subject: linux smp + pppd out failed
Message-ID: <Pine.LNX.4.33.0108211257090.15614-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux 2.4.9 SMP can't pppd out. But it can accept incoming ppp.

I tried Linux without SMP and it's ok.


Aug 20 19:44:10 greengo pppd[164]: pppd 2.4.1b2 started by root, uid 0
Aug 20 19:44:39 greengo pppd[164]: Serial connection established.
Aug 20 19:44:39 greengo pppd[164]: using channel 1
Aug 20 19:44:39 greengo pppd[164]: Using interface ppp0
Aug 20 19:44:39 greengo pppd[164]: Connect: ppp0 <--> /dev/ttyLT0
Aug 20 19:44:40 greengo pppd[164]: sent [LCP ConfReq id=0x1 <asyncmap 0x0>
<auth pap> <magic 0xd442d8f> <pcomp> <accomp>]
Aug 20 19:45:07 greengo last message repeated 9 times
Aug 20 19:45:10 greengo pppd[164]: LCP: timeout sending Config-Requests
Aug 20 19:45:10 greengo pppd[164]: Connection terminated.
Aug 20 19:45:11 greengo pppd[164]: Hangup (SIGHUP)
Aug 20 19:45:11 greengo pppd[164]: Exit.



Thanks,
Jeff
[ jchua@fedex.com ]


