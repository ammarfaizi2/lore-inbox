Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVBBQsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVBBQsN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVBBQou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:44:50 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:40344 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262601AbVBBQkb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 11:40:31 -0500
Subject: Re: Patch to add usbmon
From: Marcel Holtmann <marcel@holtmann.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050201215936.029be631@localhost.localdomain>
References: <20050131212903.6e3a35e5@localhost.localdomain>
	 <20050201071000.GF20783@kroah.com>
	 <20050201003218.478f031e@localhost.localdomain>
	 <1107256383.9652.26.camel@pegasus>
	 <20050201095526.0ee2e0f4@localhost.localdomain>
	 <1107293870.9652.76.camel@pegasus>
	 <20050201215936.029be631@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 17:40:17 +0100
Message-Id: <1107362417.11944.7.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pete,

> > I think if cat is the prefered tool for viewing this file then it should
> > be more human readable. If not, then a binary format should be choosen.
> > Maybe we can implement both. Is this possible?
> 
> Yes. Now you know why files were split as they were.

still no reason for me to split things up.

> > > But if you or someone else were to hack on something like usbdump(1),
> > > it would be peachy, I think.
> > 
> > I can start with usbdump if we agree on an interface. I personally would
> > prefer a binary interface for that.
> 
> If you want to start scoping it, it's fine by me. I was going to concentrate
> on fixing what's needed first, such as getting control setup packets captured
> and things like that.

While I am really thinking about starting usbdump, I may ask why you
have choosen to use debugfs as interface. This will not be available in
normal distribution kernels and I think a general USB monitoring ability
would be great. For example like we have it for Ethernet, Bluetooth and
IrDA. So my idea is to create some /dev/usbmonX (for each bus one) where
usbdump can read its information from. What do you think?

Regards

Marcel


