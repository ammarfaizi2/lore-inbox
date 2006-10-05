Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWJENJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWJENJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 09:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWJENJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 09:09:25 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22278 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751454AbWJENJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 09:09:22 -0400
Date: Thu, 5 Oct 2006 15:09:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reenable SCSI=m
Message-ID: <20061005130921.GF16812@stusta.de>
References: <jemz8bvsnn.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jemz8bvsnn.fsf@sykes.suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 02:44:28PM +0200, Andreas Schwab wrote:

> Since CONFIG_SCSI (a tristate) now depends on CONFIG_BLOCK (a bool) it is
> no longer possible to set CONFIG_SCSI=m.
>...

A tristate depending on a bool is a common case that works just fine and 
allows the modular setting.

And CONFIG_SCSI=m is possible in 2.6.19-rc1.

What exactly is the problem you observed?

> Andreas.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

