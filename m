Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289066AbSA1APs>; Sun, 27 Jan 2002 19:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289067AbSA1APj>; Sun, 27 Jan 2002 19:15:39 -0500
Received: from sushi.toad.net ([162.33.130.105]:62364 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S289066AbSA1APc>;
	Sun, 27 Jan 2002 19:15:32 -0500
Subject: Re: 2.4.18-pre7 slow ... apm problem
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 27 Jan 2002 19:15:38 -0500
Message-Id: <1012176940.2576.102.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) keyboard rate is a bit slow on 2.4.18-pre7 compared to
>    2.4.18-pre6.
> 2) On vmware 3.0, ping localhost is very slow. 2.4.18-pre6
>    has not such problem.
>
> After disabling CONFIG_APM_CPU_IDLE, the system works fast again.
> With pre6 or earlier versions, system works fine though even with
> CONFIG_APM_CPU_IDLE enabled.

Idle handling in the apm driver was modified in 2.4.18-pre7 .
Back to the drawing board ...

Note that you can disable apm idle handling by setting the
apm idle_threshold parameter to 100.  You don't need to
recompile the kernel.



