Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317657AbSFRWwZ>; Tue, 18 Jun 2002 18:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317658AbSFRWwY>; Tue, 18 Jun 2002 18:52:24 -0400
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:772 "EHLO
	whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S317657AbSFRWwX>; Tue, 18 Jun 2002 18:52:23 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: davids@webmaster.com
X-Envelope-Sender: stevie@qrpff.net
Message-Id: <5.1.0.14.2.20020618184424.00ab6418@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 18 Jun 2002 18:45:55 -0400
To: David Schwartz <davids@webmaster.com>, <rml@tech9.net>,
       Chris Friesen <cfriesen@nortelnetworks.com>
From: Stevie O <stevie@qrpff.net>
Subject: Re: Question about sched_yield()
Cc: <mgix@mgix.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20020618180040.AAA21856@shell.webmaster.com@whenever>
References: <1024420400.3090.202.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:00 AM 6/18/2002 -0700, David Schwartz wrote:
>This is the same error repeated again. Since you realize that an endless 
>loop on sched_yield is *not* equivalent to blocking, why do you then say "in 
>fact doing useful work"? By what form of ESP is the kernel supposed to 
>determine that the sched_yield task is not 'doing useful work' and the other 
>task is?

By this form of ESP: sched_yield() means "I have nothing better to do right now, give my time to someone who does".  If a thread is doing useful work, why would it call sched_yield() ?!?


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

