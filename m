Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbVJET0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbVJET0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbVJET0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:26:11 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64528 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932638AbVJET0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:26:10 -0400
Date: Wed, 5 Oct 2005 21:26:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD Geode GX/LX support
Message-ID: <20051005192608.GB3847@stusta.de>
References: <20051003174738.GC29264@cosmic.amd.com> <20051003180532.GE3652@stusta.de> <20051003194655.GA30975@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003194655.GA30975@cosmic.amd.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 01:46:55PM -0600, Jordan Crouse wrote:
> > > +config MGEODE_GX
> > > +	bool "Geode GX"
> > > +	help
> > > +	  Select this for AMD Geode GX processors.  Enables use of some extended
> > > +	  instructions, and passes appropriate optimization flags to GCC.
> > >...
> > 
> > The "and passes appropriate optimization flags to GCC" part seems to be 
> > missing in your patches.
> 
> Yes - that is incorrect.  As you can no doubt see, I cut-n-pasted from
> another processor.
>...

Why don't you set any compiler flags?

I'd assume that there is one compiler flag usually producing the best 
code for the CPU.

> Thanks for your comments,
> Jordan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

