Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750738AbWFEL0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWFEL0L (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 07:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbWFEL0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 07:26:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14353 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750738AbWFEL0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 07:26:10 -0400
Date: Mon, 5 Jun 2006 13:26:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ivan Novick <ivan@0x4849.net>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
        Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: merging new drivers (was Re: 2.6.18 -mm merge plans)
Message-ID: <20060605112610.GQ3955@stusta.de>
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060605013223.GD17361@havoc.gtf.org> <20060604184711.0a328d18.akpm@osdl.org> <20060605085918.GB26766@infradead.org> <1149505820.10626.263059761@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149505820.10626.263059761@webmail.messagingengine.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 12:10:20PM +0100, Ivan Novick wrote:
> > And especially in scsi land I'm absolutely against putting in more
> > substandard drivers.  The subsystem is still badly plagued from lots of old drivers
> > that aren't up to any standards, and we need to decrease the maintaince load
> > due to odd drivers not increase it even further.
> 
> Is there a hit-list of old drivers that need work, in case someone is
> interested in helping?

Not a complete list, but a good way for finding 50 drivers that need 
work:
  grep scsi_module.c drivers/scsi/*

> Ivan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

