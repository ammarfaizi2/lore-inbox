Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWBVDQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWBVDQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 22:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWBVDQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 22:16:34 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21771 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750740AbWBVDQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 22:16:33 -0500
Date: Wed, 22 Feb 2006 04:16:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222031632.GD4661@stusta.de>
References: <3ACA40606221794F80A5670F0AF15F840AFD52B2@pdsmsx403>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840AFD52B2@pdsmsx403>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 10:39:01AM +0800, Yu, Luming wrote:
> >
> >Subject    : S3 sleep hangs the second time - 600X
> >References : http://bugzilla.kernel.org/show_bug.cgi?id=5989
> >Submitter  : Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
> >Status     : problematic commit identified,
> >             further discussion is in the bug
> 
> The real problem is there are some bugs hidden by ec_intr=0.
> ec_intr=1 just get these bug  just exposed, and we need to fix them. 

>From a users' point of view, these are regressions from 2.6.15, and not 
all of them might be fixed in time for 2.6.16.

What is a possible short term solution/workaround for 2.6.16?
Can we go back to default to polling mode in 2.6.16?

> Thanks,
> Luming

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

