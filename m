Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274763AbRIUF4V>; Fri, 21 Sep 2001 01:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274766AbRIUF4L>; Fri, 21 Sep 2001 01:56:11 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:6917 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S274763AbRIUF4D>; Fri, 21 Sep 2001 01:56:03 -0400
Date: Fri, 21 Sep 2001 07:56:15 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [patch] block highmem zero bounce v14
Message-ID: <20010921075615.A586@suse.de>
In-Reply-To: <20010916234307.A12270@suse.de> <Pine.LNX.4.33.0109161447390.29507-100000@penguin.transmeta.com> <20010920.164301.76328081.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010920.164301.76328081.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20 2001, David S. Miller wrote:
>    From: Linus Torvalds <torvalds@transmeta.com>
>    Date: Sun, 16 Sep 2001 14:48:32 -0700 (PDT)
>    
>    Jens, what's your feeling about the stability of these things, especially
>    wrt weird drivers?
>    
>    Ie do you think this is really a 2.4.x thing, or early 2.5.x?
> 
> On my side of this work I feel that the 64-bit PCI dma infrastructure
> by itself is a safe merge in 2.4.11 or something like that.

I agree, and seriously hope that Linus will merge the pci64 patch in the
first 2.4.11-pre's. Then we can start looking at the block highmem
patch.

-- 
Jens Axboe

