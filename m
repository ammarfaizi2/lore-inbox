Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVGDSWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVGDSWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 14:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVGDSWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 14:22:43 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57105 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261228AbVGDSWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 14:22:41 -0400
Date: Mon, 4 Jul 2005 20:22:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Alexander Nyberg <alexn@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050704182237.GW5346@stusta.de>
References: <20050607212706.GB7962@stusta.de> <200506081339.57012.vda@ilport.com.ua> <20050608111200.GG3641@stusta.de> <200506081513.09828.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506081513.09828.vda@ilport.com.ua>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 03:13:09PM +0300, Denis Vlasenko wrote:
> On Wednesday 08 June 2005 14:12, Adrian Bunk wrote:
> > On Wed, Jun 08, 2005 at 01:39:56PM +0300, Denis Vlasenko wrote:
> > >...
> > > NB: gcc 3.4.3 can use excessive stack in degenerate cases, so please
> > > include gcc version in your reports.
> > 
> > But this can't occur in the kernel.
> 
> It can. I saw the OOPS myself.
> One of the functions in crypto/wp512.c was compiled with 3k+ stack usage.

Strange that "make checkstack" didn't show this.

Are there any other 4KSTACKS problems you know about?

> vda

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

