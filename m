Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbTHaKRx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 06:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbTHaKRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 06:17:53 -0400
Received: from dyn-ctb-210-9-245-93.webone.com.au ([210.9.245.93]:3079 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262573AbTHaKRv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 06:17:51 -0400
Message-ID: <3F51CB44.3080805@cyberone.com.au>
Date: Sun, 31 Aug 2003 20:17:40 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ian Kumlien <pomac@vapor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [SHED] Questions.
References: <1062324435.9959.56.camel@big.pomac.com>
In-Reply-To: <1062324435.9959.56.camel@big.pomac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ian Kumlien wrote:

>Hi, 
>
>I'll risk sounding like a moron again =)
>
>I still wonder about the counter intuitive quantum value for
>processes... (or timeslice if you will)
>
>Why not use small quantum values for high pri processes and long for low
>pri since the high pri processes will preempt the low pri processes
>anyways. And for a server working under load with only a few processes
>(assuming they are all low pri) would lessen the context switches.
>
>And a system with "interactive load" as well would, as i said, preempt
>the lower pris. But this could also cause a problem... Imho there should
>be a "min quantum value" so that processes can't preempt a process that
>was just scheduled (i dunno if this is implemented already though). 
>
>Imho this would also make it easy to get the right pri for highpri
>processes since the quantum value is smaller and if you use it all up
>you get demoted.
>
>Anyways, I've been wondering about the inverted values in the scheduler
>and for a mixed load/server load i don't see the benefit... =P
>
>PS. Do not forget to CC me since i'm not on this list...
>DS.
>

Search for "Nick's scheduler policy" ;)


