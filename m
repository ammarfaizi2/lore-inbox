Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266792AbSKOR46>; Fri, 15 Nov 2002 12:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266793AbSKOR46>; Fri, 15 Nov 2002 12:56:58 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:12471 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S266792AbSKOR4y>;
	Fri, 15 Nov 2002 12:56:54 -0500
Message-ID: <3DD536FB.70309@colorfullife.com>
Date: Fri, 15 Nov 2002 19:03:39 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Kammerloher, Josef" <Josef.Kammerloher@est.fujitsu.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Every semaphore call results in "uninterruptable sleep"
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Every semaphore function (semget(),..) ,  "ipcs -s" ... results in
>"uninterruptable sleep".
>The processes cannot be killed by kill -9.
>  
>
Enable sysrequest, then press Alt+SysRQ+T.
It will dump the kernel stack of all processes.
Run in through ksymoops and send the results to the list.

--
    Manfred

