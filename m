Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTINX6c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 19:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbTINX6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 19:58:32 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38669 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262400AbTINX6a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 19:58:30 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: 14 Sep 2003 23:49:30 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bk2uqa$fmj$1@gatekeeper.tmr.com>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com> <20030912195606.24e73086.ak@suse.de> <3F62098F.9030300@pobox.com> <20030912182216.GK27368@fs.tum.de>
X-Trace: gatekeeper.tmr.com 1063583370 16083 192.168.12.62 (14 Sep 2003 23:49:30 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030912182216.GK27368@fs.tum.de>,
Adrian Bunk  <bunk@fs.tum.de> wrote:
                [...]

| But even CONFIG_X86_GENERIC doesn't do what you expect. A kernel 
| compiled for Athlon wouldn't run on a Pentium 4 even with 
| CONFIG_X86_GENERIC.
| 
| Quoting arch/i386/Kconfig in -test5:
| 
| <--  snip  -->
| 
| config X86_USE_3DNOW
|         bool
|         depends on MCYRIXIII || MK7
|         default y
| 
| <--  snip  -->
| 
| My patch in the mail
| 
|   RFC: [2.6 patch] better i386 CPU selection
| 
| tries to solve these problem with a different approach (the user selects 
| all CPUs he wants to support).

If you have managed to work around all the conflicting capabilities
without leaving the kernel way suboptimal on some, I salute your better
solution.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
