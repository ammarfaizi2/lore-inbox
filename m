Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVA0CSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVA0CSP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVAZXpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:45:53 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:50659 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261971AbVAZTIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:08:35 -0500
Date: Wed, 26 Jan 2005 22:27:43 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: dtor_core@ameritech.net, Christoph Hellwig <hch@infradead.org>,
       Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050126222743.1e0a29ff@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050126181941.GC5297@stusta.de>
References: <20050124214751.GA6396@infradead.org>
	<20050125060256.GB2061@kroah.com>
	<20050125195918.460f2b10.khali@linux-fr.org>
	<20050126003927.189640d4@zanzibar.2ka.mipt.ru>
	<20050125224051.190b5ff9.khali@linux-fr.org>
	<20050126013556.247b74bc@zanzibar.2ka.mipt.ru>
	<20050126101434.GA7897@infradead.org>
	<1106737157.5257.139.camel@uganda>
	<d120d5000501260600fb8589e@mail.gmail.com>
	<1106757528.5257.221.camel@uganda>
	<20050126181941.GC5297@stusta.de>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005 19:19:41 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> On Wed, Jan 26, 2005 at 07:38:48PM +0300, Evgeniy Polyakov wrote:
> >...
> > Btw, where was comments about w1, kernel connector and acrypto? 
> > They were presented several times in lkml and all are completely new
> > subsystems.
> > Should I stop developing just because I did not get comments?
> >...
> 
> I sent you comments regarding w1 two months ago regarding:
> - the unneeded dscore -> ds9490r rename in the Makefile
> - completely unused EXPORT_SYMBOL's (that seem to be still unused today)
> 
> Being honest, I have to admit that your reactions didn't sound as if you 
> were waiting for comments.
> 
> > Thank you.

I greatly appreciate your comments, and they were addressed.
Part of exported symbols are unexported, patch is just waiting to be sent,
but I do not agree with dscore rename. I just do not understand it's advantage.

> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
