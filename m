Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSEVW0u>; Wed, 22 May 2002 18:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315334AbSEVW0t>; Wed, 22 May 2002 18:26:49 -0400
Received: from murphys.services.quay.plus.net ([212.159.14.225]:11682 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S315285AbSEVW0s>; Wed, 22 May 2002 18:26:48 -0400
Message-ID: <002501c201cb$b25a0cb0$0501a8c0@Stev.org>
From: "James Stevenson" <mail-lists@stev.org>
To: "Samuel Flory" <sflory@rackable.com>, "Eric Weigle" <ehw@lanl.gov>
Cc: "Linux kernel mailing list \(lkml\)" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020522165320.GC18059@lanl.gov> <3CEBE38A.8020808@rackable.com>
Subject: Re: Safety of -j N when building kernels?
Date: Wed, 22 May 2002 21:03:08 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    The only major issue I've seen is the build may fail if you run out
> of file handles, or other resources.  The build will fail with an
> "unable to fork" error.  When I was at VA Linux I often compiled kernel
> for use with a make -j 16, or -j 8.  I seem to remember having to play
> with ulimit, and /proc/?/file-max to get enough file handles.
>
>
> PS- You should also consider logging the output of your compile to a
> file.  As your other jobs will continue for sometime before the make
> fails.  Often preventing you from easily finding the actual compile error.

of course you should only really need to log the stderr or redirect stderr
to somewhere you can see it.


