Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130650AbRCITqc>; Fri, 9 Mar 2001 14:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130662AbRCITqO>; Fri, 9 Mar 2001 14:46:14 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:30735 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130650AbRCITng>;
	Fri, 9 Mar 2001 14:43:36 -0500
Date: Fri, 9 Mar 2001 20:42:43 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>,
        Oswald Buddenhagen <ob6@inf.tu-dresden.de>,
        linux-kernel@vger.kernel.org
Subject: Re: static scheduling - SCHED_IDLE?
Message-ID: <20010309204243.E13320@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.20.0103082118510.4425-100000@falcon.etf.bg.ac.yu> <Pine.LNX.4.33.0103081747010.1314-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0103081747010.1314-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Thu, Mar 08, 2001 at 05:47:25PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> > > Of course. Now we just need the code to determine when a task
> > > is holding some kernel-side lock  ;)
> >
> > couldn't it just be indicated on actual locking the resource?
> 
> It could, but I doubt we would want this overhead on the locking...

Just raise the priority whenever the task's in kernel mode.  Problem solved.

-- Jamie
