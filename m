Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWBDN7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWBDN7K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 08:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWBDN7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 08:59:09 -0500
Received: from rtr.ca ([64.26.128.89]:17092 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932251AbWBDN7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 08:59:08 -0500
Message-ID: <43E4B2C3.3040109@rtr.ca>
Date: Sat, 04 Feb 2006 08:57:23 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Ulrich Mueller <ulm@kph.uni-mainz.de>,
       Herbert Poetzl <herbert@13thfloor.at>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
References: <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3E9C2.1000309@rtr.ca> <20060110173217.GU3389@suse.de> <43C3F0CA.10205@rtr.ca> <43C403BA.1050106@pobox.com> <43C40803.2000106@rtr.ca> <20060201222314.GA26081@MAIL.13thfloor.at> <uhd7irpi7@a1i15.kph.uni-mainz.de> <Pine.LNX.4.61.0602022144190.30391@yvahk01.tjqt.qr> <43E3DB99.9020604@rtr.ca> <Pine.LNX.4.61.0602041204490.30014@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602041204490.30014@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>
> What userspace programs do depend on it?

That *is* the question, isn't it.
We simply don't know, other than that this is
a visible change to any program that cares.

Gratuitis breakage of userspace is pointless.

Empirically speaking, everything I use is working fine
here with the 2G/2G split, but that's just not good enough
reason to mindlessly break other people's userspace.

Cheers
