Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbSLTRqQ>; Fri, 20 Dec 2002 12:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbSLTRqQ>; Fri, 20 Dec 2002 12:46:16 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:56336
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263342AbSLTRqP>; Fri, 20 Dec 2002 12:46:15 -0500
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
From: Robert Love <rml@tech9.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Con Kolivas <conman@kolivas.net>, Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200212201217.07097.m.c.p@wolk-project.de>
References: <200212200850.32886.conman@kolivas.net>
	 <200212201042.48161.conman@kolivas.net> <1040341995.2521.81.camel@phantasy>
	 <200212201217.07097.m.c.p@wolk-project.de>
Content-Type: text/plain
Organization: 
Message-Id: <1040406854.2519.119.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 20 Dec 2002 12:54:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-20 at 06:17, Marc-Christian Petersen wrote:

> FYI: These changes are a horrible slowdown of all apps while kernel 
> compilation.

Try leaving interactive_delta at 2.  If there are still issues, then it
may just be the normal "lack" of interactivity bonus.  A heavy compile
is never pleasant to the other applications.

You could also try Andrew's numbers (max_timeslice=10 and
prio_bonus_rate=0 or 10), but I would prefer not to decrease
max_timeslice so much.

	Robert Love

