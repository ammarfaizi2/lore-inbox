Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262298AbSJ0HdD>; Sun, 27 Oct 2002 02:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbSJ0HdD>; Sun, 27 Oct 2002 02:33:03 -0500
Received: from smtp03.wxs.nl ([195.121.6.37]:13533 "EHLO smtp03.wxs.nl")
	by vger.kernel.org with ESMTP id <S262298AbSJ0HdC>;
	Sun, 27 Oct 2002 02:33:02 -0500
Message-ID: <006001c27d8b$f0a75720$1400a8c0@Freaky>
From: "freaky" <freaky@bananateam.nl>
To: <korn-linuxkernel@chardonnay.math.bme.hu>
Cc: <linux-kernel@vger.kernel.org>
References: <20021027032811.GM27554@nilus-2690.adsl.datanet.hu>
Subject: Re: 2.4 very slow memory access on abit kd7raid (kt400); ten times slower than on kg7raid
Date: Sun, 27 Oct 2002 08:39:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

l> Everything slowed down. The easiest way to demontsrate this is by looking
at
> these figures:
>
>  raid5: measuring checksumming speed
> -   8regs     :  2343.600 MB/sec
> -   32regs    :  1944.000 MB/sec
> -   pIII_sse  :  4163.600 MB/sec
> -   pII_mmx   :  3584.400 MB/sec
> -   p5_mmx    :  4600.800 MB/sec
> -raid5: using function: pIII_sse (4163.600 MB/sec)
> +   8regs     :   228.400 MB/sec
> +   32regs    :   199.200 MB/sec
> +   pIII_sse  :   352.000 MB/sec
> +   pII_mmx   :   316.800 MB/sec
> +   p5_mmx    :   432.800 MB/sec
> +raid5: using function: pIII_sse (352.000 MB/sec)
>
> Old motherboard above, new below. (Why it chose pIII_sse even when p5_mmx
> was faster is also an interesting question... :)

I have seen the same on a precompiled slackware 8.1 raid.s kernel I tried
for my promise controller. It's an AMD AthlonXP 2000+. Like you I found that
the PIII_SSE was slower than the P5_MMX and still got selected. I got higher
numers than you though, around your old mobo's speeds.... (KT333 chipset).
(MSI KT3 Ultra2-R). specs are in the KT333, IO-APIC, Promise Fasttak, Initrd
topic.


the 5 disks spanning ram image doesn't even load properly with me, maybe
it's caused by memory problems as well? Tho' I thought north bridges are for
memory access whilst I only get a message that my southbridge isn't
recognized...



