Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161372AbWKUVjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161372AbWKUVjD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161382AbWKUVjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:39:02 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30986 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161372AbWKUVjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:39:00 -0500
Date: Tue, 21 Nov 2006 22:39:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mattia Dongili <malattia@linux.it>, cpufreq@lists.linux.org.uk
Subject: Re: [discuss] 2.6.19-rc6: known regressions (v4)
Message-ID: <20061121213900.GT5200@stusta.de>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org> <20061121212424.GQ5200@stusta.de> <20061121213139.GC9651@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061121213139.GC9651@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 04:31:39PM -0500, Dave Jones wrote:
> On Tue, Nov 21, 2006 at 10:24:24PM +0100, Adrian Bunk wrote:
> 
>  > Subject    : CPU_FREQ_GOV_ONDEMAND=y compile error
>  > References : http://lkml.org/lkml/2006/11/17/198
>  > Submitter  : alex1000@comcast.net
>  > Caused-By  : Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
>  >              commit 05ca0350e8caa91a5ec9961c585c98005b6934ea
>  > Handled-By : Mattia Dongili <malattia@linux.it>
>  > Patch      : http://lkml.org/lkml/2006/11/17/236
>  > Status     : patch available
> 
> not a regression, easily worked around, queued for .20

It is a regression since commit 05ca0350e8caa91a5ec9961c585c98005b6934ea 
was merged after 2.6.18.

Considering that the fix is trivial, why shouldn't it be merged before 
2.6.19?

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

