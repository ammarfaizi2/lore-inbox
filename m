Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVERTzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVERTzq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 15:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVERTzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 15:55:46 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49673 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262327AbVERTxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 15:53:41 -0400
Date: Wed, 18 May 2005 21:53:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Gilbert, John" <JGG@dolby.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Illegal use of reserved word in system.h
Message-ID: <20050518195337.GX5112@stusta.de>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 12:07:29PM -0700, Gilbert, John wrote:

> Hi Adrian,

Hi John,

> This looks like the source of some stupidity.
> http://bugs.mysql.com/bug.php?id=555
>...

that's not a check whether the system supports SMP.

Looking at the source code of MySQL, it seems MySQL does some dirty 
tricks for using the inlines from asm/atomic.h in userspace.

It's _really_ wrong to do this.

> John G.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

