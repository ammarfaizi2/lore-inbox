Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUKHVTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUKHVTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUKHVTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 16:19:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10506 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261236AbUKHVTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 16:19:52 -0500
Date: Mon, 8 Nov 2004 22:19:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] small IPMI cleanup
Message-ID: <20041108211920.GF15077@stusta.de>
References: <20041106222839.GS1295@stusta.de> <418FB0EA.90006@mvista.com> <20041108180656.GA15077@stusta.de> <418FB9BF.1000809@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418FB9BF.1000809@mvista.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 12:23:59PM -0600, Corey Minyard wrote:
> Adrian Bunk wrote:
> 
> >>these functions that are perhaps not in the kernel yet (and perhaps 
> >>never make it into the mainstream kernel).  Some of the statics do need 
> >>to be cleaned up, though.
> >>   
> >>
> >
> >Why shouldn't they make it into the mainstream kernel?
> > 
> >
> Sometimes people create specific tools that only support a specific type 
> of board.  I'm not sure every single thing written to go into the kernel 

Check the MIPS port how many different evaluation boards it supports.
AFAIK there's not a strict minimum of production units until some code 
is allowed to enter the kernel.

> should be included i nthe mainstream kernel.  It's a hard call, but if 
> it for some very specific thing then the vendor may not be interested in 
> doing this.
>...

In this case, I don't see a reason for hooks in the main kernel to 
support such functionality.

> -Corey

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

