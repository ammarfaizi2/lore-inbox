Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWDVTZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWDVTZa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWDVTZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:25:29 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30983 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751048AbWDVTZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:25:27 -0400
Date: Thu, 20 Apr 2006 22:07:31 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Martin Mares <mj@ucw.cz>, Matthew Garrett <mjg59@srcf.ucam.org>,
       "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060420220731.GF2352@ucw.cz>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com> <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <mj+md-20060420.165714.18107.albireo@ucw.cz> <4447C020.3010003@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4447C020.3010003@linux.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 20-04-06 21:08:48, Alexey Starikovskiy wrote:
> Martin Mares wrote:
> >Hello!
> >
> >>Generic application does not need to know if power, 
> >>sleep, or lid button is pressed, so you will need to 
> >>intercept them from input stream... I cannot find any 
> >>reason to mix these buttons into input, do you?
> >
> >Neither does a generic application need to know if the 
> >NumLock key is just
> >pressed. This doesn't mean anything.
> >
> >I don't see any reason for treating some keys or buttons 
> >differently.
> >A key is just a key.

> There is one special key anyway -- reset...

Your point is? There's also hardware power button on many machines.
They are not controllable by software => they are not relevant to this
discussion.
								Pavel

-- 
Thanks, Sharp!
