Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbVLMVzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbVLMVzn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbVLMVzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:55:42 -0500
Received: from sd291.sivit.org ([194.146.225.122]:27659 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1030249AbVLMVzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:55:42 -0500
Subject: Re: sonypi searching new maintainer (Was: Re: [RFT] Sonypi:
	convert to the new platform device interface)
From: Stelian Pop <stelian@popies.net>
To: dtor_core@ameritech.net
Cc: Mattia Dongili <malattia@linux.it>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d5000512131248j79a93d5ex8667ca6a38452a1d@mail.gmail.com>
References: <200512130219.41034.dtor_core@ameritech.net>
	 <20051213183248.GA3606@inferi.kami.home>
	 <d120d5000512131104x260fdbf2mcc58fb953559fec5@mail.gmail.com>
	 <1134505855.9642.28.camel@deep-space-9.dsnet>
	 <d120d5000512131248j79a93d5ex8667ca6a38452a1d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 13 Dec 2005 22:55:36 +0100
Message-Id: <1134510936.9642.31.camel@deep-space-9.dsnet>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 13 décembre 2005 à 15:48 -0500, Dmitry Torokhov a écrit :
> On 12/13/05, Stelian Pop <stelian@popies.net> wrote:
> > Le mardi 13 décembre 2005 à 14:04 -0500, Dmitry Torokhov a >
> > > > sonypi: unknown event port1=0x0f,port2=0x05
> > [...]
> > > > Oh, there seems to be a spurious interrupt happening at modules
> > > > insertion (I suspect sonypi_enable triggering and ignoring it), but this
> > > > happens with the old module too and I never noticed it before. Wouldn't
> > > > make more sense to print the warning even if verbose=0 to be able to
> > > > catch it timely? I mean it's since 2.4 times I don't enable verbose mode
> > > > in sonypi...
> > > >
> > > Probably, let's see what Stelian will say.
> >
> > This is the "ok I'm loaded" event. I am not sure this event is available
> > on all the sonypi supported platforms, that's why it hasn't been defined
> > as a known event. And it doesn't make much sense to forward it anyways.
> >
> > I would leave it like it is now.
> >
> 
> But when it is reported is it the same event? 

I don't follow you here... 

> If so we could just not
> warn when we see it (but still dont forward it to the userspace).

The warning is only present if 'verbose > 0', so in normal conditions
you won't see it.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

