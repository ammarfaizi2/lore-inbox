Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277564AbRK0MYC>; Tue, 27 Nov 2001 07:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277541AbRK0MXm>; Tue, 27 Nov 2001 07:23:42 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47846 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S277532AbRK0MXj>;
	Tue, 27 Nov 2001 07:23:39 -0500
Date: Tue, 27 Nov 2001 15:21:22 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc-based cpu affinity user interface
In-Reply-To: <E168fCE-0000X7-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0111271518120.15205-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Nov 2001, Alan Cox wrote:

> > fundamental limitation of your approach, and *if* we want to export the
> > cpus_allowed affinity to user-space (which is up to discussion), then the
> > right way (TM) to do it is via a syscall.
>
> HP and others have already implemented chunks of this stuff via
> syscall interfaces. There is a complete pset api.

the sched_set_affinity() syscall tries to be simple, and uses the existing
->cpus_allowed mechanizm. Most of the pset patches i've seen so far are
IMHO overdoing this issue a bit, interface-wise, and do not provide more
than this simple solution.

	Ingo

