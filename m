Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUDSMrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 08:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264393AbUDSMrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 08:47:04 -0400
Received: from bay14-f34.bay14.hotmail.com ([64.4.49.34]:14597 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264391AbUDSMrA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 08:47:00 -0400
X-Originating-IP: [212.143.127.195]
X-Originating-Email: [qwejohn@hotmail.com]
From: "John Que" <qwejohn@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: NIC inerrupt 
Date: Mon, 19 Apr 2004 15:46:58 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY14-F34eqdGSyMp690005e9f6@hotmail.com>
X-OriginalArrivalTime: 19 Apr 2004 12:46:59.0195 (UTC) FILETIME=[678CA4B0:01C4260C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I want to count the number of times I reach an NIC receive
interrupt.

I added a global static variable of type int , and initialized
it to 0 ; each time I am in the rx_interrupt of the card I incerement
it by one;
I got large , non sensible numbers after one or two seconds;

So  for debug I added printk each time I increment it in rx_interrupt.

What I see is that there are  unreasonable jumps in the number

for instance , it inceremnts sequntially from 1 to 80,then jums to 4500, 
increments a little sequentially to 4580, and the jums again to
11000 ;

Is it got to do with it that this is in interrupt?
Any idea what it can be ?


(I also tried to declare it as static in the rx_interrupt method
and the same happened)

Thnx,
John

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail

