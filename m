Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312495AbSDOMEm>; Mon, 15 Apr 2002 08:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312526AbSDOMEl>; Mon, 15 Apr 2002 08:04:41 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:60166 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S312495AbSDOMEk>; Mon, 15 Apr 2002 08:04:40 -0400
Date: Mon, 15 Apr 2002 14:04:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Jens Axboe <axboe@suse.de>
cc: "Ivan G." <ivangurdiev@yahoo.com>, Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 compile bugs
In-Reply-To: <20020415115131.GN12608@suse.de>
Message-ID: <Pine.LNX.4.21.0204151356070.26237-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 15 Apr 2002, Jens Axboe wrote:

> > That's not enough, some archs don't define pci_alloc_consistent/
> > pci_free_consistent, because they have neither PCI nor ISA.
> 
> Please, then those archs need to provide similar functionality. This is
> the established api, unless you want to change the documentation and xxx
> number of drivers?

These functions are only specified for PCI/ISA and there was no need so
far to implement them. It's no problem to provide the functionality, but I
have to know with what API.

bye, Roman

