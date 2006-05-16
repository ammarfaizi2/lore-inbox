Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWEPQmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWEPQmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWEPQmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:42:14 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46854 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932139AbWEPQmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:42:12 -0400
Date: Tue, 16 May 2006 18:42:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andrew Morton <akpm@osdl.org>, Ananda Raju <ananda.raju@neterion.com>,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [-mm patch] drivers/net/s2io.c: make bus_speed[] static
Message-ID: <20060516164210.GI5677@stusta.de>
References: <20060515005637.00b54560.akpm@osdl.org> <20060516153050.GC5677@stusta.de> <20060516153611.GA13270@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516153611.GA13270@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 05:36:11PM +0200, Andreas Mohr wrote:
> Hi,
> 
> On Tue, May 16, 2006 at 05:30:50PM +0200, Adrian Bunk wrote:
> > This patch makes the needlessly global bus_speed[] static.
> 
> Is there a reason why you don't also constify it while you are at it?
> Or is it because you want to do a series of static-only patches for now?

The latter.

Feel free to send a patch that also makes it const.

> Andreas Mohr

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

