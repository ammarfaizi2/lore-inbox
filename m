Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVAaVxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVAaVxe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 16:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVAaVxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 16:53:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40718 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261388AbVAaVxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 16:53:16 -0500
Date: Mon, 31 Jan 2005 22:53:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/char/sonypi.c: make 3 structs static
Message-ID: <20050131215312.GG21437@stusta.de>
References: <20050131173508.GS18316@stusta.de> <20050131214905.GF28886@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131214905.GF28886@deep-space-9.dsnet>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 10:49:05PM +0100, Stelian Pop wrote:
> On Mon, Jan 31, 2005 at 06:35:08PM +0100, Adrian Bunk wrote:
> 
> > This patch makes three needlessly global structs static.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > ---
> > 
> >  drivers/char/sonypi.c |   76 +++++++++++++++++++++++++++++++++++++++++-
> >  drivers/char/sonypi.h |   74 ----------------------------------------
> >  2 files changed, 75 insertions(+), 75 deletions(-)
> 
> sonypi.h is a "local" header file used only by sonypi.c.
> 
> I would like to keep those tables in sonypi.h rather than putting 
> all into sonypi.c (or we could as well remove sonypi.h and put all the
> contents into the .c).
> 
> What about:
>...

That's also OK with me.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

