Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422823AbWJYXhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422823AbWJYXhS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 19:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422817AbWJYXhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 19:37:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30369 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422823AbWJYXhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 19:37:16 -0400
Subject: Re: [BUG] DMA timeout errors on Dell Latitude XPi CD P150ST
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Panagiotis Issaris <takis.issaris@uhasselt.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <loom.20061025T111524-521@post.gmane.org>
References: <ae7121c60610240805l6f244bf5vdad31d6fd17e10f7@mail.gmail.com>
	 <loom.20061025T111524-521@post.gmane.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Oct 2006 00:40:28 +0100
Message-Id: <1161819628.7615.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-25 am 09:24 +0000, ysgrifennodd Panagiotis Issaris:
> I would guess it would be enough to remove the PCI_DEVICE_ID_CMD_643 and let it
> be handled by the default case, thus disabling DMA. I will try the attached
> patch on my friends laptop as soon as he brings it along.

This has nothing to do with whether DMA is enabled and is wrong. The
decision about whether to honour BIOS DMA settings is a config option
and has been for years.

If this specific laptop does need not to use DMA, and Win*** also shows
the same behaviour then we can certainly add it to a list of some kind,
OTOH if windows DMA works I'd like to know -why-

Alan

