Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288978AbSBMVwa>; Wed, 13 Feb 2002 16:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSBMVwV>; Wed, 13 Feb 2002 16:52:21 -0500
Received: from air-2.osdl.org ([65.201.151.6]:20155 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S288978AbSBMVwE>;
	Wed, 13 Feb 2002 16:52:04 -0500
Date: Wed, 13 Feb 2002 13:52:23 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Undead code in include/linux/device.h
In-Reply-To: <20020209223925.GA13837@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0202131349590.25114-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 9 Feb 2002, Pavel Machek wrote:

> Hi!
> 
> I think you meant this code to be killed...

Yes, thank you. I do want to add some sort of semantics for devices that 
are bridges and control buses (like triggering probes and adding devices). 
But, I've not yet determined a great way to do so. In the meantime, I'll 
remove the dead references.

	-pat


