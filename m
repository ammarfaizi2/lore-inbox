Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbUAHPvP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265438AbUAHPvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:51:15 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:30396 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265431AbUAHPvN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:51:13 -0500
Message-ID: <3FFD7B92.8090301@cyberone.com.au>
Date: Fri, 09 Jan 2004 02:47:30 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: martin f krafft <madduck@madduck.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: scheduling problems in X with 2.6.0
References: <20040107102352.GA2954@piper.madduck.net> <3FFC2621.7060808@cyberone.com.au> <20040107174606.GA25307@piper.madduck.net> <3FFD789D.7020908@cyberone.com.au> <20040108154109.GB29224@piper.madduck.net>
In-Reply-To: <20040108154109.GB29224@piper.madduck.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



martin f krafft wrote:

>also sprach Nick Piggin <piggin@cyberone.com.au> [2004.01.08.1634 +0100]:
>
>>You could try my alternate CPU scheduler which would tell us if your
>>problem is the scheduler or something else. Its against the mm tree.
>>http://www.kerneltrap.org/~npiggin/v29p6.gz
>>
>
>From a quick glance, it mentions the Pentium 4 and Hyperthreading.
>This *is* an SMP system, but it uses Athlon XPs. Will your scheduler
>still work?
>

Yeah, my interactivity stuff has to be applied after my SMP stuff,
so I had to give you both ;)

You'll want to run make oldconfig after patching, and you needn't say
yes to CONFIG_SCHED_SMT, although if you did it wouldn't hurt either,
it just wouldn't do anything.

Nick


