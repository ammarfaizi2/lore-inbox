Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136384AbREIMtn>; Wed, 9 May 2001 08:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136381AbREIMta>; Wed, 9 May 2001 08:49:30 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:25248 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S136384AbREIMsy>;
	Wed, 9 May 2001 08:48:54 -0400
Message-ID: <3AF93CA2.F2E8C5DB@mandrakesoft.com>
Date: Wed, 09 May 2001 08:48:34 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Jens Axboe <axboe@suse.de>
Subject: Re: blkdev in pagecache
In-Reply-To: <20010509043456.A2506@athlon.random> <3AF90A3D.7DD7A605@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> > - I force the virtual blocksize for all the blkdev I/O
> >   (buffered and direct) to work with a 4096 bytes granularity instead of
> 
> You mean PAGE_SIZE :-).

Or maybe PAGE_CACHE_SIZE?

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
