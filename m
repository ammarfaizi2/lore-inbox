Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUCaBeK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 20:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbUCaBeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 20:34:10 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12755 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261170AbUCaBeH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 20:34:07 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Zdenek Tlusty <tlusty@vse.cz>
Subject: Re: via 6420 pata/sata controller
Date: Tue, 30 Mar 2004 17:28:47 +0200
User-Agent: KMail/1.5.3
References: <200403301524.26360.tlusty@vse.cz>
In-Reply-To: <200403301524.26360.tlusty@vse.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403301728.47494.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 of March 2004 15:24, Zdenek Tlusty wrote:
> hello,
>
> I have problem with via 6420 controller under linux (I have mandrake 9.1
> with kernel 2.4.25 with libata patch version 16).
> This controller has two sata and one pata channels. Sata channel works fine
> with libata. My problem is with pata channel. I have pata hard disk on this
> controller. Bios of the controller detected this disk but linux did not.
> What is the current status of the driver for this controller?
> Thank you for your time.

There are some patches floating around adding support for VT6410
(not VT6420) to generic IDE PCI driver.  This controller may also work
with generic IDE PCI driver (PCI VendorID/ProductID needs to be added
to drivers/ide/pci/generic.h and drivers/ide/pci/generic.c).


http://www.viaarena.com/?PageID=186

"VIA want to make available code and other resources to appropriate open
source developers.  The VIA Open Source Developer's portal currently accepts
requests for IDE and Networking development as well as the CLE266 display
adaptor."

Unfortunately it seems I'm not "appropriate" enough as I didn't get any reply.
:/

BTW Does anybody has contacts in VIA?

Regards,
Bartlomiej

