Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWDRTJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWDRTJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 15:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWDRTJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 15:09:56 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29192 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932294AbWDRTJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 15:09:55 -0400
Date: Tue, 18 Apr 2006 21:09:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] net/netlink/: possible cleanups
Message-ID: <20060418190954.GM11582@stusta.de>
References: <20060413162710.GE4162@stusta.de> <20060413.132603.94193712.davem@davemloft.net> <20060414103202.GF4162@stusta.de> <20060414105610.GA18149@2ka.mipt.ru> <20060418141946.GC11582@stusta.de> <1145386121.21723.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145386121.21723.28.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 07:48:41PM +0100, Alan Cox wrote:
> On Maw, 2006-04-18 at 16:19 +0200, Adrian Bunk wrote:
> > OTOH, we also have to always check whether users are expected soon (and 
> > recheck whether there are really users after some time) since every 
> > single export makes the kernel larger for nearly everyone.
> 
> Of course fixing the amount of memory used by an EXPORT_SYMBOL would be
> far more productive.

Both is productive.
You can decrease the amount of memory used by an EXPORT_SYMBOL, but you 
can't get it down to 0.

And in some cases the memory used by an EXPORT_SYMBOL mostly consists of 
an otherwise unused function...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

