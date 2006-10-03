Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWJCQXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWJCQXQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWJCQXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:23:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30732 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750902AbWJCQXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:23:15 -0400
Date: Tue, 3 Oct 2006 18:23:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-1.2689.fc6PAE: oops in ext3_clear_inode+0x52/0x8b
Message-ID: <20061003162313.GA7398@stusta.de>
References: <451C33B2.5000007@goop.org> <20060928142313.8848cec9.akpm@osdl.org> <4521F5DE.7070302@sandeen.net> <20061003054242.GK3278@stusta.de> <45226E4D.8020302@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45226E4D.8020302@sandeen.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 09:06:05AM -0500, Eric Sandeen wrote:
> Adrian Bunk wrote:
> >On Tue, Oct 03, 2006 at 12:32:14AM -0500, Eric Sandeen wrote:
> >>Andrew Morton wrote:
> 
> >>>>BUG: unable to handle kernel paging request at virtual address 756e6547
> >>>756e6547 -> uneG.   Matches "GenuineIntel".
> >>>
> >>>That'll get written into a temporary page by the /proc/cpuinfo handler, 
> >>>so
> >>>it might just be a use-uninitialised.
> >>But strangely enough, it's the second report we've seen with this exact 
> >>backtrace, and the same "Genu" ascii string where the i_default_acl 
> >>should be.
> >>
> >>Both boxes had been through a suspend-to-ram recently, just in case that 
> >>might matter.
> >>
> >>Seems like something more than random chance...
> >
> >Can you give a pointer to the other report?
> 
> Sure, https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=207658

Another tainted kernel...

> -Eric

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

