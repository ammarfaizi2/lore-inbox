Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbTEJIht (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 04:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbTEJIht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 04:37:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:61182 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263693AbTEJIhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 04:37:48 -0400
Date: Sat, 10 May 2003 10:50:22 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andi Kleen <ak@muc.de>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix .altinstructions linking failures
Message-ID: <20030510085022.GL13649@fs.tum.de>
References: <20030506063055.GA15424@averell> <20030507092329.GA2389@wohnheim.fh-wedel.de> <20030507094752.GA4050@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507094752.GA4050@averell>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 11:47:52AM +0200, Andi Kleen wrote:
>...
> P.S.: In case someone is interested: The hall of shame for the 2.5.69 SMP
> maxi kernel (stuff that doesn't build) currently is:  Sound/Alsa (one driver 
> doesn't compile), USB (3 drivers don't compile), MTD (lots of stuff doesn't 
> compile).  Everything else is quite good.

At about a dozen SCSI drivers plus half a dozen drivers under 
drivers/char/* don't compile in 2.5.69 even for non-SMP. How did you 
manage to compile these?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

