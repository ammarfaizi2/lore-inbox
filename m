Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132831AbRDPBxf>; Sun, 15 Apr 2001 21:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132830AbRDPBxZ>; Sun, 15 Apr 2001 21:53:25 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:9880 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S132826AbRDPBxJ>; Sun, 15 Apr 2001 21:53:09 -0400
Date: Sun, 15 Apr 2001 21:53:09 -0400 (EDT)
From: Scott Murray <scott@spiteful.org>
X-X-Sender: <scottm@godzilla.spiteful.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Can't free the ramdisk (initrd, pivot_root)
In-Reply-To: <9bdi3t$th3$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33.0104152146520.4284-100000@godzilla.spiteful.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Apr 2001, H. Peter Anvin wrote:

> Followup to:  <3ADA0B50.8030301@muppetlabs.com>
> By author:    Amit D Chaudhary <amit@muppetlabs.com>
> In newsgroup: linux.dev.kernel
> >
> > On the same topic, I have not found any change in free memory
> > reported before and after the ioctl call. Though umount /initrd does
> > free around 2 MB.
> >
>
> With Scott's patch applied, I get substantially better performance on
> low-memory machines, so I'm guessing it's doing its job.  Also, just
> umount /initrd for me made it still possible to mount it, so it
> clearly did not go away.

I can't take credit for the patch, just the (mis)fortune of having to
track down its existence. :)  All mentions of it in Alan's older change
logs have it uncredited, so I'm unsure if he or someone else fixed it.

Scott


-- 
=============================================================================
Scott Murray                                        email: scott@spiteful.org
http://www.spiteful.org (coming soon)                 ICQ: 10602428
-----------------------------------------------------------------------------
     "Good, bad ... I'm the guy with the gun." - Ash, "Army of Darkness"

