Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275997AbRI1K1c>; Fri, 28 Sep 2001 06:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276001AbRI1K1X>; Fri, 28 Sep 2001 06:27:23 -0400
Received: from mail.spylog.com ([194.67.35.220]:26801 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S275997AbRI1K1T>;
	Fri, 28 Sep 2001 06:27:19 -0400
Date: Fri, 28 Sep 2001 14:27:40 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: [BENCH] Problems with IO throughput and fairness with 2.4.10 and  2.4.9-ac15
Message-ID: <20010928142740.A3678@spylog.ru>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BB31F99.941813DD@anu.edu.au> <200109280851.f8S8pKL29417@hal.grips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200109280851.f8S8pKL29417@hal.grips.com>
User-Agent: Mutt/1.3.22i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gerold Jury,

Once you wrote about "Re: [BENCH] Problems with IO throughput and fairness with 2.4.10 and  2.4.9-ac15":
> I have tried 2.4.9-xfs against 2.4.10-xfs with dbench.
> The machine has 384 MB ram.

 IDE/SCSI/RAID Controller?

> The throughput is roughly the same for both with dbench 2.
> dbench 32 runs fine on 2.4.9-xfs but does not finish on 2.4.10-xfs.
> dbench 24 will finish on 2.4.10 but it takes a very very long time.
> All dbench processes are stuck in D state after 10 seconds.
> 
> I am not sure if it is the xfs part, the VM or both.
> 
> Can you give the dbench 32 a try ?

I am run "dbench 32", all test ok.
Kernel 2.4.10-xfs + 2.4.10.aa1 + preempteble patch.
File system on test partition ext2.

Compiled with no highmem support.

Hardware configuration: 

Dell Optiplex G1 (P2-350/256RAM/IDE disk 1Gb)


-- 
bye.
Andrey Nekrasov, SpyLOG.
