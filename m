Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUH1V2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUH1V2u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267974AbUH1V1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:27:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2250 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267851AbUH1VYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:24:30 -0400
Date: Sat, 28 Aug 2004 23:24:20 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jens Axboe <axboe@suse.de>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch][3/3] mm/ BUG -> BUG_ON conversions
Message-ID: <20040828212419.GM12772@fs.tum.de>
References: <20040828151137.GA12772@fs.tum.de> <20040828151837.GD12772@fs.tum.de> <200408281932.05964.vda@port.imtp.ilyichevsk.odessa.ua> <20040828205823.GB8716@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828205823.GB8716@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 10:58:23PM +0200, Jens Axboe wrote:
> 
> BUG_ON(1); must always BUG(). That said, it's never wise to put
> expressions with side-effects into macros.

The intention is, to add an option that lets BUG/BUG_ON/WARN_ON/PAGE_BUG 
do nothing. This option should be hidden under EMBEDDED.

In some environments, this seems to be desirable.

> Jens Axboe

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

