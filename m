Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267688AbUBTHNh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 02:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267691AbUBTHNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 02:13:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:55209 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267688AbUBTHNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 02:13:34 -0500
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB update for 2.6.3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402192257190.1107@ppc970.osdl.org>
References: <20040220012802.GA16523@kroah.com>
	 <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
	 <1077256996.20789.1091.camel@gaston>
	 <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org>
	 <1077258504.20781.1121.camel@gaston>
	 <Pine.LNX.4.58.0402192243170.14296@ppc970.osdl.org>
	 <1077259375.20787.1141.camel@gaston>
	 <Pine.LNX.4.58.0402192257190.1107@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1077260925.20779.1176.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 18:08:46 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Basically, we only care about host devices, since anything else is going 
> to be talked to through a driver and is thus not even platform-dependent 
> any more. See what I'm saying? 

I see. Well... as long as the actual dma mapping calls are always
done at the host controller level, that's fine with me.

> .../...

> (And btw, yes, it all booted, so PPC64 is happy again. I pushed out the 
> one-liner fix).

BTW. Did you ever reproduce that lockup ?

Ben.


