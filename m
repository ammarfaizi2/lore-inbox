Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274803AbRJQHEY>; Wed, 17 Oct 2001 03:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274806AbRJQHEN>; Wed, 17 Oct 2001 03:04:13 -0400
Received: from fe100.worldonline.dk ([212.54.64.211]:32267 "HELO
	fe100.worldonline.dk") by vger.kernel.org with SMTP
	id <S274803AbRJQHDx>; Wed, 17 Oct 2001 03:03:53 -0400
Date: Wed, 17 Oct 2001 09:04:08 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: cary_dickens2@hp.com, linux-kernel@vger.kernel.org, erik_habbinga@hp.com
Subject: Re: Problem with 2.4.14prex and qlogicfc
Message-ID: <20011017090408.F3035@suse.de>
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D570@xfc01.fc.hp.com> <20011017081837.C3035@suse.de> <20011016.233534.48799017.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011016.233534.48799017.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16 2001, David S. Miller wrote:
>    From: Jens Axboe <axboe@suse.de>
>    Date: Wed, 17 Oct 2001 08:18:37 +0200
> 
>    On Tue, Oct 16 2001, DICKENS,CARY (HP-Loveland,ex2) wrote:
>    > I'm seeing a problem on all the kernels that are 2.4.13pre1 and up.
> 
>    This smells like a bug in the pci64 conversion of qlogicfc. Maybe davem
>    has an idea, I'll take a look too.
>    
> Not if it broke in pre1 since the pci64 stuff went into pre2 :-)

Ah yes, maybe this is my off-by-one or Cary's :-)

He also writes that it broke with 2.4.10 + block-highmem which has the
same PCI changes, so that's why I jumped to that conclusion. Cary, can
you verify that 2.4.13-pre1 _doesn't_ work and that 2.4.12 does?

-- 
Jens Axboe

