Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273163AbRIWCzM>; Sat, 22 Sep 2001 22:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273210AbRIWCzD>; Sat, 22 Sep 2001 22:55:03 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:22058 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273132AbRIWCyx> convert rfc822-to-8bit; Sat, 22 Sep 2001 22:54:53 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: safemode <safemode@speakeasy.net>, george anzinger <george@mvista.com>,
        Oliver Xymoron <oxymoron@waste.org>, Andrea Arcangeli <andrea@suse.de>,
        Roger Larsson <roger.larsson@norran.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200109222347.f8MNlMG25157@zero.tech9.net>
In-Reply-To: <Pine.LNX.4.30.0109201659210.5622-100000@waste.org>
	<20010922211919Z272247-760+15646@vger.kernel.org>  
	<200109222347.f8MNlMG25157@zero.tech9.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.21.20.26 (Preview Release)
Date: 22 Sep 2001 22:54:49 -0400
Message-Id: <1001213691.873.15.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-22 at 19:46, Dieter Nützel wrote:
> Nope.
> If you would have read (all) posts about this and related threads you should 
> have noticed that I am and others running SCSI systems...
> 
> >
> > even i dont get any skips when i run the player at nice -n -20. 
> 
> During dbench 16/32 and higher? Are you sure?

I can't speak for safemode, but doing something like:

[22:43:47]rml@phantasy:~$ mpg321 /home/mp3/Get_Up_Kids-Woodson.mp3 &
[22:52:03]rml@phantasy:~$ dbench 16

I don't get any blips (nothing over 0.5s, anyhow, I would wager).

This is a P3-733, i815 board, 384MB PC133, AHA-2940U2W, U2W IBM 9GB system.

Linux 2.4.9-ac14 + preempt + and more

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

