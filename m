Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317443AbSF1OZt>; Fri, 28 Jun 2002 10:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317444AbSF1OZs>; Fri, 28 Jun 2002 10:25:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40430 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317443AbSF1OZr>;
	Fri, 28 Jun 2002 10:25:47 -0400
Message-ID: <3D1C7236.68630D2A@mvista.com>
Date: Fri, 28 Jun 2002 07:27:02 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Is there an "interrups_on()" function
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need an interrupts on test function that works for all
platforms.  Has this been done yet?

Alternatively, __save_flags() seems to exist for all
platforms.  Is the need "mask" to test for interrupts on
defined for all platforms?  Or will this even work?  (One
can imagine that some platforms use inverted interrupt
enabled bits).
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
