Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVABWPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVABWPn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 17:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVABWPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 17:15:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6918 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261153AbVABWPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 17:15:36 -0500
Date: Sun, 2 Jan 2005 23:15:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: William Lee Irwin III <wli@debian.org>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050102221534.GG4183@stusta.de>
References: <1697129508.20050102210332@dns.toxicfilms.tv> <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl> <20050102214211.GM29332@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102214211.GM29332@holomorphy.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 01:42:11PM -0800, William Lee Irwin III wrote:
> 
> This is not optimism. This is experience. Every ``stable'' kernel I've
> seen is a pile of incredibly stale code where vi'ing any file in it
> instantly reveals numerous months or years old bugs fixed upstream.
> What is gained in terms of reducing the risk of regressions is more
> than lost by the loss of critical examination and by a long longshot.

The main advantage with stable kernels in the good old days (tm) when 4 
and 6 were even numbers was that you knew if something didn't work, and 
upgrading to a new kernel inside this stable kernel series had a 
relatively low risk of new breakages. This meant one big migration every 
few years and relatively easy upgrades between stable series kernels.

Nowadays in 2.6, every new 2.6 kernel has several regressions compared 
to the previous one, and additionally obsolete but used code like 
ipchains and devfs is scheduled for removal making upgrades even harder 
for many users.

There's the point that most users should use distribution kernels, but 
consider e.g. that there are poor souls with new hardware not supported 
by the 3 years old 2.4.18 kernel in the stable part of your Debian 
distribution.

> -- wli

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

