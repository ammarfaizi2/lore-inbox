Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVAXUpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVAXUpG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVAXUoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:44:07 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:8600 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261622AbVAXUmN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:42:13 -0500
Subject: Re: DVD burning still have problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050124150755.GH2707@suse.de>
References: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de>
	 <5a4c581d050123125967a65cd7@mail.gmail.com> <20050124150755.GH2707@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106594023.6154.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 24 Jan 2005 19:37:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-24 at 15:07, Jens Axboe wrote:
> >  794034176/4572807168 (17.4%) @2.4x, remaining 18:47
> >  805339136/4572807168 (17.6%) @2.4x, remaining 18:42
> > :-[ WRITE@LBA=60eb0h failed with SK=3h/ASC=0Ch/ACQ=00h]: Input/output error
> > builtin_dd: 396976*2KB out @ average 2.4x1385KBps
> > :-( write failed: Input/output error
> 
> As with the original report, the drive is sending back a write error to
> the issuer. Looks like bad media.

I've got several reports like this that only happen with ACPI, and one
user whose burns report fine but are corrupted if ACPI is allowed to do
power manglement.

