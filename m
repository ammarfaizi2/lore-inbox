Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313621AbSDPGve>; Tue, 16 Apr 2002 02:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313622AbSDPGvd>; Tue, 16 Apr 2002 02:51:33 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:62725
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313621AbSDPGvd>; Tue, 16 Apr 2002 02:51:33 -0400
Date: Mon, 15 Apr 2002 23:51:03 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH]
In-Reply-To: <20020416055313.GD12608@suse.de>
Message-ID: <Pine.LNX.4.10.10204152349260.8091-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is 99% usage for distro to ship stable booting kernels given atapi is
flakey.  However if you have a suggestion I am accepting options

--andre

On Tue, 16 Apr 2002, Jens Axboe wrote:

> On Mon, Apr 15 2002, Andre Hedrick wrote:
> > 
> > http://www.linuxdiskcert.org/ide-2.4.19-p6.all.convert.3.patch.bz2
> 
> seems that you haven't fixed the case where you cannot enable dma on an
> atapi drive if CONFIG_IDEDMA_ONLYDISK has been selected? to me this is a
> bug -- I don't want auto-enable of dma on my atapi drives, but I surely
> want to be able to hdparm -d1 them at will later on.
> 
> -- 
> Jens Axboe
> 

