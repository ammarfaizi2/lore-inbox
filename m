Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276919AbRJHPTp>; Mon, 8 Oct 2001 11:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276930AbRJHPTf>; Mon, 8 Oct 2001 11:19:35 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:6155 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S276919AbRJHPTT>; Mon, 8 Oct 2001 11:19:19 -0400
Date: Mon, 8 Oct 2001 11:19:49 -0400
Message-Id: <200110081519.f98FJnZ10592@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Context switch times
X-Newsgroups: linux.dev.kernel
In-Reply-To: <3BC067BB.73AF1EB5@welho.com>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BC067BB.73AF1EB5@welho.com> Mika.Liljeberg@welho.com wrote:

>Yes. However, you still want to balance the queues even if all CPUs are
>100% utilized. It's a fairness issue. Otherwise you could have 1 task
>running on one CPU and 49 tasks on another.

  You say that as if it were a bad thing... I believe that if you have
one long running task and many small tasks in the system CPU affinity
will make that happen now. Obviously not if all CPUs are 100% loaded,
and your 1 vs. 49 is unrealistic, but having a task stay with a CPU
while trivia run on other CPU(s) is generally a good thing under certain
load conditions, which I guess are no less likely than your example;-)

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
