Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266819AbUHCTod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266819AbUHCTod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 15:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUHCTod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 15:44:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15296 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266819AbUHCTob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 15:44:31 -0400
Date: Tue, 3 Aug 2004 21:44:24 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
Message-ID: <20040803194424.GD2746@fs.tum.de>
References: <20040802015527.49088944.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802015527.49088944.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 01:55:27AM -0700, Andrew Morton wrote:
>...
> All 388 patches:
>...
> gcc35-always-inline.patch
>   gcc-3.5 fixes
>...
> gcc35-fixmap.h.patch
>   gcc-3.5 fixes
>...

Please drop these patches:

I can't see any way how they would fulfill Andi's claim that they would 
be required for gcc 3.5 .

All they do is to add an __always_inline which is _exactly_ the same as 
__inline__, __inline and inline .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

