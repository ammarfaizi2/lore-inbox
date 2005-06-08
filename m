Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVFHLMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVFHLMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVFHLMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:12:17 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7435 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262164AbVFHLMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:12:02 -0400
Date: Wed, 8 Jun 2005 13:12:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Alexander Nyberg <alexn@telia.com>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050608111200.GG3641@stusta.de>
References: <20050607212706.GB7962@stusta.de> <1118180858.956.27.camel@localhost.localdomain> <200506081339.57012.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506081339.57012.vda@ilport.com.ua>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 01:39:56PM +0300, Denis Vlasenko wrote:
>...
> NB: gcc 3.4.3 can use excessive stack in degenerate cases, so please
> include gcc version in your reports.

But this can't occur in the kernel.
We are working aroung the possible problems in SuSE gcc 3.3 and
GNU gcc 3.4 and 4.0 by always disabling unit-at-a-time in the kernel
on i386.

> vda

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

