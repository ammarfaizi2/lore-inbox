Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267451AbSLSApr>; Wed, 18 Dec 2002 19:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267453AbSLSApq>; Wed, 18 Dec 2002 19:45:46 -0500
Received: from mail.internetwork-ag.de ([217.6.75.131]:15265 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S267451AbSLSApq>; Wed, 18 Dec 2002 19:45:46 -0500
Message-ID: <3E011899.A3FBDAF1@inw.de>
Date: Wed, 18 Dec 2002 16:53:45 -0800
From: Till Immanuel Patzschke <tip@inw.de>
Organization: interNetwork AG
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: lse-tech <lse-tech@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 15000+ processes -- poor performance ?!
References: <3E0116D6.35CA202A@inw.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

forgot the kernel version (2.4.20aa1)...

Till Immanuel Patzschke wrote:

> Dear List(s),
>
> as part of my project I need to run a very high number of processes/threads on a
> linux machine.  Right now I have a Dual-PIII 1.4G w/ 8GB RAM -- I am running
> 4000 processes w/ 2-3 threads each totaling in a process count of 15000+
> processes (since Linux doesn't really distinguish between threads and
> processes...).
> Once I pass the 10000 (+/-) pocesses load increases drastically (on startup,
> although it returns to normal), however the system time (on one processor)
> reaches for 54% (12061 procs) while the only non sleeping process is top -- the
> system is basically doing nothing (except scheduling the "nothing" which
> consumes significant system time).
> Is there anything I can do to reduce that system load/time?  (I haven't been
> able to exactly define the "line" but it definitly gets worse the more processes
> need to be handled.)
> Does any of the patchsets address this particular problem?
> BTW: The processes are all alike...
>
> Thanks for you help!
>
> Immanuel
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

