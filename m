Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266635AbSKGXle>; Thu, 7 Nov 2002 18:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266636AbSKGXle>; Thu, 7 Nov 2002 18:41:34 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:61708
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266635AbSKGXld>; Thu, 7 Nov 2002 18:41:33 -0500
Subject: Re: [BENCHMARK] 2.5.46-mm1 with contest
From: Robert Love <rml@tech9.net>
To: Con Kolivas <conman@kolivas.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <200211080953.22903.conman@kolivas.net>
References: <200211080953.22903.conman@kolivas.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Nov 2002 18:48:10 -0500
Message-Id: <1036712891.764.2055.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 17:53, Con Kolivas wrote:

> io_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.5.44-mm6 [3]          284.1   28      20      10      3.98
> 2.5.46 [1]              600.5   13      48      12      8.41
> 2.5.46-mm1 [5]          134.3   58      6       8       1.88
> 
> Big change here. IO load is usually the one we feel the most.

Nice.

> Unfortunately I've only run this with preempt enabled so far and I believe 
> many of the improvements are showing this effect.

Since your aim is desktop performance, I would like it if you always ran
with kernel preemption enabled.  That is what we are targeting for
desktop performance.

Good job,

	Robert Love

