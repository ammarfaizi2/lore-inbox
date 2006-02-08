Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbWBHVi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWBHVi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWBHVi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:38:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62226 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965148AbWBHVi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:38:27 -0500
Date: Wed, 8 Feb 2006 22:38:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jes Sorensen <jes@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Keith Owens'" <kaos@sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let IA64_GENERIC select more stuff
Message-ID: <20060208213825.GQ3524@stusta.de>
References: <20060208035112.GM3524@stusta.de> <200602080552.k185q9g07813@unix-os.sc.intel.com> <20060208115946.GN3524@stusta.de> <yq0d5hym0lq.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0d5hym0lq.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 08:38:57AM -0500, Jes Sorensen wrote:
> >>>>> "Adrian" == Adrian Bunk <bunk@stusta.de> writes:
> 
> Adrian> On Tue, Feb 07, 2006 at 09:52:09PM -0800, Chen, Kenneth W
> Adrian> wrote:
> >> But for the bit that this thread started, which disables
> >> CONFIG_MCKINLEY for CONFIG_IA64_GENERIC, it is totally wrong and is
> >> the "over my dead body" type of thing.
> 
> Adrian> My initial patch that started this thread was to remove all
> Adrian> select's from CONFIG_IA64_GENERIC.
> 
> Adrian> Is this OK for you?
> 
> Adrian,
> 
> Not really, it helps a bit by selecting some things we know we need
> for all GENERIC builds. True we can't make it bullet proof, but whats
> there is better than removing it.

Like the bug of allowing the illegal configuration NUMA=y, FLATMEM=y?

> Jes

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

