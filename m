Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTLTOdD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 09:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTLTOdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 09:33:03 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:29387 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262569AbTLTOdA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 09:33:00 -0500
Message-ID: <3FE45D98.2080206@cyberone.com.au>
Date: Sun, 21 Dec 2003 01:32:56 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched domains w27 for 2.6.0
References: <3FE31212.3020701@cyberone.com.au> <20031220114508.GA19417@elte.hu>
In-Reply-To: <20031220114508.GA19417@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:

>* Nick Piggin <piggin@cyberone.com.au> wrote:
>
>
>>http://www.kerneltrap.org/~npiggin/w27/
>>
>>This patch includes a lot of fixes, especially to the active balancing
>>and HT code. It also addresses Rusty's suggestions, and will hopefully
>>fix Zwane's interactivity problems. Testing, comments welcome.
>>
>
>it's looking good so far - this was my final major conceptual peevee. 
>Active balancing is a pretty essential feature - i'm glad you carried
>the concept over from my HT patch. It increases complexity, but it's
>worth it.
>

You'll notice my earlier versions had some type of active balancing.
It was very simple but too dumb, so yes I used ideas from your patch
which seems to be giving good results.



