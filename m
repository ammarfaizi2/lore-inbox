Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265555AbUBBHUV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 02:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265564AbUBBHUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 02:20:20 -0500
Received: from f17.mail.ru ([194.67.57.47]:48390 "EHLO f17.mail.ru")
	by vger.kernel.org with ESMTP id S265555AbUBBHUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 02:20:17 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Greg KH=?koi8-r?Q?=22=20?= <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module-init-tools/udev and module auto-loading
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Mon, 02 Feb 2004 10:20:15 +0300
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1AnYNT-0002Tp-00.arvidjaar-mail-ru@f17.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Hi
>> 
>> A quick question on module-init-tools/udev and module auto-loading ...
>> lets say I have a module called 'foo', that I want the kernel to
>> auto-load.
>
> Wait, stop right there.  When do you want the module autoloaded?

for legacy hardware that cannot generate any hotplug event when
connected.

Parallel port Jaz that I have. I usually have it switched off
or simply disconnected (let's leave the question of how safe is
to plug in parallel port cable aside). When I turn it on there is
no hotplug event available. Meaning

- either I have to load ppa (given current implementation)
- or initiate rescan of ppa scsi bus (if it is ever changed to new
  model)

I guess other parallel port devices share the same issue.

so there are cases when "action on access" makes sense.

regards

-andrey
