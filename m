Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278417AbRJSN7z>; Fri, 19 Oct 2001 09:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278418AbRJSN7f>; Fri, 19 Oct 2001 09:59:35 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:30220 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S278417AbRJSN71>; Fri, 19 Oct 2001 09:59:27 -0400
Date: Fri, 19 Oct 2001 15:59:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] block highmem zero-bounce #17
Message-ID: <20011019155942.C7221@suse.de>
In-Reply-To: <20011018144047.E4825@suse.de> <jen12n4w1v.fsf@sykes.suse.de> <20011019151023.D5509@suse.de> <jed73j4tqo.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jed73j4tqo.fsf@sykes.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19 2001, Andreas Schwab wrote:
> |> On Fri, Oct 19 2001, Andreas Schwab wrote:
> |> > Jens Axboe <axboe@suse.de> writes:
> |> > 
> |> > |> Patch is considered solid. Find it here:
> |> > |> 
> |> > |> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.13-pre4/block-highmem-all-17.bz2
> |> > 
> |> > Your patch still makes bad use of struct scatterlist which is architecture
> |> > dependent.  Either fix the definitions in asm-*/scatterlist.h or go back
> |> > using a private struct.  Why did you switch to struct scatterlist in the
> |> > first place??
> |> 
> |> What are you talking about? Please expand. struct scatterlist has very
> |> intentionally been changed to its current look, and if an arch is not
> |> uptodate please let me know.
> 
> Currently ia64 does not build due to this.

Then the IA64 folks need to catch up. There's nothing new in this, this
is how stuff usually happens. In short, I don't see the problem.

-- 
Jens Axboe

