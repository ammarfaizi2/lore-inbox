Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317531AbSFRSFh>; Tue, 18 Jun 2002 14:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317536AbSFRSFg>; Tue, 18 Jun 2002 14:05:36 -0400
Received: from dsl092-042-129.lax1.dsl.speakeasy.net ([66.92.42.129]:42502
	"EHLO mgix.com") by vger.kernel.org with ESMTP id <S317531AbSFRSFf>;
	Tue, 18 Jun 2002 14:05:35 -0400
From: <mgix@mgix.com>
To: "David Schwartz" <davids@webmaster.com>, <root@chaos.analogic.com>,
       "Chris Friesen" <cfriesen@nortelnetworks.com>
Cc: <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: RE: Question about sched_yield()
Date: Tue, 18 Jun 2002 11:05:36 -0700
Message-ID: <AMEKICHCJFIFEDIBLGOBCEEICBAA.mgix@mgix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20020618180154.AAA21943@shell.webmaster.com@whenever>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	Your assumptions are just plain wrong. The yielder is being nice, so it 
> should get preferential treatment, not worse treatment. All threads are 
> ready-to-run all the time. Yielding is not the same as blocking or lowering 
> your priority.


In other words, the more you yield, the nicer you
are and the more CPU you get, and those nasty processes
that are trying to actually use the CPU to do something
with it and wear it down should get it as little as possible.
I get it.

	- Mgix


