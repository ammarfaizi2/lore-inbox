Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312988AbSDOGfV>; Mon, 15 Apr 2002 02:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312991AbSDOGfU>; Mon, 15 Apr 2002 02:35:20 -0400
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:3014 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S312988AbSDOGfU>;
	Mon, 15 Apr 2002 02:35:20 -0400
Message-ID: <3CBA74A6.3080407@tmsusa.com>
Date: Sun, 14 Apr 2002 23:35:18 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020414
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: J Sloan <joe@tmsusa.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 final - another data point
In-Reply-To: <3CB9EF57.6010609@tmsusa.com> <3CBA6943.4000701@tmsusa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW -

One other observation was the numerous
syslog entries generated during the test,
which were as follows:


Apr 14 20:40:35 neo kernel: invalidate: busy buffer
Apr 14 20:41:15 neo last message repeated 72 times
Apr 14 20:44:41 neo last message repeated 36 times
Apr 14 20:45:24 neo last message repeated 47 times


J Sloan wrote:

> dbench performance has regressed significantly
> since 2.5.8-pre1; 

>
> 2.5.8-pre1
> --------------
> Throughput 37.8267 MB/sec (NB=47.2833 MB/sec  378.267 MBit/sec)  64 procs
> Throughput 14.0459 MB/sec (NB=17.5573 MB/sec  140.459 MBit/sec)  80 procs
> Throughput 16.2971 MB/sec (NB=20.3714 MB/sec  162.971 MBit/sec)  128 
> procs
>
> 2.5.8-final
> ---------------
> Throughput 5.55008 MB/sec (NB=6.9376 MB/sec  55.5008 MBit/sec)  64 procs
> Throughput 5.82333 MB/sec (NB=7.27916 MB/sec  58.2333 MBit/sec)  80 procs
> Throughput 3.40741 MB/sec (NB=4.25926 MB/sec  34.0741 MBit/sec)  128 
> procs
>



