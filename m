Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSEMCtf>; Sun, 12 May 2002 22:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315493AbSEMCte>; Sun, 12 May 2002 22:49:34 -0400
Received: from web20110.mail.yahoo.com ([216.136.226.47]:8459 "HELO
	web20110.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315491AbSEMCtd>; Sun, 12 May 2002 22:49:33 -0400
Message-ID: <20020513024933.74553.qmail@web20110.mail.yahoo.com>
Date: Sun, 12 May 2002 19:49:33 -0700 (PDT)
From: Jennifer Huang <carrothh@yahoo.com>
Subject: Re: Question about cpu time accuracy.
To: Kurt Wall <kwall@kurtwerks.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020512185709.C623@marta>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks very much for your information.

Just one more question, does it work for 2.4.18?
Thanks.

--- Kurt Wall <kwall@kurtwerks.com> wrote:
> Scribbling feverishly on May 12, Jennifer Huang
> managed to emit:
> > Hi all,
> > 
> > I have a question about cpu time accuracy.
> > 
> > I am using kernel 2.4.18. But, when I tried
> "utime"
> > and "nanosleep" to get a process suspended, it
> only
> > worked in 10ms granularity, and it's no way to
> sleep
> > for 1 microsecond.
> 
> The standard kernel timer has a resolution of 1/HZ,
> which is 10ms on 
> an x86. You could try a scheduling policy of
> SCHED_FIFO or SCHED_RR,
> but this only gets you 2ms resolution. 
> 
> > Anyone can help me out of this?
> 
> There are patches available for high resolution
> timers:
> 
> http://sourceforge.net/projects/high-res-timers/
> http://www.cs.wisc.edu/paradyn/libhrtime/
> 
> Kurt
> -- 
> Anarchy may not be the best form of government, but
> it's better than no
> government at all.
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com
