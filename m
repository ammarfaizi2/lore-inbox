Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWGKQHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWGKQHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWGKQHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:07:43 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23300 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751133AbWGKQHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:07:42 -0400
Date: Tue, 11 Jul 2006 18:07:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ide/: cleanups
Message-ID: <20060711160741.GZ13938@stusta.de>
References: <20060711141637.GS13938@stusta.de> <1152634744.18028.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152634744.18028.26.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 05:19:04PM +0100, Alan Cox wrote:
> Ar Maw, 2006-07-11 am 16:16 +0200, ysgrifennodd Adrian Bunk:
> > This patch contains the following cleanups:
> 
> > - ide.c: remove the unused EXPORT_SYMBOL(ide_register_hw)
> 
> NAK. A simple grep shows ide_register_hw has users, 5 in fact as of
> 2.6.17.

I know, and I checked them, and Sergei already pointed out that I missed 
the one that can be modular.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

