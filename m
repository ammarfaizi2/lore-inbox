Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSEVJgK>; Wed, 22 May 2002 05:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316901AbSEVJgJ>; Wed, 22 May 2002 05:36:09 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:4881 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315485AbSEVJgI>; Wed, 22 May 2002 05:36:08 -0400
Date: Wed, 22 May 2002 10:36:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SLC82C105 IDE driver: missing __init
Message-ID: <20020522103602.A15750@flint.arm.linux.org.uk>
In-Reply-To: <20020522091648.GB312@pazke.ipt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 01:16:48PM +0400, Andrey Panin wrote:
> slc82c105_bridge_revision() functions lacks __init modifier.
> Attached patch (against 2.5.17) fixes it.
> Compiles, but untested. Please consider applying.

I'm surprised it compiles.  I've got a rather major update to it here,
but I need to find time to pull it out of the ARM patch, and I need IDE
to settle down a bit so the two are actually in sync with each other.
(Martin messed up my DMA changes which'd prevent sl82c105 linking - I'm
waiting for the fix to emerge, which I think is in 2.5.17, but the TLB
stuff in 2.5.17 has broken all my ARM builds, so I'm unable to build or
test anything on 2.5 currently.)

Too many things to do... too many problems to solve... too many patches
to look at... too much email... not enough hours in the day... not enough
fast machines to build kernels on... not enough rmk clones to run kernel
tests... 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

