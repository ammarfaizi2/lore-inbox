Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268870AbUIAHlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268870AbUIAHlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 03:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268878AbUIAHlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 03:41:39 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:19944 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S268870AbUIAHli
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 03:41:38 -0400
Date: Wed, 1 Sep 2004 10:44:27 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040901074427.GG13749@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20040901072245.GF13749@mellanox.co.il> <20040901073218.GQ16297@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901073218.GQ16297@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Please do not mail me directly.

Quoting viro@parcelfarce.linux.theplanet.co.uk (viro@parcelfarce.linux.theplanet.co.uk) "Re: f_ops flag to speed up compatible ioctls in linux kernel":
> On Wed, Sep 01, 2004 at 10:22:45AM +0300, Michael S. Tsirkin wrote:
> >    2. there's a performance huge overhead for each compat call - there's
> >       a hash lookup in a global hash inside a lock_kernel -
> >       and I think compat performance *is* important.
> > 
> > Further, adding a command to the ioctl suddenly requires changing
> > two places - registration code and ioctl itself.
> 
> So don't add them.  Adding a new ioctl is *NOT* a step to be taken lightly -
> we used to be far too accepting in that area and as somebody who'd waded
> through the resulting dungpiles over the last months I can tell you that
> result is utterly revolting.

Why make it a bigger dungpile then?
And what about the performance overhead?

MST
