Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUF0Lnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUF0Lnb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 07:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUF0Lnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 07:43:31 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:25984 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261474AbUF0Lna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 07:43:30 -0400
Date: Sun, 27 Jun 2004 13:43:29 +0200
From: Martin Mares <mj@ucw.cz>
To: Roland Dreier <roland@topspin.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pciutils: Support for MSI-X capability
Message-ID: <20040627114329.GE670@ucw.cz>
References: <52y8mayzdy.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52y8mayzdy.fsf@topspin.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi, here is a patch to pciutils that adds parsing of MSI-X capability
> entries.  With this patch, an MSI-X capability will be dumped with -v as
> 
> 	Capabilities: [40] MSI-X: Enable- Mask- TabSize=32
> 
> and with -vv as
> 
> 	Capabilities: [40] MSI-X: Enable- Mask- TabSize=32
> 		Vector table: BAR=0 offset=00082000
> 		PBA: BAR=0 offset=00082200
> 
> Please let me know if you need any changes/fixes before you can apply.

Applied and will appear in -test6 soon.

Could you please add a couple of comments to the capability defines in header.h?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Q: Do you believe in One God? A: Yes, up to isomorphism.
