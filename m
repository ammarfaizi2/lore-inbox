Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbVDAMOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVDAMOn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 07:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbVDAMOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 07:14:43 -0500
Received: from smtp3.netcabo.pt ([212.113.174.30]:59265 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262723AbVDAMOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 07:14:40 -0500
Message-ID: <55598.195.245.190.93.1112357613.squirrel@www.rncbc.org>
In-Reply-To: <20050401104724.GA31971@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>
    <20050401104724.GA31971@elte.hu>
Date: Fri, 1 Apr 2005 13:13:33 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       "Steven Rostedt" <rostedt@goodmis.org>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 01 Apr 2005 12:14:38.0296 (UTC) FILETIME=[60063580:01C536B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> i have released the -V0.7.43-00 Real-Time Preemption patch, which can be
> downloaded from the usual place:
>

RT-V0.7.43-00 is failing to build here:
  .
  .
  .
  CC      kernel/rcupdate.o
  CC      kernel/intermodule.o
kernel/intermodule.c:179: warning: `inter_module_register' is deprecated
(declar
ed at kernel/intermodule.c:38)
kernel/intermodule.c:180: warning: `inter_module_unregister' is deprecated
(decl
ared at kernel/intermodule.c:79)
kernel/intermodule.c:182: warning: `inter_module_put' is deprecated
(declared at
 kernel/intermodule.c:160)
  CC      kernel/extable.o
  CC      kernel/params.o
  CC      kernel/posix-timers.o
  CC      kernel/kthread.o
  CC      kernel/wait.o
  CC      kernel/kfifo.o
  CC      kernel/sys_ni.o
  CC      kernel/posix-cpu-timers.o
  CC      kernel/rt.o
kernel/rt.c:1435: error: `up_read' undeclared here (not in a function)
kernel/rt.c:1435: error: initializer element is not constant
kernel/rt.c:1435: error: (near initialization for `__ksymtab_up_read.value')
kernel/rt.c:1435: error: __ksymtab_up_read causes a section type conflict
make[1]: *** [kernel/rt.o] Error 1
make: *** [kernel] Error 2

Bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

