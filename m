Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVGVNZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVGVNZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 09:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVGVNZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 09:25:29 -0400
Received: from a.relay.invitel.net ([62.77.203.3]:37034 "EHLO
	a.relay.invitel.net") by vger.kernel.org with ESMTP id S261278AbVGVNZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 09:25:27 -0400
Date: Fri, 22 Jul 2005 15:25:23 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Ashley <ashleyz@alchip.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel cached memory
Message-ID: <20050722132523.GJ20995@vega.lgb.hu>
Reply-To: lgb@lgb.hu
References: <003401c58ea2$4dfd76f0$5601010a@ashley>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <003401c58ea2$4dfd76f0$5601010a@ashley>
X-Operating-System: vega Linux 2.6.11.11-grsec-vega i686
X-Face: NGLeE64Lq;zU,oU7Xm&_%9Zqxy=c}:!gY]''.P;e$<0OK032-rTfV;h0vil3BKpxD.Z4"}do,d,-{[LF5kU,)_jxVi/a:{N6PZ-]I|fCQ0cr~U9a}I_&COrxF:Zu-q/99Wmvm~O0R-~/[!Apa/hKjcS0e&fhit@zZAm~TA(~2+uC_Y(+rbh-W[hSwv2NmslU(a0rKlfmFWnM0QuzL{}[B+eNbkv2opXGobZIas&bf{&J5a5iijUKDenr)IYG-4:mG(U0_>^NgW3@BFH27NO779r<mSHz[tgO8<7]-e]4`T<.V&
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 05:46:58PM +0800, Ashley wrote:
>    I've a server with 2 Operton 64bit CPU and 12G memory, and this server 
> is used to run  applications which will comsume huge memory,
> the problem is: when this aplications exits,  the free memory of the server 
> is still very low(accroding to the output of "top"), and
> from the output of command "free", I can see that many GB memory was cached 
> by kernel. Does anyone know how to free the kernel cached
> memory? thanks in advance.

It's a very - very - very old and bad logic (at least nowdays) from the
stone age to free up memory. Memory is for using ... If you have memory why
don't you want to use? For an actively used system, memory should be used as
much as possible to maximize the performance. The only problem when kernel
does not want to "give back" used memory for eg caching for an application
though but it's another problem ...

Anyway, want to have 'free memory' is a thing like having dozens of cars
in your garage which don't want to be used ...

-- 
- Gábor
