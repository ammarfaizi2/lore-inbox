Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261355AbSJPUJQ>; Wed, 16 Oct 2002 16:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbSJPUJQ>; Wed, 16 Oct 2002 16:09:16 -0400
Received: from [195.39.17.254] ([195.39.17.254]:772 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261355AbSJPUJP>;
	Wed, 16 Oct 2002 16:09:15 -0400
Date: Wed, 16 Oct 2002 10:01:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: ebiederm@xmission.com, eblade@blackmagik.dynup.net,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Message-ID: <20021016080135.GA4562@zaurus>
References: <200210141841.LAA19982@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210141841.LAA19982@baldur.yggdrasil.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> >Resetting the cpu != resetting the system.  And the keyboard controller
> >only does a cpu level reset.  Which is basically a convoluted way to jump
> >to: 0xfffffff0.
> 
> 	I would be quite surprised if that reset was not wired
> to eventually ground RST# on the PCI bus.

Surprise for you, then. That reset was used to return to
real mode by win31 & similar. Resetting PCI would
screw that.
				PavelEnd_of_mail_magic_4669
