Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317618AbSFRUrO>; Tue, 18 Jun 2002 16:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317617AbSFRUrN>; Tue, 18 Jun 2002 16:47:13 -0400
Received: from dsl092-042-129.lax1.dsl.speakeasy.net ([66.92.42.129]:59654
	"EHLO mgix.com") by vger.kernel.org with ESMTP id <S317615AbSFRUrL>;
	Tue, 18 Jun 2002 16:47:11 -0400
From: <mgix@mgix.com>
To: "David Schwartz" <davids@webmaster.com>, <rml@tech9.net>
Cc: <root@chaos.analogic.com>, <Chris.Friesen@vax.home.local>,
       <cfriesen@nortelnetworks.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Question about sched_yield()
Date: Tue, 18 Jun 2002 13:47:12 -0700
Message-ID: <AMEKICHCJFIFEDIBLGOBKEELCBAA.mgix@mgix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-reply-to: <20020618204237.AAA5802@shell.webmaster.com@whenever>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> >Now, if I understand you well enough David, you'd like an
> >algorithm where the less you want the CPU, the more you get
> >it.
> 
> 	Exactly. This is the UNIX tradition of static and dynamic priorities. The 
> more polite you are about yielding the CPU when you don't need it, the more 
> claim you have to getting it when you do need it.
> 
> >I'd love if you could actually give us an outlook of
> >your ideal scheduler so I can try my thought experiment on it,
> >because from what I've understood so far, your hypothetical
> >scheduler would allocate all of the CPU to the yielders.
> 
> 	Not all, just the same share any other process gets. They're all 
> ready-to-run, they're all at the same priority.

Correct my logic, please:
	
	1. Rule: The less you want the CPU, the more you get it.
	2. A yielder process never wants the CPU
	3. As a result of Rule 1, it always gets it.


