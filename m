Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277833AbRJRR0M>; Thu, 18 Oct 2001 13:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277842AbRJRR0C>; Thu, 18 Oct 2001 13:26:02 -0400
Received: from femail8.sdc1.sfba.home.com ([24.0.95.88]:12768 "EHLO
	femail8.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S277833AbRJRRZu>; Thu, 18 Oct 2001 13:25:50 -0400
Date: Thu, 18 Oct 2001 12:26:18 -0500
To: linux-kernel@vger.kernel.org
Cc: forming@home.com
Subject: Re: Fwd: VM testing with mtest, 2.4.12-ac3, 2.4.12-ac3+riel's patches, and 2.4.13aa1
Message-ID: <20011018122618.A17682@cy599856-a.home.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, forming@home.com
In-Reply-To: <20011018015112.A3763@cy599856-a.home.com> <20011018090646.B1144@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011018090646.B1144@turbolinux.com>
User-Agent: Mutt/1.3.23i
X-Editor: GNU Emacs 20.7.2
X-Operating-System: Debian GNU/Linux 2.4.13-pre3 i586 K6-3+
X-Uptime: 12:16:06 up 12:24,  2 users,  load average: 0.00, 0.00, 0.00
From: Josh McKinney <forming@home.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Thu, Oct 18, 2001 at 09:06:46AM -0600, Andreas Dilger wrote:
> On Oct 18, 2001  01:51 -0500, Josh McKinney wrote:
> > This is a report of the mtest01 scripts posted by rwhron@earthlink.net
> > a day orso ago.
> > 
> > The numbers are rather interesting.  While the latency of the ac kernels is
> > definitely better, the song only dropped out for a second or two in the
> > begining but that was it.  The aa kernel drops out more frequently throughout
> > the test, but the amount of memory allocated is almost twice as much as with
> > the ac kernels.
> 
> -ac kernel:
> > Averages for 10 mtest01 runs
> > bytes allocated:                    134427443.2
> > User time (seconds):                2.546
> > System time (seconds):              1.370
> > Elapsed (wall clock) time:          4.798
> > Percent of CPU this job got:        89.1%
> > Major (requiring I/O) page faults:  103.8
> > Minor (reclaiming a frame) faults:  32702
> 
> -ac kernel + Rik's patches:
> > Averages for 10 mtest01 runs
> > bytes allocated:                    124885401.6
> > User time (seconds):                2.380
> > System time (seconds):              1.253
> > Elapsed (wall clock) time:          4.401
> > Percent of CPU this job got:        89.1%
> > Major (requiring I/O) page faults:  100.2
> > Minor (reclaiming a frame) faults:  30363.3
> 
> Linus kernel:
> > Averages for 10 mtest01 runs
> > bytes allocated:                    288148684.8
> > User time (seconds):                5.496
> > System time (seconds):              3.003
> > Elapsed (wall clock) time:          12.250
> > Percent of CPU this job got:        68.9%
> > Major (requiring I/O) page faults:  103.5
> > Minor (reclaiming a frame) faults:  70380.6
> 
> Note that the Linus kernel has allocated twice as much memory.  What does that
> mean exactly?  The user/system/wall time is also twice as high.  Somehow I
> don't think you are having an equal test.
> 
> Cheers, Andreas

I thought that was strange myself, which is why I metioned it in the begining.
Also when I seen the results I reran the tests, all in single user mode,
freshreboot, put linux single on the CL, voila, sh mtest01.sh & mpg123 some.mp3,
and there is my test.  I know the numbers are crazy and I also know the
importance of having all other variables the same.

Josh
-- 
Linux, the choice                | Animals can be driven crazy by putting too 
of a GNU generation       -o)    | many in too small a pen. Homo sapiens is
Kernel 2.4.13-pre3         /\    | the only animal that voluntarily does this 
on a i586                 _\_v   | to himself.   -- Lazarus Long 
                                 | 
