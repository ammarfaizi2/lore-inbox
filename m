Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265563AbUAZHT5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 02:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265564AbUAZHT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 02:19:57 -0500
Received: from gprs40-10.eurotel.cz ([160.218.40.10]:53592 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265563AbUAZHT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 02:19:56 -0500
Date: Mon, 26 Jan 2004 08:19:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Rik van Riel <riel@redhat.com>, Valdis.Kletnieks@vt.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sched-idle and disk-priorities for 2.6.X
Message-ID: <20040126071945.GA208@elf.ucw.cz>
References: <20040117232926.GC9999@elf.ucw.cz> <Pine.LNX.4.44.0401181346480.28955-100000@chimarrao.boston.redhat.com> <40147637.20806@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40147637.20806@tmr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Is there effective way to limit RSS?
> >
> >
> >Want me to port the RSS stuff from 2.4-rmap to 2.6 ?
> 
> What's the effort? It's useful for programs which use a lot of memory, 
> particularly for those which only do it on some data sets. It would 
> certainly act as a safty net.

If you have two apps which oth need lots of memory, and want to
"renice" one to run slower.

Alternatively when you have one app eating a lots of memory and you
want your system to remain usable.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
