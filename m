Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269010AbTCASsA>; Sat, 1 Mar 2003 13:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269011AbTCASsA>; Sat, 1 Mar 2003 13:48:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29195 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269010AbTCASr7>; Sat, 1 Mar 2003 13:47:59 -0500
Date: Sat, 1 Mar 2003 10:55:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.63
In-Reply-To: <20030228235947.GA29946@kroah.com>
Message-ID: <Pine.LNX.4.44.0303011053310.16800-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Feb 2003, Greg KH wrote:
> 
> I've merged with your latest tree again, and it's available at the above
> place.  Could you please pull these changes?

This causes

	drivers/built-in.o(.text+0xedc7e): In function `cb_free':
	: undefined reference to `pci_remove_device'
	make: *** [.tmp_vmlinux1] Error 1

Ehh?

		Linus

