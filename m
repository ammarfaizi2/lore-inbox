Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267651AbUIDMVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267651AbUIDMVm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 08:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269886AbUIDMVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 08:21:42 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:19146 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267651AbUIDMVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 08:21:40 -0400
Date: Sat, 4 Sep 2004 13:20:58 +0100
From: Dave Jones <davej@redhat.com>
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, mharris@redhat.com
Subject: Re: New proposed DRM interface design
Message-ID: <20040904122057.GC26419@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
	dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	mharris@redhat.com
References: <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com> <4139A9F4.4040702@tungstengraphics.com> <20040904115442.GD2785@redhat.com> <4139B03A.6040706@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4139B03A.6040706@tungstengraphics.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 01:08:26PM +0100, Keith Whitwell wrote:

 > So, we are coming out of a period of history where it was extremely 
 > difficult to get our drivers to users through the 'official' channels - to 
 > the extent that many people have given up on the possibility of them 
 > working properly. Maybe things will improve now.
 > 
 > Are you suggesting for instance, that RedHat might pick up individual 
 > drivers out of Xorg or better still Mesa, rather than waiting for a full 
 > stable release?  That would probably be the biggest help - by comparison 
 > kernel releases are very frequent.

I don't speak for X packaging (which is why I Cc'd Mike), but Fedora
(Sorry Dave theres that word again) as a whole is tracking upstream
very aggressively in most of its packages.
(In the case of the kernel right now, we're tracking the daily -bk trees.
 Though due to the number of architectures we support, it obviously takes
 a while for it to all trickle out of our build system).
Cherry picking updates from upstream happens for some packages, but typically,
we'll just grab a new upstream as a whole as soon as it comes out.

Daves point was true that only FC3test currently supports i915, but as we
now use FC3test stabilisation points as update kernels for FC2 too, the
kernel bits end up going back periodically.
The Xorg side of the fence doesn't get as many updates.
(And FC1 will never get Xorg, its still XFree86 4.4 iirc)
One possible reason for this is sheer size of an X update, which annoys users.
Hopefully this will be fixed with the modularisation work thats somewhere
down the road.

		Dave

