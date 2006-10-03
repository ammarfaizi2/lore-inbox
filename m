Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWJCP2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWJCP2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWJCP2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:28:31 -0400
Received: from xenotime.net ([66.160.160.81]:26568 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030220AbWJCP2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:28:30 -0400
Date: Tue, 3 Oct 2006 08:29:50 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: "Miguel Ojeda" <maxextreme@gmail.com>
Cc: andrew.j.wade@gmail.com, akpm@osdl.org,
       "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 V7] drivers: add lcd display support
Message-Id: <20061003082950.25a0e898.rdunlap@xenotime.net>
In-Reply-To: <653402b90610030555h2536b04bs3603d95635b93ca7@mail.gmail.com>
References: <20060930232445.59e8adf6.maxextreme@gmail.com>
	<200610021449.08640.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	<653402b90610021440h2e416394r55227ce5e7eb6171@mail.gmail.com>
	<200610022006.45806.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	<653402b90610030555h2536b04bs3603d95635b93ca7@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 14:55:07 +0200 Miguel Ojeda wrote:

> On 10/3/06, Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> >
> > I'm afraid not; it looks like my suggestion "LCD display" grates on
> > people's ears. Simply calling the device an "LCD" is probably the
> > best bet, and "LCD screen" would be better than "LCD monitor". Screens
> > can be any size, it's a fairly generic term.
> >
> > The class name and directory name should probably include the word
> > "display", but I don't know what the other part should be. What sort
> > of displays should be included in this category, and what sort
> > shouldn't?
> >
> > Andrew Wade
> >
> 
> My first idea was call it "display", for small/medium screens of any
> kind (LCD, OLED, FED, NED... whatever). I named it "drivers/display/",
> so anyone who create a driver for a display or display controller can
> put it there (creating a separator for its own category at Kconfig),
> as there aren't so many of them for now.
> 
> But people said "display" could be so generic and cause confusion with
> usual video drivers, so I renamed it to "drivers/lcddisplay/", as it
> is more expressive (however when someone will create a OLED driver
> will have to create a new folder...).
> 
> I would like to put any kind of display driver there (LCD, OLED...)
> not just LCDs and name it "drivers/display". I think people won't
> confuse them with VESA... as there aren't drivers for "screens", just
> for video cards (logically). But some people don't agree.

I liked the "auxdisplay" suggestion, FWIW.

---
~Randy
