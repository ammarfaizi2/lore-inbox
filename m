Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbVG2LA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbVG2LA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 07:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbVG2K6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 06:58:42 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8464 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262595AbVG2K5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 06:57:05 -0400
Date: Fri, 29 Jul 2005 12:57:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Radoslaw AstralStorm Szkodzinski <astralstorm@gorzow.mm.pl>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3 question
Message-ID: <20050729105704.GC3563@stusta.de>
References: <20050728194334.4f5b3f22.astralstorm@gorzow.mm.pl> <20050728105551.57f3183c.akpm@osdl.org> <20050728203133.0a03dbda.astralstorm@gorzow.mm.pl> <20050728204238.GC4790@stusta.de> <20050729025034.2b58d34e.astralstorm@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729025034.2b58d34e.astralstorm@gorzow.mm.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 02:50:34AM +0200, Radoslaw AstralStorm Szkodzinski wrote:
> On Thu, 28 Jul 2005 22:42:38 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> 
> > I'm surprised that you are that much concerned about compile errors when 
> > using a kernel that might regularly exchange the contents of /dev/hda 
> > and /dev/null .
> > 
> These bugs don't happen too often in reality.
> Just please don't be malicious and add this kind of code deliberately. :)
> 
> Every build breaker wastes my precious time to fix it. 
> That's compulsive/obsessive in some way. ;)
>...

Someone has to test it.

Andrew already wastes some of his precious time for testing before 
releasing a -mm kernel, but this doesn't catch every compile error.

If a -mm kernel doesn't compile for you, you can:
- apply a patch if it is already available
- fix it yourself
- wait for the next -mm

One of the purposes of -mm kernels is actually to find compile errors.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

