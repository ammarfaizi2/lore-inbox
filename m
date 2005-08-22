Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVHVUiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVHVUiD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVHVUiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:38:03 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26642 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751103AbVHVUiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:38:02 -0400
Date: Mon, 22 Aug 2005 22:38:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SECURITY must depend on SYSFS
Message-ID: <20050822203800.GH9927@stusta.de>
References: <20050822162050.GC9927@stusta.de> <20050822173003.GS7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822173003.GS7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 10:30:03AM -0700, Chris Wright wrote:
> * Adrian Bunk (bunk@stusta.de) wrote:
> >  config SECURITY
> >  	bool "Enable different security models"
> > +	depends on SYSFS
> 
> Hmm, what about select instead?

I have no strong opinion on this, especially since this is only an issue 
in the COMFIG_EMBEDDED=y case.

> thanks,
> -chris

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

