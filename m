Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbUBHK5L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 05:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUBHK5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 05:57:11 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:897 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263310AbUBHK5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 05:57:08 -0500
Date: Sun, 8 Feb 2004 11:06:40 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402081106.i18B6e2X000889@81-2-122-30.bradfords.org.uk>
To: Eduard Bloch <edi@gmx.de>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040208101557.GA25053@zombie.inka.de>
References: <200402031635.i13GZJ9Q002866@81-2-122-30.bradfords.org.uk>
 <20040203174606.GG3967@aurora.fi.muni.cz>
 <200402031853.i13Ir1e0003202@81-2-122-30.bradfords.org.uk>
 <yw1xn080m1d2.fsf@kth.se>
 <Pine.LNX.4.53.0402031509100.32547@chaos>
 <20040203224021.GK11683@suse.de>
 <1075849526.11322.9.camel@nosferatu.lan>
 <200402040737.i147bJqq000455@81-2-122-30.bradfords.org.uk>
 <20040205233113.GA10254@zombie.inka.de>
 <200402060758.i167whxX000498@81-2-122-30.bradfords.org.uk>
 <20040208101557.GA25053@zombie.inka.de>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Eduard Bloch <edi@gmx.de>:
> Moin John!
> John Bradford schrieb am Friday, den 06. February 2004:
> 
> > > > unmounted before an erase, when it is re-mounted, the stale data is
> > > > read from the device's own cache, which should have been invalidated
> > > > by the erase.
> > > 
> > > Is it realy a hardware issue?
> > 
> > I originally thought so, but maybe I was wrong.  Jens posted a patch
> > to invalidate kernel buffers on an umount - if the problem persists
> > with that patch, I still believe it is a hardware fault.
> 
> And I don't. One of the cdrtools Debian maintainers just wrote that the
> patch does NOT solve the problem with the scenario described above in
> the thread.

So if the device does cache stale data over an erase, do you think
that's not a hardware fault?

John.
