Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276032AbRI1MtE>; Fri, 28 Sep 2001 08:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276037AbRI1Msy>; Fri, 28 Sep 2001 08:48:54 -0400
Received: from hal.grips.com ([62.144.214.40]:28865 "EHLO hal.grips.com")
	by vger.kernel.org with ESMTP id <S276032AbRI1Msm>;
	Fri, 28 Sep 2001 08:48:42 -0400
Message-Id: <200109281248.f8SCmaT29893@hal.grips.com>
Content-Type: text/plain; charset=US-ASCII
From: Gerold Jury <gjury@hal.grips.com>
To: Andrey Nekrasov <andy@spylog.ru>, linux-kernel@vger.kernel.org
Subject: Re: [BENCH] Problems with IO throughput and fairness with 2.4.10 and  2.4.9-ac15
Date: Fri, 28 Sep 2001 14:48:36 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3BB31F99.941813DD@anu.edu.au> <200109280851.f8S8pKL29417@hal.grips.com> <20010928142740.A3678@spylog.ru>
In-Reply-To: <20010928142740.A3678@spylog.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, nice to hear.

So it needs to be something stupid on my side or xfs with the new VM.

By the way. It is an Atlon 1.1 (kernel compiled with Atlon optimisation)
IDE controller ATA66, disk IBM 15 GB ATA33
The machine is solid with and without VIA pci bit 7 byte 55 zero/one
swapspace 256MB

preempable patch does not help with my D state problem
i have not tried 2.4.10.aa1
but i will try with ext2 instead of xfs next time

Gerold

On Friday 28 September 2001 12:27, Andrey Nekrasov wrote:
> Hello Gerold Jury,
>
>
> I am run "dbench 32", all test ok.
> Kernel 2.4.10-xfs + 2.4.10.aa1 + preempteble patch.
> File system on test partition ext2.
>
> Compiled with no highmem support.
>
> Hardware configuration:
>
> Dell Optiplex G1 (P2-350/256RAM/IDE disk 1Gb)
