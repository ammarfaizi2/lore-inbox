Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266353AbUHTLVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266353AbUHTLVz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 07:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266449AbUHTLVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 07:21:55 -0400
Received: from amalthea.dnx.de ([193.108.181.146]:32397 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S266353AbUHTLVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 07:21:53 -0400
Date: Fri, 20 Aug 2004 13:21:46 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DTrace-like analysis possible with future Linux kernels?
Message-ID: <20040820112146.GK29410@pengutronix.de>
References: <200408191822.48297.miles.lane@comcast.net> <87hdqyogp4.fsf@killer.ninja.frodoid.org> <1092954824.28931.9.camel@localhost.localdomain> <1092996500.29012.88.camel@cambridge.braddahead.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1092996500.29012.88.camel@cambridge.braddahead.com>
User-Agent: Mutt/1.4i
X-Scan-Signature: 5f06452935e2f83c8f27be9c3ae2dd7b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 11:08:21AM +0100, Alex Bennee wrote:
> Well profiling for user space developers. Certainly for embedded "soft
> realtime" work I've found LTT really useful in understanding where the
> contentions where in my user-space code. And also why the old pthread
> mutex didn't work well with SCHED_RT priorities :-(
> 
> If it was my choice I'd like to see LTT merged, but of course its not
> all about me much as I wish it was ;-)

Same here - LTT turned out to be a useful tool for debugging performance
issues in several USB gadget drivers. Sure, it would have been possible
to instrument the boxes with the scope and trace things in hardware, but
with LTT it was much easier to handle. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
