Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293129AbSCRW3S>; Mon, 18 Mar 2002 17:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293131AbSCRW3I>; Mon, 18 Mar 2002 17:29:08 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:45970 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S293129AbSCRW2x>;
	Mon, 18 Mar 2002 17:28:53 -0500
Message-ID: <001e01c1cecc$50c347f0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Russ Weight" <rweight@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Scalable CPU bitmasks
Date: Mon, 18 Mar 2002 23:28:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>  NOTE:   The cpumap_to_ulong() and cpumap_ulong_to_cpumap() interfaces
>          are provided specifically for migration. In their current
>          form, they call BUG() if NR_CPUS is defined to be greater
>          than the bit-size of (unsigned long).

Why BUG? NR_CPUS is known at compile time,  is there a reason why you
can't use a call to an undefined function in order to get a link time
error message? (like __bad_udelay in linux/asm-i386/udelay.h)

--
    Manfred




