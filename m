Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276099AbRJBSVa>; Tue, 2 Oct 2001 14:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276110AbRJBSVW>; Tue, 2 Oct 2001 14:21:22 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:56747 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP
	id <S276099AbRJBSVG>; Tue, 2 Oct 2001 14:21:06 -0400
Date: Tue, 2 Oct 2001 20:21:14 +0200 (MEST)
From: Lars Christensen <larsch@cs.auc.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 hangs on console switch
In-Reply-To: <E15oTXp-0005Mk-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.33.0110022019330.12401-100000@mega.cs.auc.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, 2 Oct 2001, Alan Cox wrote:

> > Problem: Kernel 2.4.10 hangs when console is switched from X to text mode,
> > either using C-A-Fn or when shutting down or reboot from X (with a black
> > screen). 2.4.9 does not have this problem.
> >
> > There is nothing about the hang in the log files. Kernel is configured for
> > Athlon/K7 processor.
>
> You are using the Nvidia drivers aren't you. They seem to have timing
> dependant screen mode switch problems. The timing has changed in 2.4.10

Not the nvidia supplied drivers. I am using the nvidia driver (nv)  that
comes with XFree86 4.1.0. I did not compile in kernel agpgart and driver
support.

-- 
Lars Christensen, larsch@cs.auc.dk

