Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318880AbSICQe4>; Tue, 3 Sep 2002 12:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318879AbSICQe4>; Tue, 3 Sep 2002 12:34:56 -0400
Received: from pD9E23EAA.dip.t-dialin.net ([217.226.62.170]:26496 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318880AbSICQez>; Tue, 3 Sep 2002 12:34:55 -0400
Date: Tue, 3 Sep 2002 10:39:22 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Oliver Pitzeier <o.pitzeier@uptime.at>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Leslie Donaldson <donaldlf@cs.rose-hulman.edu>,
       <axp-kernel-list@redhat.com>, <linux-kernel@vger.kernel.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: Kernel 2.5.33 compile errors (Re: Kernel 2.5.33 successfully
 compiled)
In-Reply-To: <200209031827.16594.o.pitzeier@uptime.at>
Message-ID: <Pine.LNX.4.44.0209031038270.3373-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 3 Sep 2002, Oliver Pitzeier wrote:
> In file included from irq.c:15:
> /usr/src/linux-2.5.33/include/linux/ptrace.h:28: warning: `struct task_struct' 
> declared inside parameter list

Looks like we need to include <linux/sched.h> prior to that.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

