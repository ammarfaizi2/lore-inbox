Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVGWRIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVGWRIM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 13:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVGWRIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 13:08:12 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5906 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262066AbVGWRIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 13:08:11 -0400
Date: Sat, 23 Jul 2005 19:08:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: randy_dunlap <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/hamradio/: cleanups
Message-ID: <20050723170804.GG3160@stusta.de>
References: <20050502014637.GQ3592@stusta.de> <42BF2BA9.8060502@pobox.com> <20050626155318.7f065d5b.rdunlap@xenotime.net> <42BF337D.1050904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BF337D.1050904@pobox.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 07:00:13PM -0400, Jeff Garzik wrote:
> randy_dunlap wrote:
> >On Sun, 26 Jun 2005 18:26:49 -0400 Jeff Garzik wrote:
> >
> >| Adrian Bunk wrote:
> >| > This patch contains the following cleanups:
> >| > - dmascc.c: remove the unused global function dmascc_setup
> >| 
> >| Better to use it, then remove it.
> >
> >                    than ??
> 
> Yes.  Use it via __setup() or similar.

Hi Jeff,

I still haven't gotten any answer from you regarding the following 
question:

Can you give me a hint how it should be used?

Why doesn't dmascc_init together with the MODULE_PARM(io,...) work in
the non-modular case?

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

