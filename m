Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAIRsf>; Tue, 9 Jan 2001 12:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAIRsZ>; Tue, 9 Jan 2001 12:48:25 -0500
Received: from Cantor.suse.de ([194.112.123.193]:56842 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129784AbRAIRsN>;
	Tue, 9 Jan 2001 12:48:13 -0500
Date: Tue, 9 Jan 2001 18:47:55 +0100
From: Andi Kleen <ak@suse.de>
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: "'Andi Kleen'" <ak@suse.de>, Matti Aarnio <matti.aarnio@zmailer.org>,
        "'Pavel Machek'" <pavel@suse.cz>, adefacc@tin.it,
        linux-kernel@vger.kernel.org, timw@splhi.com
Subject: Re: Confirmation request about new 2.4.x. kernel limits
Message-ID: <20010109184755.A7377@gruyere.muc.suse.de>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E9513D@ATL_MS1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E9513D@ATL_MS1>; from Venkateshr@ami.com on Tue, Jan 09, 2001 at 12:35:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 12:35:02PM -0500, Venkatesh Ramamurthy wrote:
> 
> > Problem is that it needs a driver interface change and cooperation from
> > the
> > drivers. 
> 	[Venkatesh Ramamurthy]  Atleast the spec for this new interface,
> that the driver has to support be prepared? Once this is done we can port
> driver by driver to this new standard.

AFAIK there is no spec yet. Just supporting 64bit DMA on 32bit hosts would 
probably only minor changes (like pushing the dma_mask flag a bit more out so
that it is visible by scsi or ll_rw_blk), but 2.5 will probably also see more
extensive changes for block drivers, like moving them to kiovecs.  

Your input would be probably welcome.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
