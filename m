Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136270AbRDVTAt>; Sun, 22 Apr 2001 15:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136269AbRDVTAa>; Sun, 22 Apr 2001 15:00:30 -0400
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:14210 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S136265AbRDVTAQ>;
	Sun, 22 Apr 2001 15:00:16 -0400
Message-ID: <3AE32A17.9F5D1207@mirai.cx>
Date: Sun, 22 Apr 2001 11:59:35 -0700
From: J Sloan <jjs@mirai.cx>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Manuel McLure <manuel@mclure.org>, John Cavan <johnc@damncats.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12 unresolved symbol rwsem...
In-Reply-To: <E14rOuO-0006LH-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > > Using /lib/modules/2.4.3-ac12/kernel/drivers/char/drm/radeon.o
> > > /lib/modules/2.4.3-ac12/kernel/drivers/char/drm/radeon.o: unresolved
> > > symbol rwsem_up_write_wake
> > > /lib/modules/2.4.3-ac12/kernel/drivers/char/drm/radeon.o: unresolved
> > > symbol rwsem_down_write_failed
> >
> > Same thing with tdfx.o...
>
> "Works for me" as ever. What configuration options are you using. This sounds
> like some of the code is built with each kind of semaphore.

I'm getting the same thing here - Red Hat 7.1, amd K6/2
450 with a voodoo 3 -

After successful build and booting of 2.4.3-ac12, I found
I had no 3D acceleration, and saw error msgs similar to
those above, concerning tdfx.o.

As always, building agp and tdfx as modules.

jjs

