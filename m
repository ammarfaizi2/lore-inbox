Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWIZPSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWIZPSl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWIZPSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:18:41 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:16809 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932106AbWIZPSk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:18:40 -0400
Subject: Re: [PATCH 26/47] Driver core: add groups support to struct device
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060926134654.GB11435@kroah.com>
References: <11592491371254-git-send-email-greg@kroah.com>
	 <1159249140339-git-send-email-greg@kroah.com>
	 <11592491451786-git-send-email-greg@kroah.com>
	 <11592491482560-git-send-email-greg@kroah.com>
	 <11592491551919-git-send-email-greg@kroah.com>
	 <11592491581007-git-send-email-greg@kroah.com>
	 <11592491611339-git-send-email-greg@kroah.com>
	 <11592491643725-git-send-email-greg@kroah.com>
	 <11592491672052-git-send-email-greg@kroah.com>
	 <d120d5000609260620me5cf24bw83fc6d65fa7cb232@mail.gmail.com>
	 <20060926134654.GB11435@kroah.com>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 17:18:57 +0200
Message-Id: <1159283937.800.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > I really disappointed that there was no discussion/review of the
> > implementation at all.
> 
> There has not been any real implementation yet, only a few patches added
> to the core that add a few extra functionality to struct device to allow
> class_device to move that way.  The patches that move the subsystems
> over will be discussed (and some already have, like networking), when
> they are ready.  Right now most of that work is being done by Kay and
> myself as a proof of concept to make sure that we can do this properly
> and that userspace can handle it well.

if you look at the Bluetooth subsystem, it became real devices in the
2.6.18 release. I was using a platform device for the virtual and UART
based adapters with no parent, but I am gonna change this to the virtual
devices once it is upstream. It works beautiful and the /sys/class is
now only a fast entry point to find the devices.

Regards

Marcel


