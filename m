Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285229AbSBVJGH>; Fri, 22 Feb 2002 04:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSBVJF4>; Fri, 22 Feb 2002 04:05:56 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:3471 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S285229AbSBVJFo>; Fri, 22 Feb 2002 04:05:44 -0500
Date: Fri, 22 Feb 2002 10:54:37 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: svetljo <galia@st-peter.stw.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org, <linux-xfs@oss.sgi.com>
Subject: Re: linux-2.5.5-dj1 + xfs-cvs --- kernel bug at elevator.c : 237!
In-Reply-To: <3C7607A7.2020804@st-peter.stw.uni-erlangen.de>
Message-ID: <Pine.LNX.4.44.0202221053020.30230-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, svetljo wrote:

> i tried to get patch-2.5.5dj1 in linux-2.5.5-xfs-cvs
> but thats what i got
> #####################################
> Activating swap partitions:        OK
> Finding modules dependancies:  OK
> Kernel Bug at elevator.c : 237!
> Invalid operand: 0000
> CPU: 0
> EIP: 0010:[<c0267730>]  Not tainted
> EFLAGS: 00010002
> eax: def5dd04 ebx: c0415540 ecx: c0415540 edx: df69501c
> esi: c148ac40  edi: 00000000 ebp: 00000202 ecp: c0373e88
> ds: 0018     es: 0018    ss: 0018
> Process swapper(pid: 0, threadinfo=c0372000 task=c0359040)
> Stack: c0415540 c0415540 00000002 c027b2cb c0415540 df69501c c0415540 
> dfff1980
>            00000000 00000001 c0373ec0 c0373ec0 00000000 00000001 
> c0373ec0 c0373ec0
>            c0415540 df69501c df69400c c0415540 c0a3f5f2 c0415540 
> df69501c  00000002
> Call Trace: [<c027b2cb>] [<e0a3f5f2>] [<e0a3f6d6>] [<e0a3f600>] [<c027b0af>]
>  [<e0a3f600>] [<c010ac9e>] [<c010aef6>] [<c0106f20>] [<c0106f20>] 
> [<c0106f20>]
>  [<c0106f4a>] [<c0106fd2>] [<c0105000>]
> 
> Code: 0f 01 ed 00 43 ad 33 c0 8b 42 1c a9 04 00 00 00 75 06 83 e0
> <0> Kernel panic: Aiee,killing interrupt handler !
> In interrupt handler -- not syncing

A backtrace would be more handy here, have you searched the archives on 
wether someone has hit this particular bug with 2.4.x+XFS?

Regards,
	Zwane Mwaikambo


