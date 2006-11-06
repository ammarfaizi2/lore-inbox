Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753032AbWKFQQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbWKFQQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbWKFQQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:16:21 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:63494 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1753032AbWKFQQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:16:20 -0500
Date: Mon, 6 Nov 2006 11:16:18 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: Arjan van de Ven <arjan@infradead.org>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.18.2: lockdep warnings on rmmod ohci_hcd
In-Reply-To: <200611061833.53017.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.44L0.0611061113140.6579-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2006, Andrey Borzenkov wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Monday 06 November 2006 17:18, Arjan van de Ven wrote:
> > On Mon, 2006-11-06 at 15:46 +0300, Andrey Borzenkov wrote:
> > > I presume this is lockdep; this looks initially truncated,
> > > unfortunately this
> > > is how it was stored in messages. I will try to get more complete
> > > output ig
> > > required.
> >
> > the interesting bits are missing unfortunately (the first 10 lines or
> > so).
> >
> > Also this will be in "dmesg" if your system actually survives...
> 
> well, dmesg had exactly the same contents. Here full dmesg with increased 
> LOG_SHIFT.

I always find it rather difficult to understand the meaning of lockdep 
warnings, but this looks a bug that was fixed in 2.6.19-rc1.  The patch 
that fixed it is here:

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=115938807428103&w=2

Alan Stern

