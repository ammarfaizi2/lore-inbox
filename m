Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbRE1UZT>; Mon, 28 May 2001 16:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263139AbRE1UZJ>; Mon, 28 May 2001 16:25:09 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:12296 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263138AbRE1UYw>; Mon, 28 May 2001 16:24:52 -0400
Date: Mon, 28 May 2001 15:48:28 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 4GB I/O, 2nd edition
In-Reply-To: <20010528175940.M9102@suse.de>
Message-ID: <Pine.LNX.4.21.0105281546010.1261-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 May 2001, Jens Axboe wrote:

> Hi,
> 
> One minor bug found that would possibly oops if the SCSI pool ran out of
> memory for the sg table and had to revert to a single segment request.
> This should never happen, as the pool is sized after number of devices
> and queue depth -- but it needed fixing anyway.
> 
> Other changes:
> 
> - Support cpqarray and cciss (two separate patches)
> 
> - Cleanup IDE DMA on/off wrt highmem
> 
> - Move run_task_queue back again in __wait_on_buffer. Need to look at
>   why this hurts performance.

It decrease performance of what in which way ?

Thanks 

