Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282942AbRK0U4S>; Tue, 27 Nov 2001 15:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282946AbRK0U4I>; Tue, 27 Nov 2001 15:56:08 -0500
Received: from zero.tech9.net ([209.61.188.187]:64777 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282942AbRK0Uz5>;
	Tue, 27 Nov 2001 15:55:57 -0500
Subject: Re: procfs bloat, syscall bloat [in reference to cpu affinity]
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: Joe Korty <l-k@mindspring.com>, Ryan Cumming <bodnar42@phalynx.dhs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111271227540.9787-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0111271227540.9787-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 27 Nov 2001 15:56:22 -0500
Message-Id: <1006894583.819.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-27 at 06:32, Ingo Molnar wrote:

> > I am not against a proc interface per se, I would like a proc
> > interface, especially for the reading of affinity values.  But in my
> > view the system call interface should also exist and it should be the
> > dominate way of communicating affinity to processes.
> 
> i'm not against the /proc interface either - on the contrary, i've picked
> it when implementing /proc/irq/<NR>/smp_affinity.

What if we kept the procfs interface for read only and keep both
syscalls for read and write ?

The proc read interface is 2 lines of code in one function ... very much
of my patch would be gone.  Again, personally, I'd like to see proc for
writing and reading, but ...

	Robert Love

