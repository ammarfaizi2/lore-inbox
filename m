Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262554AbREVDXA>; Mon, 21 May 2001 23:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262555AbREVDWu>; Mon, 21 May 2001 23:22:50 -0400
Received: from ns.suse.de ([213.95.15.193]:52743 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262554AbREVDWh>;
	Mon, 21 May 2001 23:22:37 -0400
Date: Tue, 22 May 2001 05:22:35 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Steven Walter <srwalter@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
In-Reply-To: <20010521215927.B31289@hapablap.dyn.dhs.org>
Message-ID: <Pine.LNX.4.30.0105220519160.20545-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2001, Steven Walter wrote:

> > Any particular reason this needs to be done in the kernel, as opposed
> > to having your script read /dev/cpu/*/cpuid?
> Wouldn't that be the same reason we have /anything/ in cpuinfo?

When /proc/cpuinfo was added, we didn't have /dev/cpu/*/cpuid
Now that we do, we're stuck with keeping /proc/cpuinfo for
compatability reasons.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

