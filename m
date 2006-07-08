Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWGHHfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWGHHfV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 03:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWGHHfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 03:35:21 -0400
Received: from mail.gmx.net ([213.165.64.21]:39587 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750901AbWGHHfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 03:35:20 -0400
X-Authenticated: #14349625
Subject: Re: Opinions on removing /proc/tty?
From: Mike Galbraith <efault@gmx.de>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <9e4733910607071956q284a2173rfcdb2cfe4efb62b4@mail.gmail.com>
References: <9e4733910607071956q284a2173rfcdb2cfe4efb62b4@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 09:40:52 +0200
Message-Id: <1152344452.7922.11.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 22:56 -0400, Jon Smirl wrote:
> Does anyone use the info in /proc/tty? The hard coded device names
> aren't compatible with udev's ability to rename things.
> 
> There also doesn't appear to be any useful info in the drivers portion
> that isn't already available in sysfs. I can add some code to make a
> list of registered line disciplines appear in sysfs.
> 
> Does anyone have a problem with deleting /proc/tty if ldisc enum
> support is added to sysfs?

ps uses /proc/tty/drivers, so some coordination would be needed.

	-Mike

