Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262213AbTDAJgO>; Tue, 1 Apr 2003 04:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbTDAJgO>; Tue, 1 Apr 2003 04:36:14 -0500
Received: from f28.pav2.hotmail.com ([64.4.37.28]:16902 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262213AbTDAJgN>;
	Tue, 1 Apr 2003 04:36:13 -0500
X-Originating-IP: [129.219.25.77]
X-Originating-Email: [bhushan_vadulas@hotmail.com]
From: "shesha bhushan" <bhushan_vadulas@hotmail.com>
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Deactivating TCP checksumming
Date: Tue, 01 Apr 2003 09:47:30 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F28fCuayVxYPtqpymRi000013e5@hotmail.com>
X-OriginalArrivalTime: 01 Apr 2003 09:47:31.0618 (UTC) FILETIME=[B6F2C820:01C2F833]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,
  I am trying to de-activate the TCP checksumming and allow hardware (GBE to 
compute it for me). But can any one let me know how to do it.

This is what I did.But Its not working for me.

In linux/net/ipv4/tcp.c there are function calls to 
csum_and_copy_from_user(). I replaced it from copy_from_user() and set the 
skb->ip_summed = CHECKSUM_HW and skb->csum = 1;. Is this correct. Since its 
not working there must be something more that has to be done. could any one 
please tell me what additional thinks I need to do.

All suggestion are highly apperciated.

Thanking You
Shesha




_________________________________________________________________
Say it now. Say it online. http://www.msn.co.in/ecards/ Send e-cards to your 
love

