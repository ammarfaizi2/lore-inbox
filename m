Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131114AbRCGQxn>; Wed, 7 Mar 2001 11:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131118AbRCGQxd>; Wed, 7 Mar 2001 11:53:33 -0500
Received: from [213.97.184.209] ([213.97.184.209]:3968 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S131114AbRCGQxZ>;
	Wed, 7 Mar 2001 11:53:25 -0500
Message-ID: <20010307165243.669.qmail@piraos.com>
Date: Wed, 7 Mar 2001 17:52:43 +0100 (CET)
From: German Gomez Garcia <german@piraos.com>
Subject: Re: Problems with gdb and latest kernels (SIG32)
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
X-Mailer: Mahogany, 0.62 'Mars', compiled for Linux 2.4.2 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Mar 2001 17:46:09 +0100 (CET) German Gomez Garcia <german@piraos.com> wrote:

>         Hello,
> 
>         I'm trying to debug some multithreaded apps, I'm using gdb-5.0 and
> glibc-2.2.2. GDB works without problems for non-threaded apps, but whenever
> I try to debug a threaded one I got "SIG32, Real-time event 32" instead of
> the signal that would tell gdb that a new threaded is created. Anybody has
> also experiment this? Is this a GDB bug? a GLibc bug? or a kernel related
> problem? (kernel has NO bugs :-)
> 
>         I'm using 2.4.2-ac13, but it also happens with 2.4.2, and later,
> doesn't check with previous kernels.

        Reading the ChangeLog for glibc-linuxthreads I found something about
ASSUME_REALTIME_SIGNALS being undef by default, I'm currently recompiling
the C library with it enabled, more info later ...

        - german

-------------------------------------------------------------------------
German Gomez Garcia         | "This isn't right.  This isn't even wrong."
<german@piraos.com>         |                         -- Wolfgang Pauli


