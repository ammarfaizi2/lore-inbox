Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135608AbRD1T0R>; Sat, 28 Apr 2001 15:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135610AbRD1T0G>; Sat, 28 Apr 2001 15:26:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33803 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135608AbRD1TZy>;
	Sat, 28 Apr 2001 15:25:54 -0400
Date: Sat, 28 Apr 2001 21:10:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Jonathan Hudson <jonathan@daria.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.[234] kernel panic, DMA Pool, CDROM Mount Failure
Message-ID: <20010428211047.E11698@suse.de>
In-Reply-To: <Pine.LNX.4.21.0104281935560.687-100000@rfhome.fietze.de> <Pine.LNX.4.21.0104281935560.687-100000@rfhome.fietze.de> <20010428195742.C11698@suse.de> <1e14.3aeb0dc8.44a42@trespassersw.daria.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e14.3aeb0dc8.44a42@trespassersw.daria.co.uk>; from jonathan@daria.co.uk on Sat, Apr 28, 2001 at 06:36:56PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28 2001, Jonathan Hudson wrote:
> In article <20010428195742.C11698@suse.de>,
> 	Jens Axboe <axboe@suse.de> writes:
> JA> On Sat, Apr 28 2001, Roman Fietze wrote:
> >> Hello,
> >> 
> >> I reported this before and the bug still exists in 2.4.4. The problem can
> >> be circumvented by using drivers/scsi/sr.c from kernel 2.4.[01]. This
> >> "fix" did not help just me, but somebody else I had contact with on the
> >> net.
> JA> 
> JA> Is the CDROM on the 1542?
> JA> 
> JA> And could you include full panic info, please?
> JA> 
> 
> In my case, with AHA 1542 (as reported here earlier), I get:
> 
> Apr 26 22:36:13 kanga kernel: sr: ran out of mem for scatter pad 
> Apr 26 22:36:13 kanga kernel: Kernel panic: scsi_free:Bad offset 
> 
> Hope this is of some help.

Yes this one is known, and I have a partial fix already. I was just
curious as to whether Roman's problems are related or not.

-- 
Jens Axboe

