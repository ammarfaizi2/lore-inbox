Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317532AbSFRSCD>; Tue, 18 Jun 2002 14:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317530AbSFRSCB>; Tue, 18 Jun 2002 14:02:01 -0400
Received: from mail.webmaster.com ([216.152.64.131]:14990 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317529AbSFRSB4> convert rfc822-to-8bit; Tue, 18 Jun 2002 14:01:56 -0400
From: David Schwartz <davids@webmaster.com>
To: <mgix@mgix.com>, <root@chaos.analogic.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>
CC: <rml@tech9.net>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Tue, 18 Jun 2002 11:01:53 -0700
In-Reply-To: <AMEKICHCJFIFEDIBLGOBEEEHCBAA.mgix@mgix.com>
Subject: RE: Question about sched_yield()
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020618180154.AAA21943@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>All I want is: when I run a bunch of
>yielders and a actual working process, I want the
>working process to not be slown down (wall clock) in
>anyway. That's all. What top shows is of little interest
>(to me). What matters is how many real world seconds it takes
>for the actually working process to complete its task.
>And that should not be affected by the presence of running
>yielders. And, David, no one is arguing the fact that a yielder
>running all by itself should log 100% of the CPU.

	Your assumptions are just plain wrong. The yielder is being nice, so it 
should get preferential treatment, not worse treatment. All threads are 
ready-to-run all the time. Yielding is not the same as blocking or lowering 
your priority.

	DS


