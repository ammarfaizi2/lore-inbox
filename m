Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267897AbUHEWMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267897AbUHEWMG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 18:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268006AbUHEWGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 18:06:55 -0400
Received: from the-village.bc.nu ([81.2.110.252]:21695 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268004AbUHEWE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 18:04:56 -0400
Subject: Re: ide-cd problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Bill Davidsen <davidsen@tmr.com>, Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040805193520.GA7571@suse.de>
References: <20040803055337.GA23504@suse.de> <41128070.5050109@tmr.com>
	 <20040805193520.GA7571@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091739746.8419.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 Aug 2004 22:02:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-05 at 20:35, Jens Axboe wrote:
> > exotic commands, and given the choice of having users able to send 
> > arbitrary commands to the device and not access it at all, I would say 
> > "not at all" would be good.
> 
> Then don't make your cdrom device accesable.

Lets get rid of root, I mean you don't need root, you could just turn
your computer off.

What planet are you living on Jens ?

End users have lots of reasons for being able to access /dev/cdrom
directly and also often for groups of users to access a disk directly
(for example Oracle databases).

That means any security model that isn't based around things beyond
basic device access is flawed.

> Affects all devices that accept SG_IO.

Then if you refuse to fix SG_IO perhaps all device drivers should remove
support for it ?

