Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTEOAts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 20:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTEOAts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 20:49:48 -0400
Received: from palrel13.hp.com ([156.153.255.238]:61341 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263275AbTEOAtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 20:49:45 -0400
Date: Wed, 14 May 2003 18:02:32 -0700
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: airo and firmware upload (was Re: 2.6 must-fix list, v3)
Message-ID: <20030515010231.GA12167@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030514211222.GA10453@bougret.hpl.hp.com> <3EC2BDEC.6020401@pobox.com> <20030514233235.GA11581@bougret.hpl.hp.com> <20030514234359.GB9898@suse.de> <3EC2D6FB.5050700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC2D6FB.5050700@pobox.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 07:53:31PM -0400, Jeff Garzik wrote:
> Dave Jones wrote:
> >On Wed, May 14, 2003 at 04:32:35PM -0700, Jean Tourrilhes wrote:
> >
> > > 	While we are on the subject : a few months ago, Javier added
> > > support for MIC to the airo driver. It's basically crypto based on
> > > AES. You refused to include that part in the kernel because crypto was
> > > not accepted in the kernel.
> > > 	Fast forward : today we have crypto in the 2.5.X kernel. Does
> > > this mean that you would have no objection accepting a patch from
> > > Javier including the crypto part ?
> >
> >Sounds like it would be better to get it using the in-kernel crypto
> >stuff rather than reimplementing its own routines. Same for the HostAP
> >driver.
> 
> 
> Correct.
> 
> _I_ didn't refuse the crypto, Linus did.  But that was a positive step, 
> that kicked off inclusion of crypto into the kernel.
> 
> airo and HostAP do indeed need to use CryptoAPI not reimplement their 
> own crypto, though...
> 
> 	Jeff

	Ok, this point is clarified as well. I'll communicate
downstream.
	Thanks.

	Jean
