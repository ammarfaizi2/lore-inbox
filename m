Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263512AbTJUWbt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 18:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTJUWbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 18:31:49 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:46596 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263512AbTJUWbs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 18:31:48 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test7: Preempt enabled -> kernel panic
Date: 21 Oct 2003 22:21:44 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn4bho$jj6$1@gatekeeper.tmr.com>
References: <200310172319.59776.markus_schoder@yahoo.de>
X-Trace: gatekeeper.tmr.com 1066774904 20070 192.168.12.62 (21 Oct 2003 22:21:44 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200310172319.59776.markus_schoder@yahoo.de>,
Markus Schoder  <markus_schoder@yahoo.de> wrote:
| When compiling 2.6.0-test7 with preempt I get a kernel panic
| when running the tst-eintr1 test program from the nptl 0.60 package.
| It does not happen every time but running it repeatedly will lead
| to a panic pretty quickly.
| 
| With preempt disabled it's rock solid.
| 
| Stack trace is not always the same but there always seems to
| be infinite recursion. Also sometimes interrupts are disabled
| (no SysRq) and sometimes not.

I usually run 2.6 kernels with both softdog and NMI watchdog, have no
idea if that would help other than to possibly force a reboot.
 
| This is on an Athlon XP, kernel compiled with gcc 3.3.1.

Check the list, there was something about gcc version, don't remember
exactly what.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
