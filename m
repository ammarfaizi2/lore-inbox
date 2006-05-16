Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751847AbWEPQMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbWEPQMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWEPQMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:12:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18950 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751846AbWEPQMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:12:30 -0400
Date: Tue, 16 May 2006 18:12:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Ihno Krumreich <ihno@suse.de>, Olaf Hering <olh@suse.de>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: 2.6.17-rc4-mm1: please drop add-raw-driver-kconfig-entry-for-s390.patch
Message-ID: <20060516161228.GF5677@stusta.de>
References: <20060515005637.00b54560.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515005637.00b54560.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 12:56:37AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc3-mm1:
>...
> +add-raw-driver-kconfig-entry-for-s390.patch
> 
>  Enable raw driver on s390

Since it seems the NAK's of Christoph and Martin weren't enough:
  NAK++

How many more NAK's does it require to prevent offering a deprecated 
option on additional architectures?

This driver is declared obsolete since more than two years, and while 
it's worth a discussion how long to keep it for legacy users, merging a 
patch offering an obsolete driver for even more users is silly.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

