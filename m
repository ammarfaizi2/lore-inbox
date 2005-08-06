Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVHFE4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVHFE4J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 00:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbVHFE4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 00:56:08 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:47631 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262076AbVHFE4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 00:56:07 -0400
Date: Sat, 6 Aug 2005 06:38:26 +0200
From: Willy Tarreau <willy@w.ods.org>
To: bdupree@techfinesse.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Build Issue for 2.4.31 on Alpha AXP Cabriolet Variant
Message-ID: <20050806043826.GB20363@alpha.home.local>
References: <32825.67.173.156.207.1123274299.squirrel@67.173.156.207>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32825.67.173.156.207.1123274299.squirrel@67.173.156.207>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 03:38:19PM -0500, bdupree@techfinesse.com wrote:
(...) 
> Anyhow, a simple one line fix to the arch/alpha/kernel/Makefile solves
> this problem (patch file is attached). I've also attached the config file
> I used for the build, as well as the boot messages from the kernel built
> after the patch was applied.

Thanks Bill for the patch, I'll merge it into hotfix 4 which I'll
probably release on next week (no urgent fix needed yet). My DS10
(21264) already builds and runs plain 2.4.31 fine, because it does
not use ns87312.

> And yes, I'm happily writing this email on my ancient Alpha box from
> within Mozilla, on a KDE 3.3 desktop, running atop that patched 2.4.31
> kernel. And while this old Alpha may not be the fastest 64-bit computer on
> the block, it's still usable!

Those boxes are wonderful. Mine serves as a gigabit fileserver at
only 466 MHz :-)

Thanks,
Willy

