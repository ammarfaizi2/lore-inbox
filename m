Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267839AbUG3VAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267839AbUG3VAo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 17:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267838AbUG3VAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 17:00:44 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:26543 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267839AbUG3VAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 17:00:42 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Exposing ROM's though sysfs
Date: Fri, 30 Jul 2004 14:00:11 -0700
User-Agent: KMail/1.6.2
Cc: Martin Mares <mj@ucw.cz>, Jon Smirl <jonsmirl@yahoo.com>,
       Matthew Wilcox <willy@debian.org>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20040730201052.GA5249@ucw.cz> <200407301349.12020.jbarnes@engr.sgi.com> <20040730205436.GA5887@ucw.cz>
In-Reply-To: <20040730205436.GA5887@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301400.11391.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 30, 2004 1:54 pm, Martin Mares wrote:
> > I don't think anyone wants an x86 emulator builtin to the kernel for this
> > purpose.
>
> Well, most people probably do not want a x86 emulator running random ROMs
> in the userspace, either :-)  But unfortunately the world is ugly (at least
> these parts of it).

Yep. :(

> However, point taken.  (Although it will not be easy, since you have to
> avoid kernel drivers touching the device until you can run the ROM in
> userspace.)

Yeah, it's a pain.

> > We can get away without caching a copy of the ROM in the kernel if we
> > require userspace to cache it before the driver takes control of the card
> > (i.e. at POST time).  Otherwise, the kernel will have to take care of it.
>
> In case of the video cards, it is probably the right path to go.

Great, glad we agree!

Thanks,
Jesse
