Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVEOJdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVEOJdi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 05:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVEOJdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 05:33:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6159 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261571AbVEOJdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 05:33:36 -0400
Date: Sun, 15 May 2005 11:33:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       Matt Mackall <mpm@selenic.com>, Andy Isaacson <adi@hexapodia.org>,
       Andi Kleen <ak@muc.de>, "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050515093332.GN16549@stusta.de>
References: <20050513212620.GA12522@hexapodia.org> <20050513215905.GY5914@waste.org> <1116024419.20646.41.camel@localhost.localdomain> <1116025212.6380.50.camel@mindpipe> <20050513232708.GC13846@redhat.com> <1116027488.6380.55.camel@mindpipe> <1116084186.20545.47.camel@localhost.localdomain> <1116088229.8880.7.camel@mindpipe> <1116089068.6007.13.camel@laptopd505.fenrus.org> <1116093396.9141.11.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116093396.9141.11.camel@mindpipe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 01:56:36PM -0400, Lee Revell wrote:
> On Sat, 2005-05-14 at 18:44 +0200, Arjan van de Ven wrote:
> > then JACK is terminally broken if it doesn't have a fallback for non-
> > rdtsc cpus. 
> 
> It does have a fallback, but the selection is done at compile time.  It
> uses rdtsc for all x86 CPUs except pre-i586 SMP systems.
> 
> Maybe we should check at runtime, but this has always worked.

If this is critical for JACK, runtime selection was an improvement for 
distributions like Debian that support both pre-i586 SMP systems and 
current hardware.

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

