Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSFEKLs>; Wed, 5 Jun 2002 06:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314422AbSFEKLr>; Wed, 5 Jun 2002 06:11:47 -0400
Received: from ns.suse.de ([213.95.15.193]:17679 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S314325AbSFEKLq>;
	Wed, 5 Jun 2002 06:11:46 -0400
Date: Wed, 5 Jun 2002 12:11:45 +0200
From: Dave Jones <davej@suse.de>
To: Peter Rabbitson <rabbit@rabbit.online.bg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: amd k6-3 L3 cache
Message-ID: <20020605121145.E5277@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Peter Rabbitson <rabbit@rabbit.online.bg>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020605044616.GA3297@rabbit.online.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 11:46:16PM -0500, Peter Rabbitson wrote:
 > Hi everyone. I have a question regarding hardware caches. When I compile the
 > kernel on k6/2 cpu I get messages identifying L1 cache of 64k and L2 cache of
 > 1024k which are the actual hardware amounts. But kernel on a k6/3+ cpu gives

L1/L2 cache is on CPU. L3 is on motherboard. The kernel only reports
(and cares about) L1/L2 (And then asides from informational purposes,
i.e. /proc/cpuinfo, it's only used for anything useful under SMP which isn't
an issue for K6-3)

The L3 is being used transparently, with no need for any support by
the kernel. (As long as it's been enabled by the BIOS)

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
