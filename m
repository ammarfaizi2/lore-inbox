Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262012AbRE2Cmg>; Mon, 28 May 2001 22:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262013AbRE2Cm0>; Mon, 28 May 2001 22:42:26 -0400
Received: from [209.10.41.242] ([209.10.41.242]:56477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262012AbRE2CmM>;
	Mon, 28 May 2001 22:42:12 -0400
Date: Tue, 29 May 2001 11:32:09 +0900
Message-Id: <200105290232.f4T2W9m00876@bellini.kjist.ac.kr>
From: "G. Hugh Song" <ghsong@kjist.ac.kr>
To: linux-kernel@vger.kernel.org
Subject: Re: Plain 2.4.5 VM...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik wrote: 
> 
> Ouch! When compiling MySql, building sql_yacc.cc results in a ~300M 
> cc1plus process size. Unfortunately this leads the machine with 380M of 
> RAM deeply into swap: 
> 
> Mem: 381608K av, 248504K used, 133104K free, 0K shrd, 192K 
> buff 
> Swap: 255608K av, 255608K used, 0K free 215744K 
> cached 
> 
> Vanilla 2.4.5 VM. 
> 

This bug known as the swap-reclaim bug has been there for a while since 
around 2.4.4.  Rick van Riel said that it is in the TO-DO list.
Because of this, I went back to 2.2.20pre2aa1 on UP2000 SMP.

IMHO, the current 2.4.* kernels should still be 2.3.*.  When this bug
is removed, I will come back to 2.4.*.

Regards,

Hugh

