Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265376AbUA2KwZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 05:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUA2KwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 05:52:25 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:22698 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265376AbUA2KwW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 05:52:22 -0500
Message-ID: <4018E524.8060200@cyberone.com.au>
Date: Thu, 29 Jan 2004 21:49:08 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Catalin BOIE <util@deuroconsult.ro>
CC: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: 2.6.2-rc2 Interactivity problems with SMP + HT
References: <Pine.LNX.4.58.0401291239320.23046@hosting.rdsbv.ro>
In-Reply-To: <Pine.LNX.4.58.0401291239320.23046@hosting.rdsbv.ro>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Catalin BOIE wrote:

>Hello!
>
>First, thank you very much for the effort you put for Linux!
>
>I have a Intel motherboard with SATA (2 Maxtor disks).
>CPUs: 2 x 2.4GHz PIV HT = 4 processors (2 virtual)
>1 GB RAM.
>
>Load: postgresql and apache. Very low load (3-4 clients).
>
>RAID: Yes, soft RAID1 between the 2 disks.
>
>I have times when the console freeze for 3-4 seconds!
>2.6.0-test11 had the same problem (maybe longer times).
>2.6.1-rc2 worked good in this respect but crashed after 2 days. :(
>2.6.2-rc2 is back with the delay.
>
>Do you know why this can happen?
>
>

There haven't been many scheduler changes there recently so
maybe its something else.

But you could try the latest -mm kernels. They have some
Hyperthreading work in them (you need to enable CONFIG_SCHED_SMT).

