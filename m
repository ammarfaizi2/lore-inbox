Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSHFX5R>; Tue, 6 Aug 2002 19:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316569AbSHFX5R>; Tue, 6 Aug 2002 19:57:17 -0400
Received: from rj.SGI.COM ([192.82.208.96]:14293 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S316545AbSHFX5Q>;
	Tue, 6 Aug 2002 19:57:16 -0400
Date: Wed, 7 Aug 2002 09:58:29 +1000
From: Nathan Scott <nathans@sgi.com>
To: Richard Bonomo <bonomo@sal.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: backups/dumps/caches
Message-ID: <20020806235829.GF515@frodo>
References: <200208060032.g760WZP107993@maddog.sal.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208060032.g760WZP107993@maddog.sal.wisc.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 07:32:34PM -0500, Richard Bonomo wrote:
> 
> Hello!
> 
> I have been trying to come up to speed on
> the issue of dumping file systems from
> 2.4.x kernels using dumps.  I located 
> Linus' unequivocal words about the dangers
> of using dump.   I have a couple of questions:
> 
> 1. Do the same warnings apply to XFS and xfsdump?

xfsdump doesn't directly access the device, so the metadata
and data it sees is coherent with other filesystem activity;
so, no these warnings are not applicable to xfsdump.

cheers.

-- 
Nathan
