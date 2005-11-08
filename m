Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbVKHN35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbVKHN35 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbVKHN35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:29:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16654 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965104AbVKHN34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:29:56 -0500
Date: Tue, 8 Nov 2005 14:29:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: export genapic again
Message-ID: <20051108132954.GQ3847@stusta.de>
References: <4370AEE1.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4370AEE1.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 01:57:53PM +0100, Jan Beulich wrote:
> A change not too long ago made i386's genapic symbol no longer be
> exported, and thus certain low-level functions no longer be usable.
> Since close-to-the-hardware code may still be modular, this
> rectifies the situation.

We don't export symbols for "there might be some driver that might need 
this".

Can we discuss this issue when such a driver gets submitted for 
inclusion in the kernel?

> From: Jan Beulich <jbeulich@novell.com>
> 
> (actual patch attached)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

