Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273147AbRIPXNn>; Sun, 16 Sep 2001 19:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273210AbRIPXNY>; Sun, 16 Sep 2001 19:13:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:50958 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S273147AbRIPXNE>;
	Sun, 16 Sep 2001 19:13:04 -0400
Date: Mon, 17 Sep 2001 01:13:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, arjanv@redhat.com,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] block highmem zero bounce v14
Message-ID: <20010917011323.B12955@suse.de>
In-Reply-To: <20010917000012.B12270@suse.de> <E15il3t-00061s-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15il3t-00061s-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17 2001, Alan Cox wrote:
> > Most of it is really a cautious back port of the 2.5 stuff I've been
> > working on, and with the above considerations it is/was meant as a 2.4
> > thing :-)
> 
> So better deferred until 2.5, tried in 2.5 and backported to 2.4 IMHO

Maybe. At least the first thing I would like is for the pci64 patch to
be merged in 2.4. That should be very doable without risking breakage.
When that is done it's easier to see what the block-highmem patch does.
And I believe that we _can_ merge it in 2.4 without a 2.5 trial, it's
really not that intrusive.

-- 
Jens Axboe

