Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbVKWWIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbVKWWIc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbVKWWIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:08:32 -0500
Received: from digitalimplant.org ([64.62.235.95]:51124 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932570AbVKWWIb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:08:31 -0500
Date: Wed, 23 Nov 2005 14:08:24 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org, "" <linux-sound@vger.kernel.org>,
       "" <linux-pm@lists.osdl.org>, "" <akpm@osdl.org>
Subject: Re: [Patch 0/6] Remove Deprecated PM Interface from Obsolete Sound
 Drivers
In-Reply-To: <20051123205710.GW3963@stusta.de>
Message-ID: <Pine.LNX.4.50.0511231406340.16769-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0511231114340.14446-100000@monsoon.he.net>
 <20051123205710.GW3963@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Nov 2005, Adrian Bunk wrote:

> On Wed, Nov 23, 2005 at 12:23:25PM -0800, Patrick Mochel wrote:
> >
> > Hi there.
>
> Hi Patrick,
>
> > This is a series of 6 patches that remove the old, deprecated power
> > management interface from a variety of old OSS drivers, most of them
> > marked OBSOLETE and scheduled for removal in January 2006.
> >
> > These patches facilitate the removal of the ancient PM interface by
> > reducing the number of in-kernel users to 3:
> >
> > 	drivers/net/3c509.c
> > 	drivers/net/irda/ali-ircc.c
> > 	drivers/serial/68328serial.c
> >...
> > Does any one have any objections to these patches?
>
> I'd say the obsolete OSS drivers are the least problem, it would be more
> interesting to get the code fixed that will still be present two months
> from now.

I completely agree. I just wanted to start some place easy. :)

> Looking at the current state of 2.6.15, I doubt your patches would make
> it into Linus' tree earlier than the complete removal of the drivers.

That's a good point. I'll not worry about pushing the patches that affect
these to-be-removed drivers.

Thanks,


	Patrick

