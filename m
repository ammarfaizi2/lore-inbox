Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266428AbUAOIvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 03:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266457AbUAOIvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 03:51:22 -0500
Received: from colin2.muc.de ([193.149.48.15]:23045 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266428AbUAOIvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 03:51:21 -0500
Date: 15 Jan 2004 09:52:17 +0100
Date: Thu, 15 Jan 2004 09:52:17 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: George Anzinger <george@mvista.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
Message-ID: <20040115085217.GA43298@colin2.muc.de>
References: <1coR2-42n-19@gated-at.bofh.it> <1d3r0-1tw-3@gated-at.bofh.it> <1dbI9-89t-7@gated-at.bofh.it> <1dEqx-F0-1@gated-at.bofh.it> <1dMRc-6DQ-3@gated-at.bofh.it> <1e2Mk-6YA-17@gated-at.bofh.it> <1e2Mo-6YA-31@gated-at.bofh.it> <1e3fi-4nG-5@gated-at.bofh.it> <m3ptdlwsf5.fsf@averell.firstfloor.org> <4006512A.7080002@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4006512A.7080002@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 12:36:58AM -0800, George Anzinger wrote:
> Now that is interesting.  As I read it, the debug port is programed the 
> same way in all the USB chips (given it exists at all).  AND it is much 

Yep, it's not PIO, but polled MMIO. Sorry for spreading misinformation.

> easier to use. Anyone care to put together a polling driver that makes it 
> look like RS232 on the host end given that we use a controller to 
> controller cable?

I suspect all laptop users with kernel bugs will admire whoever does that ;-)

-Andi

