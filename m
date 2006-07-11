Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWGKUBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWGKUBa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWGKUBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:01:30 -0400
Received: from thunk.org ([69.25.196.29]:3220 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932115AbWGKUB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:01:29 -0400
Date: Tue, 11 Jul 2006 16:01:00 -0400
From: Theodore Tso <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Olaf Hering <olh@suse.de>,
       Jeff Garzik <jeff@garzik.org>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, klibc@zytor.com,
       linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060711200100.GA9040@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Olaf Hering <olh@suse.de>,
	Jeff Garzik <jeff@garzik.org>, Michael Tokarev <mjt@tls.msk.ru>,
	Roman Zippel <zippel@linux-m68k.org>, klibc@zytor.com,
	linux-kernel@vger.kernel.org
References: <20060711173030.GA16693@suse.de> <44B3E40E.2090306@zytor.com> <20060711180126.GB16869@suse.de> <44B3E814.3060004@zytor.com> <20060711181055.GC16869@suse.de> <44B3EB28.1050007@zytor.com> <20060711191548.GA17585@suse.de> <Pine.LNX.4.64.0607111226320.5623@g5.osdl.org> <44B3FE34.9000704@zytor.com> <Pine.LNX.4.64.0607111249380.5623@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607111249380.5623@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 12:51:31PM -0700, Linus Torvalds wrote:
> On Tue, 11 Jul 2006, H. Peter Anvin wrote:
> > 
> > Does that mean "in kernel space", "in the kernel distribution" or "in memory
> > completely under the control by the kernel?"  That is really what this is
> > about.
> 
> I think it's all about kernel space.
> 
> Moving the default parsing to user space would add exactly _zero_ 
> advantage, and would add totally unnecessary complexity (ie now we need to 
> make sure that hotplug does it right - and the hotplug routines suddenly 
> change between the boot phase and the actual install).

While you're at it, do you think you'd be willing to opine about doing
whether it makes sense to chuck out the guts of suspend-to-disk so
that it must be done in userspace?  

						- Ted
