Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVLPOEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVLPOEZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVLPOEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:04:24 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:65297 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932272AbVLPOEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:04:24 -0500
Date: Fri, 16 Dec 2005 15:04:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Diego Calleja <diegocg@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051216140425.GY23349@stusta.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051216141002.2b54e87d.diegocg@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 02:10:02PM +0100, Diego Calleja wrote:
> El Thu, 15 Dec 2005 14:00:13 -0800,
> Andrew Morton <akpm@osdl.org> escribió:
> 
> 
> > Supporting 8k stacks is a small amount of code and nobody has seen a need
> > to make changes in there for quite a long time.  So there's little cost to
> > keeping the existing code.
> > 
> > And the existing code is useful:
> 
> Maybe this slighty different approach is better? 
>...

My count of bug reports for problems with 4k stacks after Neil's patch
went into -mm is still at 0.

Either there are no problems left or noone pays attention to them since 
disabling 4k stacks "fixed" the problem.

In both cases there's no reason against applying my patch.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

