Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317646AbSFRWAt>; Tue, 18 Jun 2002 18:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317645AbSFRWAs>; Tue, 18 Jun 2002 18:00:48 -0400
Received: from mail.webmaster.com ([216.152.64.131]:32149 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317644AbSFRWAr> convert rfc822-to-8bit; Tue, 18 Jun 2002 18:00:47 -0400
From: David Schwartz <davids@webmaster.com>
To: <mgix@mgix.com>, <rml@tech9.net>
CC: <root@chaos.analogic.com>, Chris Friesen <Chris.Friesen@vax.home.local>,
       <cfriesen@nortelnetworks.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Tue, 18 Jun 2002 15:00:42 -0700
In-Reply-To: <AMEKICHCJFIFEDIBLGOBKEELCBAA.mgix@mgix.com>
Subject: RE: Question about sched_yield()
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020618220044.AAA14121@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Correct my logic, please:
>    
>    1. Rule: The less you want the CPU, the more you get it.

	The more you relinquish the CPU, the more you get it when you do want it. 
(Dynamic priority.)

>    2. A yielder process never wants the CPU

	A yielder process *always* wants the CPU, but always relinquishes it when it 
gets it. (It's always ready-to-run.)

>    3. As a result of Rule 1, it always gets it.

	The correct rules 1 and 2 don't lead to the conclusion you think.

	DS


