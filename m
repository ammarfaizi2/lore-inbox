Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbWHXNgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWHXNgz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWHXNgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:36:55 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55056 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751513AbWHXNgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:36:54 -0400
Date: Thu, 24 Aug 2006 15:36:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.28-rc2
Message-ID: <20060824133653.GJ19810@stusta.de>
References: <20060822230102.GC19896@stusta.de> <20060824132039.GC7055@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824132039.GC7055@elf.ucw.cz>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 03:20:39PM +0200, Pavel Machek wrote:

> Hi!

Hi Pavel!

> > Pavel Machek:
> >       remove obsolete swsusp_encrypt
> 
> Probably not a big deal, but IIRC this was cleanup patch. I am not
> sure if it is worth merging into -stable.

This patch removed an option that didn't have any effect.

IOW, less possible user confusion with no risk.

Additionally, the help text could wrongly imply for a user enabling this 
option would bring additional security.

Not a big deal, but my personal opinion was to merge it.

> 								Pavel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

