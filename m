Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUHaRsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUHaRsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUHaRsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:48:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19136 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265932AbUHaRr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:47:28 -0400
Date: Tue, 31 Aug 2004 19:47:19 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1-mm2: why is DIGIEPCA marked BROKEN?
Message-ID: <20040831174719.GG3466@fs.tum.de>
References: <20040830235426.441f5b51.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830235426.441f5b51.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 11:54:26PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.9-rc1-mm1:
>...
> +mark-pcxx-as-broken.patch
> 
>  Dead driver
>...

<--  snip  -->

From: Christoph Hellwig <hch@lst.de>

It's already marked BROKEN_ON_SMP, but even a UP compile yields tons of
errors.  While those aren't deeply complicated to fix having them for over
a year now is a pretty good indicator no one cares.

<--  snip  -->


If I revert mark-pcxx-as-broken.patch, the driver compiles UP for me 
with exactly zero errors or warnings.

@Christoph:
Could you post the errors you observed?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

