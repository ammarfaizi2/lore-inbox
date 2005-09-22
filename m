Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbVIVNvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbVIVNvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbVIVNvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:51:48 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:15010 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030343AbVIVNvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:51:48 -0400
Subject: Re: SATA suspend-to-ram patch - merge?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Joshua Kwan <joshk@triplehelix.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050922061849.GJ7929@suse.de>
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com>
	 <20050922061849.GJ7929@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Sep 2005 15:17:59 +0100
Message-Id: <1127398679.18840.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-22 at 08:18 +0200, Jens Axboe wrote:
> > So currently we are in limbo...
> 
> Which is a shame, since it means that software suspend on sata is
> basically impossible :)

Not really, everyone on the planet who cares is using the existing patch
and that just works. If the SCSI folks can't fix the SCSI layer to do
power management then the scsi drivers just need to not provide pm
methods until they catch up.

Blocking SATA suspend which people need for SCSI suspend which is
utterly obscure and weird is pointless, as pretty much ever vendor
except Red Hat has already decided.

Alan
