Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbTKKXwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 18:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTKKXwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 18:52:45 -0500
Received: from law12-f60.law12.hotmail.com ([64.4.19.60]:34835 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263848AbTKKXwn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 18:52:43 -0500
X-Originating-IP: [24.82.225.198]
X-Originating-Email: [justformoonie@hotmail.com]
From: "kirk bae" <justformoonie@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: So, Poll is not scalable... what to do?
Date: Tue, 11 Nov 2003 17:52:42 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW12-F60bw5TYIo9WF0002bec8@hotmail.com>
X-OriginalArrivalTime: 11 Nov 2003 23:52:42.0813 (UTC) FILETIME=[E5B50ED0:01C3A8AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If poll is not scalable, which method should I use when writing 
multithreaded socket server?

What is the most efficient model to use?

Is there a "standard" model to use when writing a scalable multithreaded 
socket serve such as "io completion ports" on windows?

>From the "Microbenchmark comparing poll, kqueue, and /dev/poll", kqueue is 
the way to go. Am I correct?

What is the best solution to use on Linux?

Also, why is it that poll doesn not return with "close signal" when a 
thread-1 calls poll and thread-2 calls close on a sockfd1? It seems that 
poll only handles close signal when a client disconnects from the server. 
I've seen this mentioned here before, has it been fixed?

Thank you~~~

_________________________________________________________________
>From Beethoven to the Rolling Stones, your favorite music is always playing 
on MSN Radio Plus. No ads, no talk. Trial month FREE!  
http://join.msn.com/?page=offers/premiumradio

