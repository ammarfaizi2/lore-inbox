Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266798AbUIEPdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUIEPdz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 11:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUIEPdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 11:33:55 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:40614 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266798AbUIEPdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 11:33:53 -0400
Message-ID: <9e473391040905083326707923@mail.gmail.com>
Date: Sun, 5 Sep 2004 11:33:53 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New proposed DRM interface design
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
In-Reply-To: <1094393713.1264.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040904102914.B13149@infradead.org>
	 <4139B03A.6040706@tungstengraphics.com>
	 <20040904122057.GC26419@redhat.com>
	 <4139C8A3.6010603@tungstengraphics.com>
	 <9e47339104090408362a356799@mail.gmail.com>
	 <4139FEB4.3080303@tungstengraphics.com>
	 <9e473391040904110354ba2593@mail.gmail.com>
	 <1094386050.1081.33.camel@localhost.localdomain>
	 <9e47339104090508052850b649@mail.gmail.com>
	 <1094393713.1264.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Sep 2004 15:15:25 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sul, 2004-09-05 at 16:05, Jon Smirl wrote:
> > > If DRI stays the way it is currently licensed no problems arise anyway
> > > (beyond proprietary people reusing DRI code, which given the license is
> > > presumably the intent)
> > >
> > If I copy GPL pieces of fbdev in to the DRM drivers it will pollute
> > the BSD license and turn it into GPL.
> 
> There is no reason to do that. The fb layer of Linux and BSD is very
> different and both provide fb drawing functionality.

Then how am I going to merge fbdev and DRM so that we don't have two
drivers fighting over the same hardware? I was planning on adding
pieces of the existing fbdev code to DRM in order to implement printk
from the kernel. It seems silly for me to rewrite 10,000 lines of code
just to make it BSD licensed when BSD isn't even going to use the
code.

What is wrong with marking each CVS commit with BSD/GPL license? Then
having the BSD people pick off the relevant code.



-- 
Jon Smirl
jonsmirl@gmail.com
