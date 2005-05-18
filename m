Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVERTCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVERTCR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 15:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVERTCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 15:02:17 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11273 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262236AbVERTCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 15:02:12 -0400
Date: Wed, 18 May 2005 21:02:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Gilbert, John" <JGG@dolby.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h
Message-ID: <20050518190207.GV5112@stusta.de>
References: <2692A548B75777458914AC89297DD7DA08B0866E@bronze.dolby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2692A548B75777458914AC89297DD7DA08B0866E@bronze.dolby.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 11:23:33AM -0700, Gilbert, John wrote:

> Hello all,

Hi John,

>...
> Examples: The use of "new" in the macro __cmpxchg in system.h. This hits
> MySQL which links into the kernel headers to determine if the platform
> is SMP aware or not (don't ask me why.) 
>...

I haven't ever seen MySQL doing something that stupid (stupid because 
if it's required, it _really_ has to be done at runtime).

Which version of MySQL have you seen such an SMP check in?

> John Gilbert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

