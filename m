Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSGRAQK>; Wed, 17 Jul 2002 20:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316789AbSGRAQK>; Wed, 17 Jul 2002 20:16:10 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:16903 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316437AbSGRAQK>; Wed, 17 Jul 2002 20:16:10 -0400
Date: Thu, 18 Jul 2002 02:19:04 +0200
From: Tomas Szepe <szepe@dragon.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org
Subject: Re: sched.h problem
Message-ID: <20020718001904.GB29944@louise.pinerecords.com>
References: <mailman.1026801544.11015.linux-kernel2news@redhat.com> <200207172341.g6HNf4830755@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207172341.g6HNf4830755@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 43 days, 11:20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > However, arch/sparc/kernel/process.c::cpu_idle() tries to set
> > these properties for the idle task:
> > 
> > 	current->nice = 20;
> > 	current->counter = -100;
> > 	init_idle();   
> 
> I'll send you my O(1) for sparc 2.5, adapt that.

Thanks, I'll have a look at the patch.

T.
