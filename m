Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264744AbSJORKO>; Tue, 15 Oct 2002 13:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264746AbSJORKO>; Tue, 15 Oct 2002 13:10:14 -0400
Received: from mx1.elte.hu ([157.181.1.137]:30140 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264744AbSJORKN>;
	Tue, 15 Oct 2002 13:10:13 -0400
Date: Tue, 15 Oct 2002 19:27:37 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Bill Hartner <hartner@austin.ibm.com>
Cc: lse-tech@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [PERFORMANCE RESULTS] priority preemption in Linux
In-Reply-To: <3DAC3944.73A6BF14@austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0210151926280.16262-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Oct 2002, Bill Hartner wrote:

> kernel    preemption     conforming     percent
>           threshold      connections    improvement
> ======    ===========    ===========    ===========
> 
> 2.5.33    0 (default)    2906           baseline
> 2.5.33    40             2990           2.9 %
> 
> Table 3 shows that reducing priority preemption improved the
> number of conforming connections by 2.9 %.

actually, the more interesting metric is the ops/sec value - how did that
change? Conforming connections is a cutoff value and the real improvement
might be bigger than that.

	Ingo

