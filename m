Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280367AbRJaRwc>; Wed, 31 Oct 2001 12:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280365AbRJaRwP>; Wed, 31 Oct 2001 12:52:15 -0500
Received: from mailrelay3.inwind.it ([212.141.54.103]:9121 "EHLO
	mailrelay3.inwind.it") by vger.kernel.org with ESMTP
	id <S280364AbRJaRwC>; Wed, 31 Oct 2001 12:52:02 -0500
Message-Id: <3.0.6.32.20011031185523.01fc2d30@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Wed, 31 Oct 2001 18:55:23 +0100
To: Jeff Garzik <jgarzik@mandrakesoft.com>
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Re: VM: qsbench
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BDFED26.4350646B@mandrakesoft.com>
In-Reply-To: <3.0.6.32.20011031131253.01fb8e40@pop.tiscalinet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07.23 31/10/01 -0500, Jeff Garzik wrote:
>Lorenzo Allegrucci wrote:
>> Linux-2.4.14-pre6:
>> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
>> Out of Memory: Killed process 224 (qsbench).
>> 69.890u 3.430s 2:12.48 55.3%    0+0k 0+0io 16374pf+0w
>> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
>> Out of Memory: Killed process 226 (qsbench).
>> 69.550u 2.990s 2:11.31 55.2%    0+0k 0+0io 15374pf+0w
>> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
>> Out of Memory: Killed process 228 (qsbench).
>> 69.480u 3.100s 2:13.33 54.4%    0+0k 0+0io 15950pf+0w
>> 0:01 kswapd
>> 
>> This is interesting, -pre6 killed qsbench _just_ before qsbench exited.
>> Unreliable results.
>
>Can you give us some idea of the memory usage of this application?  Your
>amount of RAM and swap?

256M of RAM + 200M of swap, qsbench allocates about 343M.


-- 
Lorenzo
