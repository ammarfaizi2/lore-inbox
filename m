Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbTE0XLL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 19:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbTE0XLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 19:11:11 -0400
Received: from [64.35.99.205] ([64.35.99.205]:51210 "EHLO www.theshore.net")
	by vger.kernel.org with ESMTP id S264430AbTE0XLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 19:11:10 -0400
Message-ID: <007601c324a7$5ce73320$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
To: "Marc-Christian Petersen" <m.c.p@wolk-project.de>
Cc: <linux-kernel@vger.kernel.org>, "manish" <manish@storadinc.com>,
       "Carl-Daniel Hailfinger" <c-d.hailfinger.kernel.2003@gmx.net>,
       "Andrea Arcangeli" <andrea@suse.de>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>,
       "Christian Klose" <christian.klose@freenet.de>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Georg Nikodym" <georgn@somanetworks.com>
References: <3ED2DE86.2070406@storadinc.com><3ED3A2AB.3030907@gmx.net><3ED3A55E.8080807@storadinc.com><200305271954.11635.m.c.p@wolk-project.de> <20030527190628.779eda78.georgn@somanetworks.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Tue, 27 May 2003 18:26:10 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4920.2300
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ALL: Anyone who has this kind of pauses/stops/mouse is dead/keyboard
> is dead/:  speak _NOW_ please, doesn't matter who you are!

I've been able to reproduce the pauses on two different machines/mb/processor,
although each machine has >= 2.5GB ram.  I can reproduce this in 2.4.19, 2.4.20,
and the 2.4.21-rc1/rc2/rc3.

After the machine un-pauses, everything completes/returns to normal.  I don't
experience deadlocked processes.

Both my machines are IDE, using UDMA, hdparam stuff is maxxed; messing with
bdflush, elvtune doesn't make any difference.  Limiting the ram on the machines
didn't help.

Pauses have lasted anywhere from a few seconds to a few minutes. Anything later
than 2.4.18 is unusable for me because of this.

-Chris


