Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWBOVsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWBOVsf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 16:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWBOVsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 16:48:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25360 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751307AbWBOVsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 16:48:35 -0500
Date: Wed, 15 Feb 2006 22:48:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deprecate the tasklist_lock export
Message-ID: <20060215214833.GA5066@stusta.de>
References: <20060215130734.GA5590@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215130734.GA5590@lst.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 02:07:34PM +0100, Christoph Hellwig wrote:
> Drivers have no business looking at the task list and thus using this
> lock.  The only possibly modular users left are:
> 
>  arch/ia64/kernel/mca.c
>...
>  fs/binfmt_elf.c
> 
> which I'll send out fixes for soon.
>...

These two can't be built modular.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

