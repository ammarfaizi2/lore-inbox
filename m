Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbVIVTd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbVIVTd5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbVIVTd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:33:57 -0400
Received: from smtp-4.llnl.gov ([128.115.41.84]:25540 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S1030183AbVIVTd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:33:56 -0400
Date: Thu, 22 Sep 2005 12:33:52 -0700 (PDT)
From: Chuck Harding <charding@llnl.gov>
Subject: Re: Arrr! Linux v2.6.14-rc2 (was [RT] build error with 2.6.14-rc2-rt1)
In-reply-to: <Pine.LNX.4.63.0509221058300.17628@ghostwheel.llnl.gov>
To: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Message-id: <Pine.LNX.4.63.0509221228010.17628@ghostwheel.llnl.gov>
Organization: Lawrence Livermore National Laboratory
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Pine/4.62 (X11; U; Linux i686; en-US; rv:2.6.11-rc2-mm1)
References: <Pine.LNX.4.63.0509221058300.17628@ghostwheel.llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2005, Chuck Harding wrote:

>  CC      kernel/power/poweroff.o
>  LD      kernel/power/built-in.o
>  CC      kernel/acct.o
>  CC      kernel/kexec.o
>  GZIP    kernel/config_data.gz
>  IKCFG   kernel/config_data.h
>  CC      kernel/configs.o
>  CC      kernel/audit.o
> kernel/audit.c: In function `audit_serial':
> kernel/audit.c:617: error: `SPIN_LOCK_UNLOCKED' undeclared (first use in this 
> function)
> kernel/audit.c:617: error: (Each undeclared identifier is reported only once
> kernel/audit.c:617: error: for each function it appears in.)
> make[1]: *** [kernel/audit.o] Error 1
> make: *** [kernel] Error 2
>
>
> .config is attached
>
>

Oops! My bad!! This was really due to 2.6.14-rc2 *not* rt1 - sorry to
be pointing fingers at the wrong parties - next time I'll check more
carefully before submitting a bug report B-$

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate         ICCD            Fax: 925-423-6961
Lawrence Livermore National Laboratory      Computation Directorate
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
------------------ http://tinyurl.com/5w5ey -----------------------
-- I like cats, but I don't think I could eat a whole one. --
