Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVAXWxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVAXWxR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVAXWuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:50:22 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:47513 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261712AbVAXWtX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:49:23 -0500
Subject: Re: DVD burning still have problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050124204529.GA19242@suse.de>
References: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de>
	 <5a4c581d050123125967a65cd7@mail.gmail.com> <20050124150755.GH2707@suse.de>
	 <1106594023.6154.89.camel@localhost.localdomain>
	 <20050124204529.GA19242@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106598811.6154.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 24 Jan 2005 21:44:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-24 at 20:45, Jens Axboe wrote:
> > I've got several reports like this that only happen with ACPI, and one
> > user whose burns report fine but are corrupted if ACPI is allowed to do
> > power manglement.
> 
> Really weird, I cannot begin to explain that. Perhaps the two reporters
> in this thread can try it as well?

I can sort of guess - the CPU frequency changes (either from ACPI or
perhaps also from cpuspeed if in use ?) involve the CPU disconnecting
from the bus and reconnecting. There is much magic involved in this and
there are certainly chipset and CPU errata in this area.

