Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBUVYU>; Wed, 21 Feb 2001 16:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129539AbRBUVYK>; Wed, 21 Feb 2001 16:24:10 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:33549 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129181AbRBUVYG>;
	Wed, 21 Feb 2001 16:24:06 -0500
Date: Wed, 21 Feb 2001 22:23:58 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] VIA 4.2x driver for 2.2 kernels
Message-ID: <20010221222358.A1665@suse.cz>
In-Reply-To: <20010220134028.A5762@suse.cz> <20010220155927.A1543@cm.nu> <20010221080919.A469@suse.cz> <20010220231502.A4618@cm.nu> <20010221082348.A908@suse.cz> <20010221110533.B3374@iname.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010221110533.B3374@iname.com>; from rbrito@iname.com on Wed, Feb 21, 2001 at 11:05:33AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2001 at 11:05:33AM -0300, Rogerio Brito wrote:
> On Feb 21 2001, Vojtech Pavlik wrote:
> > On Tue, Feb 20, 2001 at 11:15:02PM -0800, Shane Wegner wrote:
> > > Ok, can I still use -u1 -k1 -c1 on the drives or is it even
> > > necessary anymore.
> > 
> > If you enable automatic DMA in the kernel config, it isn't necessary
> > at all. The VIA driver sets up everything.
> 
> 	Ok. Please disregard my last message (this one contains
> 	exactly what I was looking for).
> 
> > 4) But VIA is still set to PIO mode
> 
> 	Why does this happen?
> 
> 	And what about the other options to hdparm (-u1 -k1 -c1)? Are
> 	they potentially dangerous also?

Well, I checked today and my fears were *not* confirmed. Actually the
VIA driver will set up the chipset for UDMA even when UDMA won't be
later used, so it's all OK.

-- 
Vojtech Pavlik
SuSE Labs
