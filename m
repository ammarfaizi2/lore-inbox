Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbUBVPJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 10:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbUBVPJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 10:09:29 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:2178 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261465AbUBVPJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 10:09:26 -0500
Date: Sun, 22 Feb 2004 16:09:25 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org, Judith Lebzelter <judith@osdl.org>,
       Dan Kegel <dank@kegel.com>, cliff white <cliffw@osdl.org>
Subject: Re: Kernel Cross Compiling [update]
Message-ID: <20040222150924.GA23051@MAIL.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Judith Lebzelter <judith@osdl.org>, Dan Kegel <dank@kegel.com>,
	cliff white <cliffw@osdl.org>
References: <20040222035350.GB31813@MAIL.13thfloor.at> <20040222090711.A11210@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222090711.A11210@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 09:07:11AM +0000, Russell King wrote:
> On Sun, Feb 22, 2004 at 04:53:50AM +0100, Herbert Poetzl wrote:
> >    interesting is that some architectures (arm, chris, v850)
> >    do not even have an appropriate default config
> 
> For some (eg ARM) one single default config makes zero sense.  I've
> been debating about removing arch/arm/defconfig for this reason; we
> have a whole host of machine default configurations in arch/arm/config
> to serve this purpose.

ah, okay, so could you 'suggest' or even 'provide' a config
which is somewhat 'representative' for the arm kernel
architecture, so that (mostly) platform independant patches
could be tested on this arch?

> >    				   linux-2.4.25
> >    			   config  dep     kernel  modules
> > 
> >    alpha/alpha: 	   OK	   OK	   OK	   OK
> >    arm/arm:		   OK	   OK	   FAILED  FAILED
> 
> ARM is not expected to build in 2.4 kernels, and probably never will.

okay, so this is a dead end for 2.4, right?

TIA,
Herbert

> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
>                  2.6 Serial core
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
