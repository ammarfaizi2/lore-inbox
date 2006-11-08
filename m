Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932748AbWKHVVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932748AbWKHVVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWKHVVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:21:11 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:64668 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932748AbWKHVVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:21:10 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: S2RAM and PCI quirks
Date: Wed, 8 Nov 2006 22:18:54 +0100
User-Agent: KMail/1.9.1
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.osdl.org>
References: <1163000705.23956.18.camel@localhost.localdomain> <1163000924.3138.342.camel@laptopd505.fenrus.org> <1163001711.23956.30.camel@localhost.localdomain>
In-Reply-To: <1163001711.23956.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611082218.55052.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 8 November 2006 17:01, Alan Cox wrote:
> Ar Mer, 2006-11-08 am 16:48 +0100, ysgrifennodd Arjan van de Ven:
> > at the same time I'm not 100% convinced it's ok to always run all quirks
> > at resume, for one the difference is that there now is a driver active
> > owning the device... Almost sounds like having a per quirk flag stating
> > "run at resume" is needed ;-(
> 
> We probably need a quirk class for resume in this situation. The kind of
> things that worry me if we are not doing the quirk handling, and what I
> suspect happened in the case I looked at are that chipset bug
> workarounds did not get restored, and in this case the older VIA chipset
> involved then corrupted DMA streams and trashed the users disk.

Now that would explain why many boxes resume from disk correctly, but don't
resume from RAM by any means.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
