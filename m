Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVC1Mzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVC1Mzk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 07:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVC1Mzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 07:55:40 -0500
Received: from bay17-f14.bay17.hotmail.com ([64.4.43.64]:37767 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261658AbVC1Mzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 07:55:35 -0500
Message-ID: <BAY17-F14D72EE0806BBD52819A17A3440@phx.gbl>
X-Originating-IP: [199.203.24.239]
X-Originating-Email: [slifshitz@hotmail.com]
From: "shai lifshitz" <slifshitz@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: /dev/rtc <-> scheduler
Date: Mon, 28 Mar 2005 15:55:34 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 28 Mar 2005 12:55:34.0732 (UTC) FILETIME=[6E8598C0:01C53395]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am working in 10 msec tick, and run separate task with the /dev/rtc that 
operate in 1/1024 sec
(about 1 msec).

I see that the RTC task is activated every 1 msec (as expected).

Can anybody explain how the scheduler is activated each 1 msec, although the 
minimal time
slice is 10 msec.

What I am looking for is the exact function/mechanism that causes this high 
frequency scheduling
(the function I am looking for is called from the IRQ 8 interrupt handler, 
but what is it????)

Sincerely

Shai Lifshitz

_________________________________________________________________
Don't just search. Find. Check out the new MSN Search! 
http://search.msn.click-url.com/go/onm00200636ave/direct/01/

