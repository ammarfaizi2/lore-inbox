Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbUCENUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 08:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbUCENUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 08:20:45 -0500
Received: from smtp-out.girce.epro.fr ([195.6.195.146]:560 "EHLO
	srvsec2.girce.epro.fr") by vger.kernel.org with ESMTP
	id S262590AbUCENUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 08:20:41 -0500
Message-ID: <299601c402b3$e4f4da70$3cc8a8c0@epro.dom>
From: "Colin Leroy" <colin@colino.net>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Linux Kernel list" <linux-kernel@vger.kernel.org>
References: <20040304152840.GL2708@suse.de> <20040305130803.0c01ee83@jack.colino.net> <20040305122151.GL10923@suse.de>
Subject: Re: [PATCH] 2.6 ide-cd DMA ripping
Date: Fri, 5 Mar 2004 14:15:12 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > Works (on ppc, ibook G4 here). It's indeed faster. But, it breaks
direct
> > output to dsp (as in `cdparanoia 1 /dev/dsp`).
>
> How do you know it works, then? cdparanoia should receive identical
> data, otherwise it sounds like it doesn't work.

Well, using 'mplayer cdda.wav' works.

> Dump a track without the patch, repeat with the patch, and compare the
> images.

With or without the patch, that's the exact same file resulting. Maybe the
fact that it doesn't work anymore with /dev/dsp isn't due to your patch
but to something else (I hadn't tried that since a while). I'll report
again as soon as i'll be in front of my laptop.

> (BTW, please cc recipients on lkml. At least to me, otherwise I may not
> see your message for days).

Yup, sorry, I'm not subscribed so created a new mail, and forgot this.

Thanks,
-- 
Colin
  This message represents the official view of the voices
  in my head.

