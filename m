Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbRJCQBj>; Wed, 3 Oct 2001 12:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276434AbRJCQB3>; Wed, 3 Oct 2001 12:01:29 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:4792 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S276424AbRJCQBQ>;
	Wed, 3 Oct 2001 12:01:16 -0400
Date: Wed, 3 Oct 2001 11:58:57 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ben Greear <greearb@candelatech.com>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <3BBB31F4.C223E12E@candelatech.com>
Message-ID: <Pine.GSO.4.30.0110031157140.4833-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Oct 2001, Ben Greear wrote:

> jamal wrote:
>
> > No. NAPI is for any type of network activities not just for routers or
> > sniffers. It works just fine with servers. What do you see in there that
> > will make it not work with servers?
>
> Will NAPI patch, as it sits today, fix all IRQ lockup problems for
> all drivers (as Ingo's patch claims to do), or will it just fix
> drivers (eepro, tulip) that have been integrated with it?

Unfortunately amongst the three of us tulip seemed to be the most common.
Robert has a gige intel. So patches appear only for those two drivers. I
could write up a document on how to change drivers.

cheers,
jamal

