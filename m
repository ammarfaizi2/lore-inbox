Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313624AbSDPGyp>; Tue, 16 Apr 2002 02:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313625AbSDPGyo>; Tue, 16 Apr 2002 02:54:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57350 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313624AbSDPGyn>;
	Tue, 16 Apr 2002 02:54:43 -0400
Date: Tue, 16 Apr 2002 08:54:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH]
Message-ID: <20020416065427.GK12608@suse.de>
In-Reply-To: <20020416055313.GD12608@suse.de> <Pine.LNX.4.10.10204152349260.8091-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15 2002, Andre Hedrick wrote:
> 
> It is 99% usage for distro to ship stable booting kernels given atapi is
> flakey.  However if you have a suggestion I am accepting options

I agree with the option, just not the way it is implemented. If I want
to enable dma after boot, I must be able to do so.

I have a solution, the current SuSE kernel gets it right. I'll backport
that to 2.4.19-pre once this patch is in.

-- 
Jens Axboe

