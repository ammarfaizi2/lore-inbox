Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264679AbSJOQOr>; Tue, 15 Oct 2002 12:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264677AbSJOQOr>; Tue, 15 Oct 2002 12:14:47 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:46211 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264679AbSJOQOq> convert rfc822-to-8bit; Tue, 15 Oct 2002 12:14:46 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Use of yield() in the kernel
Date: Tue, 15 Oct 2002 18:20:24 +0200
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Duncan Sands <baldrick@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210151820.24429.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Duncan,

> The semantics of sched_yield() changed in the 2.5 kernel.
> In the 2.4 series it meant "sleep a little".
> The new 2.5 semantics are correct (move to the end of the
> run queue) but can mean "sleep a lot" under load.
>
> This already bit ext3 transaction batching, c.f. Andrew Morton's
>
>> [PATCH] remove the sched_yield from the ext3 fsync path
where did you read this ^^? :)

ciao, Marc
