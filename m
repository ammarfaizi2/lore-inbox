Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbSJQUo1>; Thu, 17 Oct 2002 16:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262202AbSJQUo1>; Thu, 17 Oct 2002 16:44:27 -0400
Received: from [203.199.93.15] ([203.199.93.15]:26643 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id <S262201AbSJQUo0>; Thu, 17 Oct 2002 16:44:26 -0400
From: "arun4linux" <arun4linux@indiatimes.com>
Message-Id: <200210172025.BAA30795@WS0005.indiatimes.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "arun4linux" <arun4linux@indiatimes.com>
Subject: event semaphore mechanism in Linux
Date: Fri, 18 Oct 2002 01:49:40 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

  I'm involved in migrating an OS/2 system to Linux, which involves applications as well as drivers.

  I have some doubts/questions on implementing asynchronous,
repeated-interval timer mechanism with semaphore support.
	I meant porting Event Semaphores available in OS/2 to Linux.
(DosCreateEventSem,DosWaitEventSem,DosResetEventSem,DosPostEventSem)

  My need is to have semaphores which will be signalled (posted)
repeated-interval timer mechanis asynchronously.
  In other words,
                I need to implement asynchronous, repeated-interval
timer mechanism with semaphore support.

  We thought of using condition variable (pthread_cond_init, etc..)
and mutex combination to achieve this.

  But it seems pthread's mutex and condition variable synchronization
calls are off limits.  pthread mutex-locking routines are not
asynchronous signal safe.

	It would be helpful, if I could get to know on how to achieve this
event semaphore mechanism in Linux.

	Have a nice time.
  
Warm Regards
Arun



Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy Music, Video, CD-ROM, Audio-Books and Music Accessories from http://www.planetm.co.in

Change the way you talk. Indiatimes presents Valufon, Your PC to Phone service with clear voice at rates far less than the normal ISD rates. Go to http://www.valufon.indiatimes.com. Choose your plan. BUY NOW.

