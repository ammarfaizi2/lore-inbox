Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVDDRe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVDDRe5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 13:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVDDRe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 13:34:57 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12804 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261301AbVDDRez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 13:34:55 -0400
Date: Mon, 4 Apr 2005 19:34:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Daniel Drake <dsd@gentoo.org>, perex@suse.cz
Cc: David Ford <david+challenge-response@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org
Subject: Re: ALSA bugs with 2.6.12-rc1
Message-ID: <20050404173453.GB4087@stusta.de>
References: <42515358.7020101@blue-labs.org> <4251749B.5060603@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4251749B.5060603@gentoo.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 06:08:43PM +0100, Daniel Drake wrote:
> David Ford wrote:
> > It seems that 2.6.12-rc1 introduced an ALSA bug generating an oops for a
> > null pointer.
> > 
> > codec_semaphore: semaphore is not ready [0x1][0x300300]
> > codec_read 0: semaphore is not ready for register 0x2c
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000000
> > 
> > This happens on multiple machines, 32b and 64bit.  I'll be happy to
> > provide further information if needed.
> 
> This only happens when you mismatch your kernel and alsa-lib versions, e.g.
> running alsa-lib-1.0.9-rc2 with alsa-1.0.8 in-kernel drivers, or possibly
> vice-versa.

Are you saying the userspace interface of the ALSA kernel drivers has 
incompatible changes between minor versions of ALSA?

If this is true, that's a serious bug.

> Daniel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

