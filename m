Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUIDPgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUIDPgr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 11:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUIDPgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 11:36:47 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:8247 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261426AbUIDPgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 11:36:45 -0400
Message-ID: <9e47339104090408362a356799@mail.gmail.com>
Date: Sat, 4 Sep 2004 11:36:39 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Keith Whitwell <keith@tungstengraphics.com>
Subject: Re: New proposed DRM interface design
Cc: Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       mharris@redhat.com
In-Reply-To: <4139C8A3.6010603@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040904102914.B13149@infradead.org>
	 <413997A7.9060406@tungstengraphics.com>
	 <20040904112535.A13750@infradead.org>
	 <4139995E.5030505@tungstengraphics.com>
	 <20040904112930.GB2785@redhat.com>
	 <4139A9F4.4040702@tungstengraphics.com>
	 <20040904115442.GD2785@redhat.com>
	 <4139B03A.6040706@tungstengraphics.com>
	 <20040904122057.GC26419@redhat.com>
	 <4139C8A3.6010603@tungstengraphics.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Sep 2004 14:52:35 +0100, Keith Whitwell
<keith@tungstengraphics.com> wrote:
> Currently we have to perform two merges and three releases to get a driver to
> a users:
> 
>         Merge DRM CVS --> LK
>         Release stable kernel  --> Picked up by vendor
>         Release stable Mesa 3D
>         Merge Mesa 3D --> X.org
>         Release stable X.org  --> Picked up by vendor
> 

X on GL will make this process faster

         Merge DRM CVS --> LK
         Release stable kernel  --> Picked up by vendor
         Release stable Mesa 3D --> Picked up by vendor
         Release stable X.org  --> Picked up by vendor

If DRM went into a kernel development model....

         Release stable kernel  --> Picked up by vendor
         Release stable Mesa 3D --> Picked up by vendor
         Release stable X.org  --> Picked up by vendor

This is the fastest model. Merges have been eliminated.

You may think that X on GL (gnuLonghorn) is a crazy idea. But
comptetive pressures from the Mac and Longhhorn will force us into
doing it so or later. I'd rather do it sooner.
