Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316899AbSGSQ5H>; Fri, 19 Jul 2002 12:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316900AbSGSQ5H>; Fri, 19 Jul 2002 12:57:07 -0400
Received: from mx1.elte.hu ([157.181.1.137]:33215 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316899AbSGSQ5G>;
	Fri, 19 Jul 2002 12:57:06 -0400
Date: Sat, 20 Jul 2002 18:59:07 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: shreenivasa H V <shreenihv@usa.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Gang Scheduling in linux
In-Reply-To: <200207191105.57814.frankeh@watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0207201858180.17247-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Jul 2002, Hubertus Franke wrote:

> For this it seems sufficient to simply STOP apps on a larger granularity
> and have that done through a user level daemon. The kernel scheduler
> simply schedules the runnable threads that given the U-Sched would
> always amount to a limited number of threads/tasks.

yep, this is my suggestion as well. Any reason to do gang scheduling in
the scheduler and not via a userspace daemon that stops/resumes (and
binds) managed tasks explicitly?

	Ingo

