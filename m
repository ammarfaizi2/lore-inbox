Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbTEOAm3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 20:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263286AbTEOAm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 20:42:29 -0400
Received: from palrel12.hp.com ([156.153.255.237]:12503 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263280AbTEOAm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 20:42:27 -0400
Date: Wed, 14 May 2003 17:55:08 -0700
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: airo and firmware upload (was Re: 2.6 must-fix list, v3)
Message-ID: <20030515005508.GA12037@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030514211222.GA10453@bougret.hpl.hp.com> <3EC2BDEC.6020401@pobox.com> <20030514233235.GA11581@bougret.hpl.hp.com> <20030514234359.GB9898@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514234359.GB9898@suse.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 12:43:59AM +0100, Dave Jones wrote:
> On Wed, May 14, 2003 at 04:32:35PM -0700, Jean Tourrilhes wrote:
> 
>  > 	While we are on the subject : a few months ago, Javier added
>  > support for MIC to the airo driver. It's basically crypto based on
>  > AES. You refused to include that part in the kernel because crypto was
>  > not accepted in the kernel.
>  > 	Fast forward : today we have crypto in the 2.5.X kernel. Does
>  > this mean that you would have no objection accepting a patch from
>  > Javier including the crypto part ?
> 
> Sounds like it would be better to get it using the in-kernel crypto
> stuff rather than reimplementing its own routines. Same for the HostAP
> driver.
>  
> 		Dave

	For HostAP, the kernel crypto doesn't include any RC4 support,
so it can't use kernel crypto as it is.
	For airo, crypto was added before kernel crypto was available
in the kernel, and I don't know how easy it will be to refactor the
code.
	I just wanted to know the position of Jeff on this issue. I'll
let the technical decision to the respective authors.

	Thanks...

	Jean
