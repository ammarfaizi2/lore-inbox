Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVB1VyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVB1VyD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 16:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVB1VyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 16:54:02 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:65288 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261759AbVB1Vx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 16:53:56 -0500
Date: Mon, 28 Feb 2005 22:53:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, andrew.vasquez@qlogic.com,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/qla2xxx/: cleanups
Message-ID: <20050228215355.GQ4021@stusta.de>
References: <20050228210024.GM4021@stusta.de> <20050228212920.GA18162@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228212920.GA18162@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 09:29:20PM +0000, Christoph Hellwig wrote:
> On Mon, Feb 28, 2005 at 10:00:24PM +0100, Adrian Bunk wrote:
> > This patch contains the following cleanups:
> > - make needlessly global code static
> > - kill the unused global *_version and *_version_str variables
> >   in the firmware files
> 
> The firmware files are generated, so it'd be better to leave them
> alone.

Agreed.

But can't the generation of these files omit these needless variables 
(there are already #define's containing the version information)?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

