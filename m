Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKHDaq>; Tue, 7 Nov 2000 22:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129262AbQKHDah>; Tue, 7 Nov 2000 22:30:37 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:36604 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S129130AbQKHDa3>; Tue, 7 Nov 2000 22:30:29 -0500
From: davej@suse.de
Date: Wed, 8 Nov 2000 03:30:14 +0000 (GMT)
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Installing kernel 2.4
In-Reply-To: <3A08947C.1161F13C@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0011080326320.8632-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Jeff V. Merkey wrote:

> > > Detecting the CPU isn't the issue (we already do all this), it's what to
> > > do when you've figured out what the CPU is. Show me code that can
> > > dynamically adjust the alignment of the routines/variables/structs
> > > dependant upon cacheline size.
> 
> ftp.timpanogas.org/manos/manos0817.tar.gz   
> 
> Look in the PE loader

The last time I looked at your code, I stopped reading after I got
to a comment mentioning trade secrets, and intellectual property.

> -- Microsoft's PE loader can do this since everything is RVA based.  
> If you want to take the loader and put it in Linux, be my guest.

Why ??

> You can even combine mutiple i86 segments all compiled under different
> options (or architectures) and bundle them into a single executable file

There is nothing stopping us from doing that now, we just choose not to,
as it would result in a ridiculously oversized kernel. Even if the loader
threw away the non-used segments, I don't think anyone can justify an
on-disk kernel image containing mostly code they never execute.

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
