Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTENXk6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 19:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263180AbTENXk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 19:40:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59527 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263176AbTENXk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 19:40:57 -0400
Message-ID: <3EC2D6FB.5050700@pobox.com>
Date: Wed, 14 May 2003 19:53:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       David Gibson <hermes@gibson.dropbear.id.au>,
       Benjamin Reed <breed@almaden.ibm.com>,
       Javier Achirica <achirica@ttd.net>, Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: airo and firmware upload (was Re: 2.6 must-fix list, v3)
References: <20030514211222.GA10453@bougret.hpl.hp.com> <3EC2BDEC.6020401@pobox.com> <20030514233235.GA11581@bougret.hpl.hp.com> <20030514234359.GB9898@suse.de>
In-Reply-To: <20030514234359.GB9898@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
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


Correct.

_I_ didn't refuse the crypto, Linus did.  But that was a positive step, 
that kicked off inclusion of crypto into the kernel.

airo and HostAP do indeed need to use CryptoAPI not reimplement their 
own crypto, though...

	Jeff



