Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136521AbREIPAB>; Wed, 9 May 2001 11:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136523AbREIO7w>; Wed, 9 May 2001 10:59:52 -0400
Received: from mail.scs.ch ([212.254.229.5]:30738 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S136521AbREIO7d>;
	Wed, 9 May 2001 10:59:33 -0400
Message-ID: <3AF95C2A.1765681E@scs.ch>
Date: Wed, 09 May 2001 17:03:06 +0200
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Jens Axboe <axboe@suse.de>
Subject: Re: blkdev in pagecache
In-Reply-To: <20010509043456.A2506@athlon.random> <3AF90A3D.7DD7A605@evision-ventures.com> <3AF93CA2.F2E8C5DB@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik schrieb:
> 
> Martin Dalecki wrote:
> > > - I force the virtual blocksize for all the blkdev I/O
> > >   (buffered and direct) to work with a 4096 bytes granularity instead of
> >
> > You mean PAGE_SIZE :-).

Or maybe 8192 bytes on alphas ?!? ;-)
