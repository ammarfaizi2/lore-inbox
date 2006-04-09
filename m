Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWDIGzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWDIGzf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 02:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWDIGzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 02:55:35 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:31111 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751416AbWDIGze
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 02:55:34 -0400
Subject: Re: SDIO Drivers?
From: Marcel Holtmann <marcel@holtmann.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Ram <vshrirama@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <443628F3.9050107@drzeus.cx>
References: <8bf247760604040130n155eeffauc5798750f8357bca@mail.gmail.com>
	 <443628F3.9050107@drzeus.cx>
Content-Type: text/plain
Date: Sun, 09 Apr 2006 08:55:53 +0200
Message-Id: <1144565753.2633.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

> >    3)  Is it a generic driver ?. (Same for a set of devices) or
> > different for each device?
> >         Suppose i want to run an SDIO WLAN Card?. will the
> > manufacturer support it or
> >        an will a Generic Driver "drive" it?

for WiFi this is unlikely, but for Bluetooth there exists an open
standard on how to access Bluetooth cards. So the easiest way might be
to use a Bluetooth SDIO device to build the driver model.

> >    6) Are there any sample/Open Source SDIO drivers available in Linux
> > Kernel or else where?.If, not when can one expect/is anyone working on
> > it currently?.
> 
> There are a lot of people interested, but I haven't seen anyone working
> on it yet.

This includes me and I finally have a SDHCI capable laptop and one of
the Bluetooth SDIO cards. However my time is so limited at the moment,
that I haven't looked at it.

Regards

Marcel


