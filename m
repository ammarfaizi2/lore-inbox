Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTLCX1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTLCX1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:27:35 -0500
Received: from ns1.skjellin.no ([80.239.42.66]:27336 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S262522AbTLCX1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:27:25 -0500
Subject: Re: Serial ATA (SATA) for Linux status report
From: Andre Tomt <lkml@tomt.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <20031203204445.GA26987@gtf.org>
References: <20031203204445.GA26987@gtf.org>
Content-Type: text/plain
Message-Id: <1070494030.15415.111.camel@slurv.pasop.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Dec 2003 00:27:10 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-03 at 21:44, Jeff Garzik wrote:
> Intel ICH5
> ----------
> Summary:  No TCQ.  Looks like a PATA controller, but with a few added,
> non-standard SATA port controls.

<snip>

> Intel ICH6 ("AHCI")
> -------------------
> Summary:  Per-device queues, full SATA control including hotplug
> and PM.

Hi jeff! :)

One question - with "including hotplug", does that mean some set hotplug
standard? Reason I'm asking is, we have a few servers from SuperMicro,
with a ICH5R S-ATA controller that claims it's supporting hotplug, but
hotplug is not in your ICH5-summary.

PS, libata works great on those systems, good work!

