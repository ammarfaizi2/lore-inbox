Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVABUig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVABUig (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVABUh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:37:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44560 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261328AbVABUgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:36:12 -0500
Date: Sun, 2 Jan 2005 21:36:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: luto@myrealbox.com, aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
Message-ID: <20050102203610.GD4183@stusta.de>
References: <20050102193724.GA18136@elf.ucw.cz> <20050102201147.GB4183@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102201147.GB4183@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 09:11:47PM +0100, Adrian Bunk wrote:
> On Sun, Jan 02, 2005 at 08:37:24PM +0100, Pavel Machek wrote:
> 
> > Well, umount -l can be handy, but it does not allow you to get your CD
> > back from the drive.
> > 
> > umount --kill that kills whoever is responsible for filesystem being
> > busy would solve part of the problem (that can be done in userspace,
> > today).
> >...
> 
> What's wrong with
> 
>   fuser -k /mnt && umount /mnt
>...

I meant

  fuser -km /mnt && umount /mnt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

