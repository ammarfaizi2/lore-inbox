Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264934AbSKINEA>; Sat, 9 Nov 2002 08:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265091AbSKINEA>; Sat, 9 Nov 2002 08:04:00 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:3712 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S264934AbSKIND7> convert rfc822-to-8bit; Sat, 9 Nov 2002 08:03:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Date: Sun, 10 Nov 2002 00:09:40 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br, Andrea Arcangeli <andrea@suse.de>
References: <200211091300.32127.conman@kolivas.net> <200211091612.08718.conman@kolivas.net> <20021109112135.GB31134@suse.de>
In-Reply-To: <20021109112135.GB31134@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211100009.55844.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>On Sat, Nov 09 2002, Con Kolivas wrote:
>> >You're showing a big shift in behaviour between 2.4.19 and 2.4.20-rc1.
>> >Maybe it doesn't translate to worsened interactivity.  Needs more
>> >testing and anaysis.
>>
>> Sounds fair enough. My resources are exhausted though. Someone else have
>> any thoughts?
>
>Try setting lower elevator passover values. Something ala
>
># elvtune -r 64 /dev/hda
>
>(or whatever your drive is)

Heres some more data:

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20-rc1 [2]          1142.2  6       90      10      16.00
2420rc1r64 [3]          575.0   12      43      10      8.05

That's it then. Should I run a family of different values and if so over what 
range?

Cheers,
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9zQkXF6dfvkL3i1gRAggJAKCOAWzrTxFlnPbOftzMAXPnvI7KVQCfWqUC
iDVmD1UcPDNPWCfQmlBF9yk=
=Q299
-----END PGP SIGNATURE-----

