Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVCBJmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVCBJmd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 04:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVCBJmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 04:42:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28687 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262244AbVCBJmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 04:42:31 -0500
Date: Wed, 2 Mar 2005 10:42:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Missing 'noinline' and '__compiler_offsetof' for GCC4+
Message-ID: <20050302094230.GB4608@stusta.de>
References: <1109755008.19535.16.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109755008.19535.16.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 09:16:47AM +0000, David Woodhouse wrote:

> At some point we'll want to create 'compiler-gcc4.h' but probably not
> until it's going to be actually differ from 'compiler-gcc+.h'. Because
> they only get out of date if they're not used by anyone...
>...

The solution already in -mm is:
- compiler-gcc+.h removed because it was never updated
- compiler-gcc4.h created, contains compiler-gcc+.h plus the two fixes 
  you noted

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

