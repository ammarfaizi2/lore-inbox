Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290767AbSCDBKl>; Sun, 3 Mar 2002 20:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289621AbSCDBKb>; Sun, 3 Mar 2002 20:10:31 -0500
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:43995 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S289571AbSCDBKV>;
	Sun, 3 Mar 2002 20:10:21 -0500
Message-ID: <3C82C95D.5010703@tmsusa.com>
Date: Sun, 03 Mar 2002 17:09:49 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020207
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: latency & real-time-ness.
In-Reply-To: <E16hd1T-0005QW-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>I'm running the program at nice -18.
>>So, what kind of things can I do to decrease the latency?
>>
>
>Hack up the ksoftirq stuff to only fall back to ksoftirqd after about
>500 iterations instead of one is one little detail to deal with
>
>>Would the low-latency patch help me?
>>
>
>Yes
>
It might be very difficult to fix up the
low latency patch for the latest -ac,
but the mini-low-latency patch should
go right in - that should fix the worst
of it, and I've run 2.4.19-pre2-ac1 with
the mini low-latency patch.

It's part of the -aa patch collection, just
look for "00_lowlatency-fixes-4" or so.

Joe



