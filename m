Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbSJURDz>; Mon, 21 Oct 2002 13:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261531AbSJURDz>; Mon, 21 Oct 2002 13:03:55 -0400
Received: from air-2.osdl.org ([65.172.181.6]:47744 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261525AbSJURDy>;
	Mon, 21 Oct 2002 13:03:54 -0400
Date: Mon, 21 Oct 2002 10:13:12 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>,
       <eblade@blackmagik.dynup.net>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend
 devices
In-Reply-To: <m18z0swtnr.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44.0210211011060.963-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Question, is there a method from the class shutdown code that we
> can/should call, during reboot.  I just have this memory that for
> network interfaces simply downing the interface tends to put it in
> a quiescent state.  And I am wondering if that might be a general
> thing we can take advantage of.  Though if the class remove methods
> modify the data structures I guess that is out.

No. Bringing down the network interface, at least, can be done from
userspace.

	-pat

