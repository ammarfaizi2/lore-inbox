Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbSKIDVD>; Fri, 8 Nov 2002 22:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbSKIDVD>; Fri, 8 Nov 2002 22:21:03 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:10880 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S264624AbSKIDVC> convert rfc822-to-8bit; Fri, 8 Nov 2002 22:21:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>, Jens Axboe <axboe@suse.de>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
Date: Sat, 9 Nov 2002 14:26:52 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br, Andrea Arcangeli <andrea@suse.de>
References: <200211091300.32127.conman@kolivas.net> <3DCC74B0.47A462A9@digeo.com>
In-Reply-To: <3DCC74B0.47A462A9@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211091426.54403.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>Con Kolivas wrote:
>> io_load:
>> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>> 2.4.18 [3]              474.1   15      36      10      6.64
>> 2.4.19 [3]              492.6   14      38      10      6.90
>> 2.4.19-ck9 [2]          140.6   49      5       5       1.97
>> 2.4.20-rc1 [2]          1142.2  6       90      10      16.00
>> 2.4.20-rc1aa1 [1]       1132.5  6       90      10      15.86
>
>2.4.20-pre3 included some elevator changes.  I assume they are the
>cause of this.  Those changes have propagated into Alan's and Andrea's
>kernels.   Hence they have significantly impacted the responsiveness
>of all mainstream 2.4 kernels under heavy writes.
>
>(The -ck patch includes rmap14b which includes the read-latency2 thing)

Thanks for the explanation. I should have said this was ck with compressed 
caching; not rmap.

Con.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9zIB8F6dfvkL3i1gRAs6lAJ0f7E9HTlNl5cOaDnmSfw9gi0QLQgCfV3jh
kaG/a1TzlUviOGz5Ci895uA=
=TyH7
-----END PGP SIGNATURE-----

