Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313625AbSDPHFP>; Tue, 16 Apr 2002 03:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313626AbSDPHFO>; Tue, 16 Apr 2002 03:05:14 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:65029
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313625AbSDPHFN>; Tue, 16 Apr 2002 03:05:13 -0400
Date: Tue, 16 Apr 2002 00:04:49 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH]
In-Reply-To: <20020416065427.GK12608@suse.de>
Message-ID: <Pine.LNX.4.10.10204160000220.8091-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is not going anywhere for a while, until all the archs have
consistant local_*_*() spinlock but I noted what needs to be fixed and who
broke what.

I have another method but it was not reasonable or predictable until I
finish the driver conversion to fully modular and delete 95% of the
duplicated code mess I made over the years.

Your are free to copy it into 2.5 as always.

regards,

--andre

On Tue, 16 Apr 2002, Jens Axboe wrote:

> On Mon, Apr 15 2002, Andre Hedrick wrote:
> > 
> > It is 99% usage for distro to ship stable booting kernels given atapi is
> > flakey.  However if you have a suggestion I am accepting options
> 
> I agree with the option, just not the way it is implemented. If I want
> to enable dma after boot, I must be able to do so.
> 
> I have a solution, the current SuSE kernel gets it right. I'll backport
> that to 2.4.19-pre once this patch is in.
> 
> -- 
> Jens Axboe
> 

