Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbVLACGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVLACGP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 21:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVLACGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 21:06:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63493 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751312AbVLACGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 21:06:15 -0500
Date: Thu, 1 Dec 2005 03:06:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       zippel@linux-m68k.org, george@mvista.com, johnstul@us.ibm.com
Subject: Re: [patch 01/43] Move div_long_long_rem out of jiffies.h
Message-ID: <20051201020615.GT31395@stusta.de>
References: <20051130231140.164337000@tglx.tec.linutronix.de> <1133395255.32542.444.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133395255.32542.444.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 01:00:54AM +0100, Thomas Gleixner wrote:
> plain text document attachment
> (move-div-long-long-rem-out-of-jiffiesh.patch)
> 
> - move div_long_long_rem() from jiffies.h into a new calc64.h include file,
>   as it is a general math function useful for other things than the jiffy
>   code.
>...

- add a static inline div_long_long_rem_signed() function

This isn't against your patch, but this part of the change wasn't 
documented.


And while you are at it, is there a reason against making 
div_long_long_rem() a static inline?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

