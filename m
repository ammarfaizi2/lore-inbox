Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271034AbTGWVnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 17:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271040AbTGWVnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 17:43:14 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:27656 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S271034AbTGWVnI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 17:43:08 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [Lse-tech] [patch 2.6.0-test1] per cpu times
Date: 23 Jul 2003 21:50:42 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bfmvvi$lba$1@gatekeeper.tmr.com>
References: <200307181835.42454.efocht@hpce.nec.com> <20030718111850.C1627@w-mikek2.beaverton.ibm.com>
X-Trace: gatekeeper.tmr.com 1058997042 21866 192.168.12.62 (23 Jul 2003 21:50:42 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030718111850.C1627@w-mikek2.beaverton.ibm.com>,
Mike Kravetz  <kravetz@us.ibm.com> wrote:

| On a somewhat related note ...
| 
| We (Big Blue) have a performance reporting application that
| would like to know how long a task sits on a runqueue before
| it is actually given the CPU.  In other words, it wants to
| know how long the 'runnable task' was delayed due to contention
| for the CPU(s).  Of course, one could get an overall feel for
| this based on total runqueue length.  However, this app would
| really like this info on a per-task basis.

This is certainly a useful number. It's easy to tell when the CPU is "in
use," but it's not easy to tell when it's "busy" and processes are
waiting for a CPU. 
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
