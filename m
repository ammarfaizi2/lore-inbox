Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVAWN6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVAWN6A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 08:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVAWN6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 08:58:00 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:39830 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261304AbVAWN56
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 08:57:58 -0500
Message-Id: <200501231357.j0NDvquG032229@localhost.localdomain>
To: Mike Galbraith <efault@gmx.de>
cc: Con Kolivas <kernel@kolivas.org>, "Jack O'Quin" <joq@io.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, linux <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling 
In-reply-to: Your message of "Sun, 23 Jan 2005 08:37:01 +0100."
             <5.2.1.1.2.20050123080400.00bc54e8@pop.gmx.net> 
Date: Sun, 23 Jan 2005 08:57:52 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.197.206.140] at Sun, 23 Jan 2005 07:57:57 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Yup, modern must be the key.  Even Ingo can't help my little ole PIII/500 
>with YMF-740C.  Dang thing can't handle -p64 (alsa rejects that, causing 
>jackd to become terminally upset), and it can't even handle 4 clients at 
>SCHED_FIFO despite latest/greatest RT preempt kernel without xruns.
>
>Bugger... downloaded all that nifty sounding stuff for _nothing_ ;-)  See 
>attached highly trimmed log for humorous results.  (and /tmp isn't the 
>problem here)

correct. the yamaha ymf interfaces are a joke for low latency
audio. they weren't designed correctly at the h/w level, and they
don't work correctly for low latency on Windows with ASIO either. i
don't know what yamaha was thinking, since other companies understood
how to do this long before the first YMF card came out.

--p
