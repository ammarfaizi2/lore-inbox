Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbUKHSL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUKHSL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUKHSLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:11:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41995 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261155AbUKHSHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:07:30 -0500
Date: Mon, 8 Nov 2004 19:06:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] small IPMI cleanup
Message-ID: <20041108180656.GA15077@stusta.de>
References: <20041106222839.GS1295@stusta.de> <418FB0EA.90006@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418FB0EA.90006@mvista.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 11:46:18AM -0600, Corey Minyard wrote:

> Adrian,

Hi Corey,

> All these things are tools used by external modules that have not yet 
> made it into the mainstream kernel.  Also, there are other users of 

OK.

> these functions that are perhaps not in the kernel yet (and perhaps 
> never make it into the mainstream kernel).  Some of the statics do need 
> to be cleaned up, though.

Why shouldn't they make it into the mainstream kernel?

> The IPMI driver was designed so that in-kernel users can use it as 
> easily as userland users.  So these are important parts of the interface.

For userland users, a global kernel function (even if EXPORT_SYMBOL'ed) 
is useless.

> -Corey

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

