Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVAXUwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVAXUwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVAXUsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:48:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9181 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261632AbVAXUph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:45:37 -0500
Date: Mon, 24 Jan 2005 21:45:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DVD burning still have problems
Message-ID: <20050124204529.GA19242@suse.de>
References: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de> <5a4c581d050123125967a65cd7@mail.gmail.com> <20050124150755.GH2707@suse.de> <1106594023.6154.89.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106594023.6154.89.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2005, Alan Cox wrote:
> On Llu, 2005-01-24 at 15:07, Jens Axboe wrote:
> > >  794034176/4572807168 (17.4%) @2.4x, remaining 18:47
> > >  805339136/4572807168 (17.6%) @2.4x, remaining 18:42
> > > :-[ WRITE@LBA=60eb0h failed with SK=3h/ASC=0Ch/ACQ=00h]: Input/output error
> > > builtin_dd: 396976*2KB out @ average 2.4x1385KBps
> > > :-( write failed: Input/output error
> > 
> > As with the original report, the drive is sending back a write error to
> > the issuer. Looks like bad media.
> 
> I've got several reports like this that only happen with ACPI, and one
> user whose burns report fine but are corrupted if ACPI is allowed to do
> power manglement.

Really weird, I cannot begin to explain that. Perhaps the two reporters
in this thread can try it as well?

-- 
Jens Axboe

