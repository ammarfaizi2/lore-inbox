Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266144AbSLCIRx>; Tue, 3 Dec 2002 03:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266153AbSLCIRx>; Tue, 3 Dec 2002 03:17:53 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:61871 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266144AbSLCIRt>; Tue, 3 Dec 2002 03:17:49 -0500
Message-Id: <4.3.2.7.2.20021203092347.00b53da0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 03 Dec 2002 09:25:34 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: Wierd listen/connect: accept queue never fills up
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From the Linux kernel doc :

tcp_max_syn_backlog
-------------------
Length of  the per socket backlog queue. Since Linux 2.2 the backlog specified
in listen(2)  only  specifies  the  length  of  the  backlog  queue of already
established sockets. When more connection requests arrive Linux starts to drop
packets. When  syncookies  are  enabled the packets are still answered and the
maximum queue is effectively ignored.


Margit 

