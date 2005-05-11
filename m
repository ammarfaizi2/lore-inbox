Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVEKJJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVEKJJb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 05:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVEKJFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 05:05:55 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34310 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261950AbVEKJEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 05:04:45 -0400
Date: Wed, 11 May 2005 11:04:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Tom Duffy <tduffy@sun.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace cleanup)
Message-ID: <20050511090436.GL3590@stusta.de>
References: <20050510161657.3afb21ff.akpm@osdl.org> <20050510.161907.116353193.davem@davemloft.net> <20050510170246.5be58840.akpm@osdl.org> <20050510.170946.10291902.davem@davemloft.net> <Pine.LNX.4.62.0505110217350.2386@dragon.hyggekrogen.localhost> <20050510172913.2d47a4d4.akpm@osdl.org> <1115773263.3169.5.camel@duffman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115773263.3169.5.camel@duffman>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 06:01:03PM -0700, Tom Duffy wrote:
> 
> Solaris build makes sure files passes a "lint" test during the build and
> nothing can be checked in until such a test can pass.
> 
> Would it make sense to add such a test during kernel compile for Linux?
> Something that could be turned off if somebody needed really fast
> builds.  This would check for things like whitespace violations and
> other things that violate CodingStyle.
> 
> People tend to fix things quick if they break the build.

This works _after_ the kernel has been cleaned up.

And then there's the issue that some code (e.g. ACPI or XFS) is shared 
between Linux and other OS's, and therefore a limited amount of 
divergence from usual kernel coding style is allowed in such code.

> -tduffy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

