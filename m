Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266665AbSKGX53>; Thu, 7 Nov 2002 18:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266666AbSKGX53>; Thu, 7 Nov 2002 18:57:29 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:38157
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266665AbSKGX52>; Thu, 7 Nov 2002 18:57:28 -0500
Subject: Re: [BENCHMARK] 2.5.46-mm1 with contest
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3DCAFE38.16DED3BF@digeo.com>
References: <200211080953.22903.conman@kolivas.net>
	<1036712891.764.2055.camel@phantasy>  <3DCAFE38.16DED3BF@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Nov 2002 19:04:08 -0500
Message-Id: <1036713848.764.2107.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 18:58, Andrew Morton wrote:

> Robert Love wrote:
> > 
> > On Thu, 2002-11-07 at 17:53, Con Kolivas wrote:
> > 
> > > io_load:
> > > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > > 2.5.44-mm6 [3]          284.1   28      20      10      3.98
> > > 2.5.46 [1]              600.5   13      48      12      8.41
> > > 2.5.46-mm1 [5]          134.3   58      6       8       1.88
> > >
> > > Big change here. IO load is usually the one we feel the most.
> > 
> > Nice.
> 
> Mysterious.

Why?  We are preempting during the generic file write/read routines, I
bet, which can otherwise be long periods of latency.  CPU is up and I
bet the throughput is down, but his test is getting the attention it
wants.

	Robert Love

