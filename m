Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269677AbSIRXuV>; Wed, 18 Sep 2002 19:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269681AbSIRXuV>; Wed, 18 Sep 2002 19:50:21 -0400
Received: from [12.36.124.2] ([12.36.124.2]:42737 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S269677AbSIRXuU>; Wed, 18 Sep 2002 19:50:20 -0400
Mime-Version: 1.0
Message-Id: <p05111a08b9aec118552d@[10.2.2.25]>
In-Reply-To: <3D88F2D7.DD8519E6@digeo.com>
References: <1032360386.3d8891c2bc3d3@kolivas.net>
 <3D88ACB6.6374E014@digeo.com> <1032383868.3d88ed7c4cf2d@kolivas.net>
 <3D88F2D7.DD8519E6@digeo.com>
Date: Wed, 18 Sep 2002 16:55:13 -0700
To: Andrew Morton <akpm@digeo.com>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: NMI watchdog stability
Cc: linux-kernel@vger.kernel.org, kaos@ocs.com.au
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back in March 2001, Keith Owens wrote and Andrew Morton replied:
At 4:47pm -0700 9/18/02, Jonathan Lundell wrote:
>  >
>>  Am I the only person who is annoyed that nmi watchdog is now off by
>>  default and the only way to activate it is by a boot parameter? You
>>  cannot even patch the kernel to build a version that has nmi watchdog
>>  on because the startup code runs out of the __setup routine, no boot
>>  parameter, no watchdog.
>
>It was causing SMP boxes to crash mysteriously after
>several hours or days. Quite a lot of them. Nobody
>was able to explain why, so it was turned off.

This was in the context of 2.4.2-ac21. More of the thread,with no 
conclusive result, can be found at 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0103.2/0906.html

Was there any resolution? Was the problem real, did it get fixed, and 
is it safe to turn on the local-APIC-based NMI ticker on a 2.4.9 SMP 
system? (I'm stuck with 2.4.9, actually Red Hat's 2.4.9-31, for 
external reasons.) What was the nature of the mysterious crashes?

Thanks.
-- 
/Jonathan Lundell.
