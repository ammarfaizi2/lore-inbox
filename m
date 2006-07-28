Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161318AbWG1VsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161318AbWG1VsX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 17:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161319AbWG1VsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 17:48:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9405 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161318AbWG1VsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 17:48:22 -0400
Date: Sat, 29 Jul 2006 07:48:03 +1000
From: Nathan Scott <nathans@sgi.com>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: XFS breakage in 2.6.18-rc1
Message-ID: <20060729074803.A2222647@wobbly.melbourne.sgi.com>
References: <20060718222941.GA3801@stargate.galaxy> <20060719085731.C1935136@wobbly.melbourne.sgi.com> <Pine.LNX.4.64.0607221722500.8407@prinz64.housecafe.de> <20060724090138.C2083275@wobbly.melbourne.sgi.com> <Pine.LNX.4.64.0607281526220.1882@sheep.housecafe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.64.0607281526220.1882@sheep.housecafe.de>; from evil@g-house.de on Fri, Jul 28, 2006 at 05:01:24PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 05:01:24PM +0000, Christian Kujau wrote:
> I had two xfs filesystems and I first noticed that /data/Scratch was 
> befallen from this bug. I did not care much about this (hence the
> name :)) and I wanted to postpone the xfs_db surgery.
> ...
> found more and more errors. I decided to mkfs the partition and make use 
> of my backups. my other "scratch" partition is still XFS but mounted ro 
> and I'll try the xfsprogs fixes Nathan published on this one.

Barry sent an xfs_repair patch to resolve this issue to the xfs@oss.sgi.com
list yesterday; please give that a go and let us know how it fares.

cheers.

-- 
Nathan
