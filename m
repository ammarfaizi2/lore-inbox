Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313605AbSDPFxW>; Tue, 16 Apr 2002 01:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313606AbSDPFxV>; Tue, 16 Apr 2002 01:53:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30212 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313605AbSDPFxV>;
	Tue, 16 Apr 2002 01:53:21 -0400
Date: Tue, 16 Apr 2002 07:53:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH]
Message-ID: <20020416055313.GD12608@suse.de>
In-Reply-To: <Pine.LNX.4.10.10204151119350.1699-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15 2002, Andre Hedrick wrote:
> 
> http://www.linuxdiskcert.org/ide-2.4.19-p6.all.convert.3.patch.bz2

seems that you haven't fixed the case where you cannot enable dma on an
atapi drive if CONFIG_IDEDMA_ONLYDISK has been selected? to me this is a
bug -- I don't want auto-enable of dma on my atapi drives, but I surely
want to be able to hdparm -d1 them at will later on.

-- 
Jens Axboe

