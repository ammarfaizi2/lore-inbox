Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264846AbRGITjQ>; Mon, 9 Jul 2001 15:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbRGITjG>; Mon, 9 Jul 2001 15:39:06 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264846AbRGITi7>; Mon, 9 Jul 2001 15:38:59 -0400
Date: Mon, 9 Jul 2001 15:25:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ketil Froyn <ketil@froyn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 0k shared?
In-Reply-To: <Pine.LNX.4.33.0107091622510.1031-100000@ketil.np>
Message-ID: <Pine.LNX.3.95.1010709151914.1001A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2001, Ketil Froyn wrote:

> Hi.
> 
> This may be a stupid question, but I found this strange. In making a small
> benchmarking utility, I made the following directory structure by mistake:
> a/a/a/a/a/a/a/a/a/a/.....
> 
> By ..... I mean this goes on and on, there were around 18 thousand
> directories inward like this. A great example of the damage a bug in a
> recursive program can do ;) Anyway, I've removed it now (btw, rm -rf on
> this sigsegved :D).
> 
> And now for the question. My /proc/meminfo looks like this:
[SNIPPED]

Not related. Somebody decided that it was too expensive to
keep track of shared memory usage so this field has been blank
for some time now.

Of course, the shared memory usage could be calculated by
the task that accesses the /proc file-system so the reason
cited above could go away. The cost would be that it wastes
a whole page of memory, but memory is plentiful now-a-days.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


