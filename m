Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130743AbRAKUIb>; Thu, 11 Jan 2001 15:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131211AbRAKUIV>; Thu, 11 Jan 2001 15:08:21 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:26889 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S130743AbRAKUIE>;
	Thu, 11 Jan 2001 15:08:04 -0500
Date: Thu, 11 Jan 2001 21:08:02 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200101112008.VAA26010@db0bm.ampr.org>
To: twaugh@redhat.com
Subject: Re: Oops while loading ppa in 2.2.19-pre7
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tim,

>> I got this non-fatal oops while loading the ppa module for my IOMEGA parallel
>> port ZIP drive.

>It doesn't look like it's related to the ZIP drive though:

>> Warning: kfree_skb passed an skb still on a list (from c8074fc1).
>> Oops: 0002
>> CPU:    0
>> EIP:    0010:[skb_recv_datagram+359/416]
>>               ^^^^^^^^^^^^^^^^^

>		Seems to be a networking problem..

You are probably right as I can see in tne oops :
Process tnt (pid: 388, process nr: 29, stackpage=c6fe1000)

tnt is a program for hamradio (packet transmission over radio). And this is
related to the network.

----

Regards

		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
