Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272176AbRHWAw7>; Wed, 22 Aug 2001 20:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272175AbRHWAwu>; Wed, 22 Aug 2001 20:52:50 -0400
Received: from [209.195.52.30] ([209.195.52.30]:4390 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S272173AbRHWAwm>;
	Wed, 22 Aug 2001 20:52:42 -0400
Date: Wed, 22 Aug 2001 16:35:11 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: Jeff Busch <jbusch@half.com>
cc: <linux-kernel@vger.kernel.org>, <roswell-list@redhat.com>
Subject: Re: [problem] RH 2.4.7-2 kernel slows to a crawl under heavy i/o
In-Reply-To: <NEBBJGKHGENBAPAMDILGIEFGGOAA.jbusch@half.com>
Message-ID: <Pine.LNX.4.33.0108221633280.3868-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to duplicate a similar problem in my lab that happened
to me on a production box with 2.4.5. do you have a test that will allow
you to replicate the problem at will?

David Lang

 On Wed, 22 Aug 2001, Jeff Busch
wrote:

> Date: Wed, 22 Aug 2001 16:57:35 -0500
> From: Jeff Busch <jbusch@half.com>
> To: linux-kernel@vger.kernel.org, roswell-list@redhat.com
> Subject: [problem] RH 2.4.7-2 kernel slows to a crawl under heavy i/o
>
> machine:  Compaq Proliant DL360 w/4GB mem, dual 36GB SCSI drives
> OS:	    RedHat 7.1 + errata updates, kernel-enterprise-2.4.7-2.i686.rpm from
> 'Roswell 2'
>
> Under heavy I/O (Apache and a custom C++ module which do lots of mmap and
> munmap calls over large data sets - 7GB total), the machine slows to a
> crawl.  The problem persists even after live traffic to the machine ceases.
> A top listing shows both cpu's at 100% system.  Any commands (ps, uname,
> whatever) take minutes to return results.
>
> The same setup on RH 6.2 with 2.4.3-ac3 works fine.  Please let me know what
> information may be useful to debugging this problem (no oops yet), and other
> kernels to try; I'm looking at 2.4.8-ac9 right now.
>
> Thanks,
> Jeff Busch
> System Administrator
> Half.com - an eBay company
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
