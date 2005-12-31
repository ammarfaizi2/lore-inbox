Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbVLaOzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVLaOzB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 09:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbVLaOzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 09:55:01 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27404 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964976AbVLaOzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 09:55:00 -0500
Date: Sat, 31 Dec 2005 15:54:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lawrence Walton <lawrence@the-penguin.otak.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: unkillable process dselect 2.6.15-rc1 and 2.6.15-rc1-mm1
Message-ID: <20051231145457.GK3811@stusta.de>
References: <20051118063734.GA1769@the-penguin.otak.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118063734.GA1769@the-penguin.otak.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 10:37:34PM -0800, Lawrence Walton wrote:

> Hi

Hi Lawrence,

> I have a system that has processes that can't be or even zombied. Most
> easily triggered by dpkg. but "make clean" in the Linux source seems to
> cause it too.
> 
> Seems related to SCSI and a root XFS file system. No oops but I did get
> a call trace. Not sure if it's generically a SCSI thing or specific to
> my card.
> 
> lspci says it's a AIC-7892A.
> 
> Question comments patches are welcome.

Is this issue still present in 2.6.15-rc7?
2.6.14 was OK?

Please sent the output of "dmesg -s 1000000" for both a working and a 
non-working kernel if it's still present in 2.6.15-rc7.

> BTW I've put other bugs in the bugzilla not related to this one, and
> received what I would characterize as deafening silence. Should I
> bother?
>...

Unfortunately, our bug handling is worse than it should be.

The Bugzilla is still a good place to prevent a bug from being 
completely forgotten.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

