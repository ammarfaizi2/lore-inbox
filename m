Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275982AbRI1IwB>; Fri, 28 Sep 2001 04:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275985AbRI1Ivu>; Fri, 28 Sep 2001 04:51:50 -0400
Received: from hal.grips.com ([62.144.214.40]:45738 "EHLO hal.grips.com")
	by vger.kernel.org with ESMTP id <S275982AbRI1Ivn>;
	Fri, 28 Sep 2001 04:51:43 -0400
Message-Id: <200109280851.f8S8pKL29417@hal.grips.com>
Content-Type: text/plain; charset=US-ASCII
From: Gerold Jury <gjury@hal.grips.com>
To: Robert Cohen <robert.cohen@anu.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [BENCH] Problems with IO throughput and fairness with 2.4.10 and  2.4.9-ac15
Date: Fri, 28 Sep 2001 10:51:20 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3BB31F99.941813DD@anu.edu.au>
In-Reply-To: <3BB31F99.941813DD@anu.edu.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried 2.4.9-xfs against 2.4.10-xfs with dbench.
The machine has 384 MB ram.

The throughput is roughly the same for both with dbench 2.
dbench 32 runs fine on 2.4.9-xfs but does not finish on 2.4.10-xfs.
dbench 24 will finish on 2.4.10 but it takes a very very long time.
All dbench processes are stuck in D state after 10 seconds.

I am not sure if it is the xfs part, the VM or both.

Can you give the dbench 32 a try ?

Regards
Gerold

On Thursday 27 September 2001 14:46, Robert Cohen wrote:
> Given the recent flurry of changes in the Linux kernel VM subsystems I
> decided to do a bit of benchmarking.
