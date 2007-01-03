Return-Path: <linux-kernel-owner+w=401wt.eu-S932076AbXACUT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbXACUT5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbXACUT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:19:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4678 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932076AbXACUT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:19:57 -0500
Date: Wed, 3 Jan 2007 21:20:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Udo van den Heuvel <udovdh@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "kernel + gcc 4.1 = several problems" / "Oops in 2.6.19.1"
Message-ID: <20070103202000.GJ20714@stusta.de>
References: <459BCAD5.2020604@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459BCAD5.2020604@xs4all.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 04:25:09PM +0100, Udo van den Heuvel wrote:
> Hello,
> 
> I just read about the subjects.
> I have a firewall which has some issues.
> First it was a VIA CL6000 (c3).
> Now it is a EK8000 (c3-2) with different power supply, RAM and board of
> course. Still I see strange things sometimes. Crashes, hangs, etc. Now
> and then. Not too often.
> 
> I have in .config:
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> CONFIG_MVIAC3_2=y
> 
> Does this mean the issue applies to my own kernels?

It could be.
Or it could be something completely different.

If the same kernel compiled with gcc 3.4.6 works fine, you might run 
into one of the mysterious problems with gcc 4.1.

It could also be hardware problems (e.g. try running memtest86 for a 
longer time).

Does the machine hang completely, or is any useful information like e.g. 
an oops available?

> Udo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

