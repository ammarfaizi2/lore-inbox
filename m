Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSGQXiL>; Wed, 17 Jul 2002 19:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSGQXiL>; Wed, 17 Jul 2002 19:38:11 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:61915 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316842AbSGQXiK>; Wed, 17 Jul 2002 19:38:10 -0400
Date: Wed, 17 Jul 2002 19:41:04 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200207172341.g6HNf4830755@devserv.devel.redhat.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sched.h problem
In-Reply-To: <mailman.1026801544.11015.linux-kernel2news@redhat.com>
References: <mailman.1026801544.11015.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, arch/sparc/kernel/process.c::cpu_idle() tries to set
> these properties for the idle task:
> 
> 	current->nice = 20;
> 	current->counter = -100;
> 	init_idle();   

I'll send you my O(1) for sparc 2.5, adapt that.

-- Pete
