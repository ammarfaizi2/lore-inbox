Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273712AbSISWif>; Thu, 19 Sep 2002 18:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273713AbSISWif>; Thu, 19 Sep 2002 18:38:35 -0400
Received: from ns2.nealtech.net ([64.29.20.117]:9646 "EHLO nealtech.net")
	by vger.kernel.org with ESMTP id <S273712AbSISWid>;
	Thu, 19 Sep 2002 18:38:33 -0400
Message-Id: <200209192243.SAA18356@nealtech.net>
Content-Type: text/plain; charset=US-ASCII
From: anton wilson <anton.wilson@camotion.com>
To: linux-kernel@vger.kernel.org
Subject: Re: garbage returned from do_gettimeofday
Date: Thu, 19 Sep 2002 18:34:00 -0400
X-Mailer: KMail [version 1.3.1]
References: <200209182310.TAA18081@nealtech.net> <200209191602.MAA30225@nealtech.net>
In-Reply-To: <200209191602.MAA30225@nealtech.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> 1032450154 41056 -- 108690]
> 1032450154 42045 -- 108690]
> 1032450154 42056 -- 108690]
> 1032450154 43045 -- 108690]
> 1032450154 43056 -- 108690]
>
> /*garbage starts here*/
> 3390722356 1 -- 108690]
> 1032450154 43090 -- 108690]
> 3390722356 1 -- 108690]
> 1032450154 43177 -- 108690]
> 3390722356 1 -- 108690]
> 1032450154 43204 -- 108690]
> 3390722356 1 -- 108690]
> 1032450154 43257 -- 108690]
> 3390722356 1 -- 108690]
> 1032450154 43287 -- 108690]
> 3390722356 1 -- 108690]
> /*garbage values stop for now*/
> 1032450154 44064 -- 108690]
>
>
> 1032450154 44084 -- 108690]
> 1032450154 44212 -- 108690]
> 1032450154 45047 -- 108690]
> 1032450154 45059 -- 108690]
> 1032450154 46045 -- 108690]
>
>
> I'm using 2.4.19 with rc2, low-latency, premptive, O(1), and kdb patches.


hmm. The pre-emptive patch skipped my do_gettimeofday call and shot me in the 
foot. ..

Anton
