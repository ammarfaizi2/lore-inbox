Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSFEHhn>; Wed, 5 Jun 2002 03:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSFEHhm>; Wed, 5 Jun 2002 03:37:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29013 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312558AbSFEHhk>; Wed, 5 Jun 2002 03:37:40 -0400
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: J Sloan <joe@tmsusa.com>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <Pine.LNX.4.44.0206041418460.2614-100000@waste.org>
	<E17FQPj-0001Rr-00@starship> <3CFD8C07.6030607@tmsusa.com>
	<E17FS6T-0001UR-00@starship>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Jun 2002 01:28:14 -0600
Message-ID: <m1lm9uw5f5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net> writes:

> Improving the average latency of systems is a worthy goal, and there's
> no denying that 'sorta realtime' has its place, however it's no substitute
> for the real thing.  A soft realtime system screws up only on occasion,
> but - bugs excepted - a hard realtime system *never* does.

Engineering assumption.  Your hardware and/or software always contains
at least one bug.  Therefore even in hard real time you must design
and code for the failure case.  Hard real time is just doing
everything humanly possible to meet it's deadlines. 

The difference with soft real time, is that something that is humanly
possible to do was left off.

Despite the strong relationship to mathematics there are no absolutes
in computer science.  Especially hard real time.

Eric
