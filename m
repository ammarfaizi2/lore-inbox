Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUAJDES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 22:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbUAJDES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 22:04:18 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8142 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264526AbUAJDEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 22:04:16 -0500
Date: Sat, 10 Jan 2004 04:04:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [2.6 patch] improce USB Gadget Kconfig
Message-ID: <20040110030413.GN25089@fs.tum.de>
References: <20031123172356.GB16828@fs.tum.de> <3FF0F6F5.10409@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF0F6F5.10409@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

first of all sorry for my late answer.

I'm currently wading through a bunch of mails in my INBOX that should 
have been answered some time ago.  :-(


On Mon, Dec 29, 2003 at 07:54:29PM -0800, David Brownell wrote:
> Adrian Bunk wrote:
> >The patch below contains small changes to the USB Gadget Kconfig.
> >
> >The main change is that multiple modular peripheral controllers are no 
> >longer allowed (currently only one is there, but this may change).
> 
> How about using this approach instead?   It simplifies the kconfig
> for the gadget drivers by providing a boolean "which hardware"
> symbol, so gadget drivers don't need to make their own.  The symbol
> that's synthetic is the one needed only by the Makefile.
>...

Your suggestion looks fine.

> - Dave
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

