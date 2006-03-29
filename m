Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWC2DyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWC2DyA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 22:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWC2DyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 22:54:00 -0500
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:23246 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750752AbWC2Dx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 22:53:59 -0500
Subject: Re: Need help reporting bug, no 3D accel with Matrox g400
From: Sergey Panov <sipan@sipan.org>
To: cyber rigger <cyber_rigger@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060328151328.53672.qmail@web31811.mail.mud.yahoo.com>
References: <20060328151328.53672.qmail@web31811.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: Home
Date: Tue, 28 Mar 2006 22:53:55 -0500
Message-Id: <1143604435.28440.4.camel@sipan.sipan.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you using dual-screen setup? Direct rendering is disabled when
Xinerama is enabled. In any case , look what your /var/log/Xorg.0.log 
is saying about rendering settings.

 Sergey

On Tue, 2006-03-28 at 07:13 -0800, cyber rigger wrote:
> I need help reporting a bug.
> 
> 
> It appears that some later kernel versions
> do not support 3D acceleration in some cases.
> I'm getting this problem with Debain etch and Ubuntu
> Dapper. I first thought it was a problem caused by
> switching to xorg but Ubuntu 5.10 is fine and it uses
> xorg. 
> 
> ----------------------------------------------------
> The 3D acceleration doesn't work with xorg using the
> mga driver for a Matrox g400.
> My test case is ppracer which runs dreadfully slow.
> 
> This is a Debian etch machine with Debian's 
> 2.6.15-1-k7 kernel.
> 
> 
> This is what I have found so far.
> 
> Re: No direct rendering with recent kernels
> http://lists.debian.org/debian-x/2006/01/msg00133.html[mga]
> 
> 
> DRM for MGA broken since 2005-Aug-04.
> https://bugs.freedesktop.org/show_bug.cgi?id=4797
> 
> 
> 
> The 3D acceleration for mga appears to still be
> broken.
> 
> Where and how may I respectfully plead for this to be
> fixed?
> 
> :^)
> 
> 
> Thanks
> 
> 
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

