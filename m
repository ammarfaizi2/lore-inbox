Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267333AbRGKPbI>; Wed, 11 Jul 2001 11:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267332AbRGKPa7>; Wed, 11 Jul 2001 11:30:59 -0400
Received: from [209.234.73.40] ([209.234.73.40]:20241 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S267331AbRGKPaq>;
	Wed, 11 Jul 2001 11:30:46 -0400
Date: Wed, 11 Jul 2001 10:29:58 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Johan Simon Seland <johans@netfonds.no>
Cc: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
Subject: Re: "Trying to free nonexistent swap-page" error message.
Message-ID: <20010711102958.V4148@altus.drgw.net>
In-Reply-To: <la8zibpur5.fsf@glass.netfonds.no> <200106290902.f5T924Qv014328@webber.adilger.int> <20010710142813.O4148@altus.drgw.net> <lawv5f3f7f.fsf@glass.netfonds.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <lawv5f3f7f.fsf@glass.netfonds.no>; from johans@netfonds.no on Wed, Jul 11, 2001 at 12:58:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 12:58:12PM +0200, Johan Simon Seland wrote:
> Troy Benjegerdes <hozer@drgw.net> writes:
> 
> > My first guess would be hardware also, except in this case I've seen
> > similiar things on three different dual processor G4 systems running 2.2,
> > and they work fine with 2.4.
> 
> I have replaced all the memory with fresh 4x512MB REGISTRED ECC RAM,
> and it has been running stable for 8 days now. I also replaced the
> SCSI cables. 2.4 is not an option.

If you have several identical machines running oracle, and the machine is 
stable after changing the RAM & scsi cables, my guess it was a RAM 
or cable problem. 

> > Does Oracle for Linux us pthreads or the 'clone()' system call?
> 
> I am not really sure. How do I find out?
> 
> > Can you try running the included pthreads program on an 2.2.19 SMP system
> > (but make it's idle, since if this is a genric 2.2 SMP bug it will
> > probably crash the system)
> 
> Sorry, I am not going to risk bringing down the database with your
> program. Its to critical for our business. (The database contains all
> stock quotes for Oslo, Stockholm, Frankfurt, NYSE, AMEX and NASDAQ
> stock exchanges and they are updated 24/7. I can only bring it down in
> weekends, and only if it really important.)
> 
> However I have access to a few other dual boxen. (2x550, 2x350, 2x166
> and a dual SparcStation 20). I can run your program on them with stock
> 2.2.19 SMP if you want me to.

I don't think it will show anything.. I've manged to find a dual PPro to 
run on and didn't see any problems. I think it's a PPC specific problem.

Thanks though.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
