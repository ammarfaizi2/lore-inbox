Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUASXpt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 18:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264934AbUASXps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 18:45:48 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:23194 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263166AbUASXmw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:42:52 -0500
Message-ID: <400C6B59.6060409@cyberone.com.au>
Date: Tue, 20 Jan 2004 10:42:17 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: John Stoffel <stoffel@lucent.com>
CC: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       root@chaos.analogic.com, cliffw@osdl.org, mpm@selenic.com,
       linux-kernel@vger.kernel.org
Subject: Re: [1/4] better i386 CPU selection
References: <20040106054859.GA18208@waste.org>	<3FFA56D6.6040808@cyberone.com.au>	<20040106064607.GB18208@waste.org>	<3FFA5ED3.6040000@cyberone.com.au>	<20040110004625.GB25089@fs.tum.de>	<20040110005232.GD25089@fs.tum.de>	<20040116111501.70200cf3.cliffw@osdl.org>	<Pine.LNX.4.53.0401161425110.31018@chaos>	<20040116160133.5af17a6a.akpm@osdl.org>	<20040117025745.GJ12027@fs.tum.de> <16395.62535.600758.816370@gargle.gargle.HOWL>
In-Reply-To: <16395.62535.600758.816370@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Stoffel wrote:

>>>>>>"Adrian" == Adrian Bunk <bunk@fs.tum.de> writes:
>>>>>>
>
>Adrian> The main effect is that better-i386-cpu-selection.patch makes
>Adrian> it easier for people who configure kernels that should work on
>Adrian> different CPU types. A user (= person compiling his own
>Adrian> kernel) does no longer need any deeper knowledge when
>Adrian> e.g. configuring a kernel that should run on both an Athlon
>Adrian> and a Pentium 4 - he simply selects all CPUs he wants to
>Adrian> support in his kernel.
>
>So a user who will only Run this kernel on a PIII for example, doesn't
>need to select *any* other kernels at all?  I think the Kconfig help
>screens need to be redone to make this clear.
>
>I enabled all the sub-processors because I wanted to make sure my
>kernel would boot no matter what.  It seems like I don't need that any
>more, right? 
>

At the top of the "Processor support" menu there is the line
"Select all processors your kernel should support". That sums
it up pretty well.

I might get your point better if you sent a patch.




