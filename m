Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271832AbRIVQf3>; Sat, 22 Sep 2001 12:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271841AbRIVQfT>; Sat, 22 Sep 2001 12:35:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64527 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S271832AbRIVQfG>;
	Sat, 22 Sep 2001 12:35:06 -0400
Date: Sat, 22 Sep 2001 18:35:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjanv@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] block highmem zero bounce v14
Message-ID: <20010922183523.A6976@suse.de>
In-Reply-To: <20010922071839.A10727@devserv.devel.redhat.com> <E15kphr-0003dS-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15kphr-0003dS-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22i
X-OS: Linux 2.2.20 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22 2001, Alan Cox wrote:
> > Nope; without that it was still bust.
> > Megaraid broke (and 3ware most likely as well) because  it had broken code
> > for the "only 1 scatter gather element" case....
> 
> Yet more evidence that it belongs in 2.5 first. Auditing every scsi driver
> for that error (and I bet someone had it first and it was copied..) is
> a big job

Somehow I knew you would say that, Alan. 

jens

