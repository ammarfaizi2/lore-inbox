Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262031AbTCRAR5>; Mon, 17 Mar 2003 19:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262033AbTCRAR5>; Mon, 17 Mar 2003 19:17:57 -0500
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:48468
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S262031AbTCRAR4>; Mon, 17 Mar 2003 19:17:56 -0500
Message-ID: <001301c2ece5$557ee280$c70a0a0a@slappy>
Reply-To: "Sean Estabrooks" <seanlkml@rogers.com>
From: "Sean Estabrooks" <seanlkml@rogers.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-2.5.64-D3, more interactivity changes
Date: Mon, 17 Mar 2003 19:28:43 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.102.213.4] using ID <seanlkml@rogers.com> at Mon, 17 Mar 2003 19:28:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003 11:21:33 +0100, Ingo Molnar wrote:

> the attached patch (against BK-curr) implements more finegrained timeslice
> distribution, without changing the total balance of timeslices, by
> recalculating the priority of CPU-bound tasks at a finer granularity, and
> by roundrobining tasks. Right now this new granularity is 50 msecs (the
> default timeslice for default priority tasks is 100 msecs).
>
> Could people, who can reproduce 'audio skips' kind of problems even with
> BK-curr, give this patch a go?
>
>       Ingo

An enthusiastic, Works For Me (tm)....

Linux version 2.5.64
(gcc version 3.2.2 20030217 (Red Hat Linux 8.0 3.2.2-2))

model name  : Pentium III (Coppermine)
stepping        : 1
cpu MHz      : 647.134
cache size     : 256 KB
bogomips      : 1277.95

Cheers,
Sean

