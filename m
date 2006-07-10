Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422692AbWGJUFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422692AbWGJUFq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 16:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422695AbWGJUFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 16:05:46 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28426 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422692AbWGJUFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 16:05:45 -0400
Date: Mon, 10 Jul 2006 22:05:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, pasky@suse.cz
Subject: Re: git, hardlinks and backups
Message-ID: <20060710200543.GG13938@stusta.de>
References: <20060710195727.GA2246@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710195727.GA2246@elf.ucw.cz>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 09:57:27PM +0200, Pavel Machek wrote:
> Hi!
> 
> I know this may be stupid, but...
> 
> I'm backing up my linux kernel trees, and found out that backup (done
> by rsync) is twice as big as original. That's quite bad... it is
> because git uses hardlinks heavily but rsync can't preserve them.
> 
> I'm pretty sure someone hit this before... what is the trick?

$ rsync --help | grep "preserve hard links"
 -H, --hard-links            preserve hard links
$ 

> 								Pavel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

