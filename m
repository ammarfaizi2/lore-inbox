Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277541AbRKMRhN>; Tue, 13 Nov 2001 12:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277514AbRKMRhF>; Tue, 13 Nov 2001 12:37:05 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:8964 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277435AbRKMRg6>; Tue, 13 Nov 2001 12:36:58 -0500
Date: Tue, 13 Nov 2001 14:18:42 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Craig I. Hagan" <hagan@cih.com>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org,
        lars.nakkerud@compaq.com
Subject: Re: Tuning Linux for high-speed disk subsystems
In-Reply-To: <Pine.LNX.4.33.0111130939030.1083-200000@svr.cih.com>
Message-ID: <Pine.LNX.4.21.0111131418130.2030-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Nov 2001, Craig I. Hagan wrote:

> > After some testing at Compaq's lab in Oslo, I've come to the conclusion
> > that Linux cannot scale higher than about 30-40MB/sec in or out of a
> > hardware or software RAID-0 set with several stripe/chunk sizes tried out.
> > The set is based on 5 18GB 10k disks running SCSI-3 (160MBps) alone on a
> > 32bit/33MHz PCI bus.
> 
> this isn't quite true. use either the RH kernel, the -ac series, or the
> attached patch (for 2.4.15-pre4). Then set /proc/sys/vm/max-readahead to 511 or
> 1023 (power of 2 minus 1)
> 
> this should allow you to generate large enough io's for streaming reads to do
> what you are looking for.

Craig,

This patch is already on my pending list. 

So if Linus does not apply it, I will.

