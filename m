Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271150AbTHHCEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 22:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271155AbTHHCEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 22:04:09 -0400
Received: from mayhem.byteworld.com ([63.127.169.21]:10384 "EHLO
	chaos.byteworld.com") by vger.kernel.org with ESMTP id S271150AbTHHCEG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 22:04:06 -0400
Date: Thu, 7 Aug 2003 22:04:16 -0400
From: William Enck <wenck@wapu.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [bk patches] 2.6.x net driver updates
Message-ID: <20030808020416.GA20116@chaos.byteworld.com>
References: <20030808000508.GA4464@gtf.org> <20030808013649.GA20003@chaos.byteworld.com> <3F32FFAD.1050203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F32FFAD.1050203@pobox.com>
User-Agent: Mutt/1.3.28i
X-Sent-From: chaos.byteworld.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 09:41:01PM -0400, Jeff Garzik wrote:
> William Enck wrote:
> >On Thu, Aug 07, 2003 at 08:05:08PM -0400, Jeff Garzik wrote:
> >
> >>Linus, please do a
> >>
> >>	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.6
> >>
> >>Others may download the patch from
> >>
> >>ftp://ftp.??.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test2-bk7-netdrvr1.patch.bz2
> >>
> >>This will update the following files:
> >
> >..snip..
> >
> >>drivers/net/wireless/orinoco_cs.c   |   16 -
> >
> >
> >dmesg gave the folloing with 2.6.0-test2-bk7
> >
> >orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
> >orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
> >orinoco_cs: RequestIRQ: Unsupported mode
> >
> >I thought the above patch might fix it, so I patched and recompiled. I
> >still see the following in 2.6.0-test2-bk7-netdrvr1
> >
> >orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
> >orinoco_cs: RequestIRQ: Unsupported mode
> >
> >The module loaded and worked fine in -test2 and -test2-mm4. 
> 
> 
> Can you test -test2-bk7 (without my patch)?

The first set i was from -test2-bk7 and the second was from your patch.
Your patch didn't cause the problem. I replied to your email because you
had updates to orinoco_cs.c and I thought there was a chance your patch
was supposed to fix it. I guess a reply was not the best thing to do,
shall I start a new thread?

-- 
William Enck
wenck@wapu.org
