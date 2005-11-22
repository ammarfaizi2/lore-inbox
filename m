Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbVKVCae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbVKVCae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 21:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbVKVCae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 21:30:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:25036 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964869AbVKVCad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 21:30:33 -0500
Subject: Re: [RFC] Small PCI core patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Airlie <airlied@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1132623268.20233.14.camel@localhost.localdomain>
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
	 <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	 <1132623268.20233.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 13:27:57 +1100
Message-Id: <1132626478.26560.104.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-22 at 01:34 +0000, Alan Cox wrote:
> On Maw, 2005-11-22 at 11:47 +1100, Dave Airlie wrote:
> > And funny enough unlike SCSI adapters and things for large server
> > installations, nobody seems to really care enough about graphics
> > cards, I've heard horror stories about how little Linux companies
> 
> Its easy to see why
> 
> The graphics market between Nvidia and ATI is extreme rivalry
> There have been some ugly patent lawsuits
> Good software tricks can make the weaker hardware win
> Its very hard to write

On the other hand, there is little justification not to open source at
least the kernel & basic mode setting part. It's all plumbing and mode
setting stuff, monitor detection, etc... it's not part of any of the big
added value or IP stuff that can be found in the 3D engine.

I've talked to them several times about that, trying to advocate really
only putting the GL -> engine command stream generation in a binary blob
(in userland where it belongs) and have everything else open sourced,
but they aren't interested. In many cases, the replies I get are along
the lines of "why would we do that ? nVidia doesn't" or "why could we
care", or "give us a business justification" (the later translates to:
prove us that by doing so, we'll sell that many more million cards,
which is obviously impossible) etc... They really doesn't give a shit
about what we think, and will continue to do so until they get a bit fat
lawsuite, that is my opinion at least.

Ben.


