Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSELW2D>; Sun, 12 May 2002 18:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315447AbSELW2C>; Sun, 12 May 2002 18:28:02 -0400
Received: from adsl-63-207-97-74.dsl.snfc21.pacbell.net ([63.207.97.74]:31734
	"EHLO nova.botz.org") by vger.kernel.org with ESMTP
	id <S315445AbSELW2B> convert rfc822-to-8bit; Sun, 12 May 2002 18:28:01 -0400
X-Mailer: exmh version 2.5_20020419 04/19/2002 with nmh-1.0.4
To: Douglas Gilbert <dougg@torque.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reproducible SMP kernel deadlock in SCSI generic driver (sg) 
In-Reply-To: Message from Douglas Gilbert <dougg@torque.net> 
   of "Sun, 05 May 2002 13:45:04 EDT." <3CD56FA0.FBCBD69B@torque.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Sun, 12 May 2002 15:24:16 -0700
Message-ID: <7455.1021242256@localhost>
From: Jurgen Botz <jurgen@botz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
> Jurgen Botz <jurgen@botz.org>
> > The sg module reproducibly deadlocks the kernel for me after some time
> > of heavy I/O on an SMP system.  This appears to be true in /all/ kernel
> > versions... I can reproduce it very reliably now in 2.4.19-pre8 and

This appears to have been a false alarm... my humble appologies!

I'm not sure exactly what was going on, but it may be that I had
some miscompiled kernels... all kernels I was testing with when
I reported this were compiled on RedHat 7.2.93 (the skipjack
beta) with gcc-2.96.  A 2.4.19-pre8 SMP kernel compiled with 
gcc-3.0.4 does not exhibit this problem.

:j


-- 
Jürgen Botz                       | While differing widely in the various
jurgen@botz.org                   | little bits we know, in our infinite
                                  | ignorance we are all equal. -Karl Popper


