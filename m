Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264994AbSIWDFS>; Sun, 22 Sep 2002 23:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265020AbSIWDFS>; Sun, 22 Sep 2002 23:05:18 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:11783
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264994AbSIWDFS>; Sun, 22 Sep 2002 23:05:18 -0400
Subject: Re: [BENCHMARK] gcc3.2 v 2.95.3 (contest and linux-2.5.38)
From: Robert Love <rml@tech9.net>
To: Con Kolivas <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1032750261.3d8e84b5486a9@kolivas.net>
References: <1032750261.3d8e84b5486a9@kolivas.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Sep 2002 23:10:30 -0400
Message-Id: <1032750631.966.1003.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-22 at 23:04, Con Kolivas wrote:

> IO Full Load:
> Kernel                  Time            CPU
> 2.5.38                  170.21          42%
> 2.5.38-gcc32            1405.25         8%

Ugh??  Something is _seriously_ messed up here.

The CPU utilization is only 8% but the time is nearly 10x worse.  You
sure the only difference was the compiler?  I could think gcc-3.2 makes
some poorer choices wrt code optimization, but nothing feasible can come
to mind that would produce such terrible results.

Also, I believe RedHat is compiling their kernel in 8.0 with gcc-3.2,
unless they reintroduced kgcc.  Surely that are not seeing these abysmal
numbers.

	Robert Love

