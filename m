Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266122AbSLYIdy>; Wed, 25 Dec 2002 03:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266121AbSLYIdy>; Wed, 25 Dec 2002 03:33:54 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:21255 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263991AbSLYIdw>; Wed, 25 Dec 2002 03:33:52 -0500
Message-Id: <200212250835.gBP8ZMs17478@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] scheduler tunables with contest - exit_weight
Date: Wed, 25 Dec 2002 11:24:10 -0200
X-Mailer: KMail [version 1.3.2]
References: <200212220818.22906.conman@kolivas.net>
In-Reply-To: <200212220818.22906.conman@kolivas.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 December 2002 19:18, Con Kolivas wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> osdl hardware, contest results, 2.5.52-mm2 with scheduler tunable -
> exit weight (ew1= exit weight ==1 and so on)
>
> io_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> ew0 [5]                 105.3   90      16      22      2.91
> ew1 [5]                 86.4    97      12      18      2.39
> ew2 [5]                 74.9    109     9       18      2.07
> ew3 [5]                 84.2    100     11      19      2.33
> ew4 [5]                 83.8    102     10      18      2.31
> ew5 [5]                 89.9    93      12      20      2.48
> ew6 [5]                 97.5    88      13      20      2.69
> ew7 [5]                 89.2    95      12      20      2.46

In spite of worrying reports of decreasing single task performance,
does it make sense to add "null_load" test? ;)
--
vda
