Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263488AbRFSDCU>; Mon, 18 Jun 2001 23:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263487AbRFSDCK>; Mon, 18 Jun 2001 23:02:10 -0400
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:1409 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S263443AbRFSDBw>;
	Mon, 18 Jun 2001 23:01:52 -0400
Date: Tue, 19 Jun 2001 05:00:37 +0200
From: Stefan Traby <stefan@hello-penguin.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
        tytso@thunk.org
Subject: Re: 2.4.5 data corruption
Message-ID: <20010619050037.B2512@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <200106122017.f5CKHnf24565@work.bitmover.com> <E15Abiw-00056O-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E15Abiw-00056O-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jun 14, 2001 at 07:20:06PM +0100
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.5-fijiji2-aescrypto (i686)
X-APM: 100% -1 min
X-PGP: Key fingerprint = C090 8941 DAD8 4B09 77B1  E284 7873 9310 3BDB EA79 
X-MIL: A-6172171143
X-Lotto: Suggested Lotto numbers (Austrian 6 out of 45): 6 13 26 33 34 40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2001 at 07:20:06PM +0100, Alan Cox wrote:
> > Folks, I believe I have a reproducible test case which corrupts data in
> > 2.4.5.
> 
> 2.4.5 has an out of date 3ware driver that is short

> +   1.02.00.007 - Fix possible null pointer dereferences in tw_ioctl().
> +                 Remove check for invalid done function pointer from
> +                 tw_scsi_queue().

hehe, this one keeps the 3dmd from running here at all.

> That might be a first thing to check

Well, I do not understand how the driver is distributed.
The actual 3ware stuff won't compile on 2.4.x, and the stuff in kernel
is always different from 3ware releases.

I use two 8-port cards (8 disks each) and I see different but
fatal problems on both systems.

Is anyone here using an actual firmware and raid-5 ?
Does it work up to some level on 6800 ?

Anyway, a useful proc-interface would be really cool
(like DAC); I guess that many people would love to get rid
of the - sorry - fucking closed sourced and totally broken 3dmd
which makes an extremly nice product totally useless (you can't
trust it; not only because it's closed source, it simply doesn't
work (except that it wastes memory, that works fine. tested.))

-- 

  ciao - 
    Stefan

" destroy-your-data-by-3dmd-no-need-for-hammer-anymore CNAME www.3ware.com. "
