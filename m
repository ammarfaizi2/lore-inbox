Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267667AbUBTHLr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 02:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267703AbUBTHLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 02:11:47 -0500
Received: from gate.crashing.org ([63.228.1.57]:53929 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267667AbUBTHLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 02:11:44 -0500
Subject: Re: [BK PATCH] USB update for 2.6.3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040220070012.GA8121@kroah.com>
References: <20040220012802.GA16523@kroah.com>
	 <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
	 <1077256996.20789.1091.camel@gaston>
	 <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org>
	 <1077258504.20781.1121.camel@gaston>
	 <Pine.LNX.4.58.0402192243170.14296@ppc970.osdl.org>
	 <1077259375.20787.1141.camel@gaston>  <20040220070012.GA8121@kroah.com>
Content-Type: text/plain
Message-Id: <1077260814.20789.1171.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 18:06:55 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As for the bigger "generic" dma mapping discussions for devices, hasn't
> this been hashed out a bunch already?  For some reason I thought
> everyone was happy for now with the way things work, and for 2.7 it was
> going to be expanded a bit to help support non-pci based busses (much
> like the ARM people just did.)
> 
> Hm, I wonder if I can convince anyone that I have to have a PPC64 box
> now to make sure I don't break the build anytime in the future :)

Hehe :) Well... you know who you for for ;)

Regarding the DMA mapping thing, I was (incorrectly) suspecting
you were passing the struct device of individual USB devices
(I haven't actually read the patch, argh ....)

Chasing a miscompile of the kernel with recent GCCs is melting
my brain down, sorry.

Ben.


