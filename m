Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWBDKfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWBDKfY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 05:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWBDKfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 05:35:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54376 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751196AbWBDKfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 05:35:23 -0500
Date: Sat, 4 Feb 2006 11:36:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Ulrich Mueller <ulm@kph.uni-mainz.de>,
       Herbert Poetzl <herbert@13thfloor.at>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
Message-ID: <20060204103601.GA5010@suse.de>
References: <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3E9C2.1000309@rtr.ca> <20060110173217.GU3389@suse.de> <43C3F0CA.10205@rtr.ca> <43C403BA.1050106@pobox.com> <43C40803.2000106@rtr.ca> <20060201222314.GA26081@MAIL.13thfloor.at> <uhd7irpi7@a1i15.kph.uni-mainz.de> <Pine.LNX.4.61.0602022144190.30391@yvahk01.tjqt.qr> <43E3DB99.9020604@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E3DB99.9020604@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03 2006, Mark Lord wrote:
> >Maybe something like:
> >        config VMSPLIT_1G
> >                bool "1G/3G user/kernel split"
> >        config VMSPLIT_X
> >                bool "Manual split"
> >endchoice
> ...
> 
> Yes, that looks like a good idea.

Sounds like a huge mess to me. The manual kernel buffer size
configuration was bad enough, and this is much trickier. People have
enough problems even understanding what the option does, lets please
leave it as is with a few select options.

-- 
Jens Axboe

