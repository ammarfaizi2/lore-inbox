Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbULTIsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbULTIsL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbULTIsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:48:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43737 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261167AbULTIpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 03:45:24 -0500
Date: Mon, 20 Dec 2004 00:44:13 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
Message-ID: <20041220004413.7284f7e3@lembas.zaitcev.lan>
In-Reply-To: <20041220080951.GA24728@one-eyed-alien.net>
References: <20041220001644.GI21288@stusta.de>
	<20041220003146.GB11358@kroah.com>
	<20041220013542.GK21288@stusta.de>
	<20041219205104.5054a156@lembas.zaitcev.lan>
	<41C65EA0.7020805@osdl.org>
	<20041220062055.GA22120@one-eyed-alien.net>
	<20041219223723.3e861fc5@lembas.zaitcev.lan>
	<20041220080951.GA24728@one-eyed-alien.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004 00:09:51 -0800, Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:

> The best idea I have is to hide CONFIG_BLK_DEV_UB behind
> CONFIG_EXPERIMENTAL.

I thought about it, but I do not like CONFIG_EXPERIMENTAL as a concept.
I seem to recall a few instances when it was practically required, because
some necessary driver was covered by it, and so users ran it always-on.
AFAIK, both Fedora and Red Hat Enterprise Linux 4 Beta have it enabled
for that reason. We can try it, certainly, to see if it helps.

> The next-best idea I have is to make UB print out some sort of warning
> message at startup.

This is probably a cure worse than the disease.

-- Pete
