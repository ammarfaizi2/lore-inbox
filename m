Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbVKVSlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbVKVSlu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbVKVSlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:41:50 -0500
Received: from havoc.gtf.org ([69.61.125.42]:6283 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965099AbVKVSlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:41:49 -0500
Date: Tue, 22 Nov 2005 13:41:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: today's graphics (was Re: [RFC] Small PCI core patch)
Message-ID: <20051122184143.GA6592@havoc.gtf.org>
References: <20051121225303.GA19212@kroah.com> <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston> <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com> <1132623268.20233.14.camel@localhost.localdomain> <1132626478.26560.104.camel@gaston> <1132669546.20233.49.camel@localhost.localdomain> <20051122142648.GB24997@havoc.gtf.org> <1132685924.20233.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132685924.20233.53.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 06:58:44PM +0000, Alan Cox wrote:
> On Maw, 2005-11-22 at 09:26 -0500, Jeff Garzik wrote:
> > I've proposed to Intel, and would like to talk to ATI/NVIDIA, about
> > seeing what can be done to standardize the REALLY DUMB components, like
> > the DMA interface to transfer code and data.
> 
> You put it in the processor eventually. 

It will take forever for Intel and AMD to get their acts together :(

AMD did well by putting the memory controller on the CPU, but Intel didn't.

Intel added "IOA/T" (async DMA memory copies), but AMD doesn't have that.

And ATI/NVIDIA stuff will likely remain across the PCI-Express bus for
quite a while.

My preference is to have ATI/NVIDIA use the same PCI-Express interface,
and differentiate in the GPU.

	Jeff



