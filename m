Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbSLYJaT>; Wed, 25 Dec 2002 04:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266160AbSLYJaT>; Wed, 25 Dec 2002 04:30:19 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:4749 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S266135AbSLYJaS>;
	Wed, 25 Dec 2002 04:30:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: vda@port.imtp.ilyichevsk.odessa.ua,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] scheduler tunables with contest - exit_weight
Date: Wed, 25 Dec 2002 20:38:25 +1100
User-Agent: KMail/1.4.3
References: <200212220818.22906.conman@kolivas.net> <200212250835.gBP8ZMs17478@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200212250835.gBP8ZMs17478@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212252038.29905.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 26 Dec 2002 12:24 am, Denis Vlasenko wrote:
> On 21 December 2002 19:18, Con Kolivas wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > osdl hardware, contest results, 2.5.52-mm2 with scheduler tunable -
> > exit weight (ew1= exit weight ==1 and so on)
> >
> > io_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > ew0 [5]                 105.3   90      16      22      2.91
> > ew1 [5]                 86.4    97      12      18      2.39
> > ew2 [5]                 74.9    109     9       18      2.07
> > ew3 [5]                 84.2    100     11      19      2.33
> > ew4 [5]                 83.8    102     10      18      2.31
> > ew5 [5]                 89.9    93      12      20      2.48
> > ew6 [5]                 97.5    88      13      20      2.69
> > ew7 [5]                 89.2    95      12      20      2.46
>
> In spite of worrying reports of decreasing single task performance,
> does it make sense to add "null_load" test? ;)

I've simplified the data. There is no significant difference in the no_load 
groups with changes to the scheduler tunables over useful ranges. 

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+CXyRF6dfvkL3i1gRAtSyAJ9XThpp5iCI1FcjDxVOESbm5ialywCgg7Vb
HN+jWurjIwXngqCUOmDWhh0=
=7Iy8
-----END PGP SIGNATURE-----
