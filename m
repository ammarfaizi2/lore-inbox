Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbSKXNTw>; Sun, 24 Nov 2002 08:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261286AbSKXNTw>; Sun, 24 Nov 2002 08:19:52 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:25868 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S261218AbSKXNTv>;
	Sun, 24 Nov 2002 08:19:51 -0500
Message-ID: <3DE0D2DE.1090006@iinet.net.au>
Date: Mon, 25 Nov 2002 00:23:42 +1100
From: Nero <neroz@iinet.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] rmap15, rmap14c and rc1aa1 with contest
References: <3DE0D157.9020906@iinet.net.au>
In-Reply-To: <3DE0D157.9020906@iinet.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nero wrote:

> noload:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.19-rmap15 [1]       84.6    95      0       0       1.00
> 2.4.19-rmap14c [1]      84.2    96      0       0       1.00
> 2.4.20-rc1aa1 [2]       41.0    49      0       0       inf

The time for rc1aa1 here is obviously wrong - this is a bug in contest, 
according to Dr. Kolivas :-)

>
> process_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.19-rmap15 [1]       140.8   55      133     45      1.66
> 2.4.19-rmap14c [1]      139.4   56      126     45      1.65
> 2.4.20-rc1aa1 [2]       133.9   14      211     84      inf
>
> io_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.19-rmap15 [1]       164.8   51      33      19      1.95
> 2.4.19-rmap14c [1]      160.1   53      33      21      1.90
> 2.4.20-rc1aa1 [1]       166.2   49      44      23      inf
>
> read_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.19-rmap15 [1]       0.0     0       0       7       0.00
> 2.4.19-rmap14c [1]      121.0   72      20      7       1.44
> 2.4.20-rc1aa1 [1]       111.2   79      34      14      inf
>
> rmap15 OOM'd the cc1 process twice and fscked this run up.
>
> list_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.19-rmap15 [1]       99.2    84      0       7       1.17
> 2.4.19-rmap14c [1]      100.7   83      0       7       1.20
> 2.4.20-rc1aa1 [1]       96.7    85      0       8       inf
>
> mem_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.19-rmap15 [1]       111.2   80      96      8       1.31
> 2.4.19-rmap14c [1]      106.1   82      96      9       1.26
> 2.4.20-rc1aa1 [1]       126.3   66      77      3       inf
>


