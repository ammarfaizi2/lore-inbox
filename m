Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271845AbRIVQ5L>; Sat, 22 Sep 2001 12:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271847AbRIVQ4u>; Sat, 22 Sep 2001 12:56:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28176 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S271845AbRIVQ4m>;
	Sat, 22 Sep 2001 12:56:42 -0400
Date: Sat, 22 Sep 2001 18:56:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjanv@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] block highmem zero bounce v14
Message-ID: <20010922185646.B7304@suse.de>
In-Reply-To: <20010922183523.A6976@suse.de> <E15kpqc-0003fI-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15kpqc-0003fI-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22i
X-OS: Linux 2.2.20 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22 2001, Alan Cox wrote:
> > > Yet more evidence that it belongs in 2.5 first. Auditing every scsi driver
> > > for that error (and I bet someone had it first and it was copied..) is
> > > a big job
> > 
> > Somehow I knew you would say that, Alan. 
> 
> I spent a lot of my time debugging driver code, and if its in one driver,
> its normally in ten. Look at the last serial driver fixup for example

That's true. However, as Arjan pointed out I can fix this up not to
rely on drivers working as-is for the new single entry sg behaviour.
This is already the case for regular block drivers.

Jens

