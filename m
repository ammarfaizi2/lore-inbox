Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWJBN5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWJBN5z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 09:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWJBN5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 09:57:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50356 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932342AbWJBN5x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 09:57:53 -0400
Subject: Re: [PATCH] Introduce BROKEN_ON_64BIT facility
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       chas@cmf.nrl.navy.mil, netdev@vger.kernel.org, kkeil@suse.de,
       kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       mac@melware.de, markus.lidel@shadowconnect.com, samuel@sortiz.org,
       Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org,
       Greg KH <greg@kroah.com>, thomas@winischhofer.net, ak@suse.de
In-Reply-To: <20061002045512.GA8835@havoc.gtf.org>
References: <20061002045512.GA8835@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 14:03:28 +0100
Message-Id: <1159794208.8907.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-02 am 00:55 -0400, ysgrifennodd Jeff Garzik:
> Add a broken-on-64bit option, similar to the existing broken-on-smp
> config option.  This is just the first pass, marking the obvious
> candidates.

NAK. This contains lots of stuff whcih isn't broken in the first place.

(Eg Megaraid works with 32bit config tools not 64bit ones and is
otherwise fine, ISDN is just bogus warnings now swatted)

