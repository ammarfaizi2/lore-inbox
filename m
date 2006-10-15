Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWJOKvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWJOKvL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 06:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWJOKvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 06:51:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39688 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750778AbWJOKvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 06:51:10 -0400
Date: Sun, 15 Oct 2006 12:51:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg Banks <gnb@melbourne.sgi.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>, Paul Jackson <pj@sgi.com>
Subject: Re: undefined reference to highest_possible_node_id
Message-ID: <20061015105106.GV30596@stusta.de>
References: <20061015080421.GA17399@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061015080421.GA17399@aepfle.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2006 at 10:04:21AM +0200, Olaf Hering wrote:
> 
> A 2.6.19-rc2 pseries_defconfig build with SMP=n will not link,
> highest_possible_node_id is undefined because NODES_SHIFT == 4.
> How can this be fixed properly?

This known bug in -mm [1] made it into Linus' tree?

It's not funny if more than a month after a bug report against -mm the 
bug is not only unfixed but even propagated to Linus' tree.  :-(

cu
Adrian

[1] http://lkml.org/lkml/2006/9/4/233

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

