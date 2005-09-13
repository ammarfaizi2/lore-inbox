Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVIMDUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVIMDUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 23:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVIMDUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 23:20:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:59795 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932288AbVIMDUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 23:20:24 -0400
From: Andi Kleen <ak@suse.de>
To: Bart Hartgers <bart@etpmod.phys.tue.nl>
Subject: Re: [1/3] Add 4GB DMA32 zone
Date: Tue, 13 Sep 2005 05:20:37 +0200
User-Agent: KMail/1.8
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <43246267.mailL4R11PXCB@suse.de> <4325C67C.7070809@pobox.com> <4325FAE7.6030501@etpmod.phys.tue.nl>
In-Reply-To: <4325FAE7.6030501@etpmod.phys.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509130520.38712.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 September 2005 00:02, Bart Hartgers wrote:

> Yep. You're absolutely right about the card. Google doesn't find anyone
> still selling them, though... Apart from ebay ;-)
>
> (Wrote the driver and got rid of the d*mn thing 2 weeks later...)

Just to avoid any misconceptions - it should just work great on x86-64
because exactly for such hardware we kept the 16MB DMA zone.
(unless of course the driver has other problems than just DMAing) 

-Andi
