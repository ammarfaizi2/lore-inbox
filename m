Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281363AbRKEVeN>; Mon, 5 Nov 2001 16:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281362AbRKEVeE>; Mon, 5 Nov 2001 16:34:04 -0500
Received: from postfix1-2.free.fr ([213.228.0.130]:31961 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S281360AbRKEVdr> convert rfc822-to-8bit; Mon, 5 Nov 2001 16:33:47 -0500
Date: Mon, 5 Nov 2001 19:48:44 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Re: SYM-2 patches against latest kernels available
In-Reply-To: <20011105082150.H2580@suse.de>
Message-ID: <20011105193609.S1943-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Nov 2001, Jens Axboe wrote:

> IA64 and Alpha is fine, the problem with the non-sg request is just
> 32-bit archs with highmem support. For that we need to pass in
> page/offset values instead of a virtual address.

So, all targetted platforms should be just fine. :)

I donnot like a lot highmem things, but I would want those ones to be fine
too with 64 bit DMA, at least in theory. Will try to understand the
related stuff from kernel 2.4.13.

Thanks a lot for the clarification.

  Gérard.


