Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280184AbRJaMWq>; Wed, 31 Oct 2001 07:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280182AbRJaMWh>; Wed, 31 Oct 2001 07:22:37 -0500
Received: from mail004.mail.bellsouth.net ([205.152.58.24]:9678 "EHLO
	imf04bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280184AbRJaMW1>; Wed, 31 Oct 2001 07:22:27 -0500
Message-ID: <3BDFED26.4350646B@mandrakesoft.com>
Date: Wed, 31 Oct 2001 07:23:02 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lorenzo Allegrucci <lenstra@tiscalinet.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: VM: qsbench
In-Reply-To: <3.0.6.32.20011031131253.01fb8e40@pop.tiscalinet.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Allegrucci wrote:
> Linux-2.4.14-pre6:
> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
> Out of Memory: Killed process 224 (qsbench).
> 69.890u 3.430s 2:12.48 55.3%    0+0k 0+0io 16374pf+0w
> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
> Out of Memory: Killed process 226 (qsbench).
> 69.550u 2.990s 2:11.31 55.2%    0+0k 0+0io 15374pf+0w
> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
> Out of Memory: Killed process 228 (qsbench).
> 69.480u 3.100s 2:13.33 54.4%    0+0k 0+0io 15950pf+0w
> 0:01 kswapd
> 
> This is interesting, -pre6 killed qsbench _just_ before qsbench exited.
> Unreliable results.

Can you give us some idea of the memory usage of this application?  Your
amount of RAM and swap?

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

