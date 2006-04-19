Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWDSVCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWDSVCS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWDSVCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:02:18 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4357 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751227AbWDSVCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:02:18 -0400
Date: Wed, 19 Apr 2006 23:02:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Adam Baker <parport@baker-net.org.uk>
Cc: linux-parport@lists.infradead.org, Andrew Morton <akpm@osdl.org>,
       philb@gnu.org, andrea@suse.de, tim@cyberelk.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-parport] [2.6 patch] drivers/parport/share.: unexport parport_get_port
Message-ID: <20060419210216.GF25047@stusta.de>
References: <20060418220720.GQ11582@stusta.de> <200604192103.17854.parport@baker-net.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604192103.17854.parport@baker-net.org.uk>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 09:03:17PM +0100, Adam Baker wrote:
> On Tuesday 18 April 2006 23:07, Adrian Bunk wrote:
> > This patch removes the unused EXPORT_SYMBOL(parport_get_port).
> >
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> 
> It may be unused by any drivers that ship with the kernel but it is used by 
> the ppscsi patch to support SCSI over parallel port devices. This export was 
> removed in 2.6.10 and put back in in 2.6.16 so someone else obviously thinks 
> it should be exported.
>...

That someone else thinks it should be exported hasn't any value.

If the SCSI over parallel port drivers are considered valuable, someone 
should work on getting them included in the kernel.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

