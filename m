Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWC1XEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWC1XEq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWC1XEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:04:45 -0500
Received: from nproxy.gmail.com ([64.233.182.185]:16279 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964796AbWC1XEo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:04:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tzOJHxUPRZvMLz195PZm/c2BdDe2f7DPicrc62M98eQESoz4GVWECQXZ4Lbc1HmVTwjibckfMVH0ltDP0rwRNQbseyKZKgPYreeQY7/YwqzDasRuanahTsM70hT0d8ecBzQn2QgmutNFuz6jPNMYHMw1V2BMzsizs5Gbn82zVpE=
Message-ID: <21d7e9970603281504t68439c3ata05d02fef2169ba4@mail.gmail.com>
Date: Wed, 29 Mar 2006 10:04:43 +1100
From: "Dave Airlie" <airlied@gmail.com>
To: "cyber rigger" <cyber_rigger@yahoo.com>
Subject: Re: Need help reporting bug, no 3D accel with Matrox g400
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <21d7e9970603281456p1086ff0fh4490f90ef8f18fa3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060328151328.53672.qmail@web31811.mail.mud.yahoo.com>
	 <21d7e9970603281456p1086ff0fh4490f90ef8f18fa3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It appears that some later kernel versions
> > do not support 3D acceleration in some cases.
> > I'm getting this problem with Debain etch and Ubuntu
> > Dapper. I first thought it was a problem caused by
> > switching to xorg but Ubuntu 5.10 is fine and it uses
> > xorg.
> >
> > ----------------------------------------------------
> > The 3D acceleration doesn't work with xorg using the
> > mga driver for a Matrox g400.
> > My test case is ppracer which runs dreadfully slow.
> >
> > This is a Debian etch machine with Debian's
> > 2.6.15-1-k7 kernel.
> >
> >
> > This is what I have found so far.
> >
> > Re: No direct rendering with recent kernels
> > http://lists.debian.org/debian-x/2006/01/msg00133.html[mga]
> >

Does adding Option "OldDMAInit" "true"
in xorg.conf

fix the issue for you?

Dave.

> >
> > DRM for MGA broken since 2005-Aug-04.
> > https://bugs.freedesktop.org/show_bug.cgi?id=4797
> >
> >
> >
> > The 3D acceleration for mga appears to still be
> > broken.
> >
> > Where and how may I respectfully plead for this to be
> > fixed?
>
> Here, .. no pleading required.. I'm going to get my MGA out and setup
> again, however I was sure we'd fixed this before... there is a problem
> with the MGA userspace having broken locking,
>
> I'm nearly sure I've fixed up most of the kernel side, but I'll try
> and get time to test it again..
>
> Dave.
>
