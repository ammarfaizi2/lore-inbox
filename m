Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263965AbTLUTXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 14:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTLUTXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 14:23:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41624 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263965AbTLUTXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 14:23:40 -0500
Date: Sun, 21 Dec 2003 20:23:38 +0100
From: Jens Axboe <axboe@suse.de>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
Message-ID: <20031221192338.GW2069@suse.de>
References: <1071864709.1044.172.camel@localhost> <1071885178.1044.227.camel@localhost> <3FE3B61C.4070204@cyberone.com.au> <200312201355.08116.kernel@kolivas.org> <1071891168.1044.256.camel@localhost> <3FE3C6FC.7050401@cyberone.com.au> <20031220222034.GA2040@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031220222034.GA2040@merlin.emma.line.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 20 2003, Matthias Andree wrote:
> On Sat, 20 Dec 2003, Nick Piggin wrote:
> 
> > >/dev/hda:
> > >multcount    =  0 (off)
> > >IO_support   =  0 (default 16-bit)
> > >unmaskirq    =  0 (off)
> > >using_dma    =  1 (on)
> > >keepsettings =  0 (off)
> > >readonly     =  0 (off)
> > >readahead    = 256 (on)
> > >geometry     = 65535/16/63, sectors = 117210240, start = 0
> > >
> > 
> > This might be a problem - try turning unmaskirq on, and possibly
> > 32-bit IO support on (hdparm -u1 -c1 /dev/hda). I think there is
> > a remote possibility that doing this will corrupt your data just
> 
> Does 32-bit I/O support make a difference for DMA transfers at all or
> just for PIO?

It's just for PIO.

-- 
Jens Axboe

