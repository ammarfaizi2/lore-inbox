Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUIWQHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUIWQHt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUIWQHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:07:48 -0400
Received: from mail-3-bnl.tiscali.it ([213.205.33.223]:32859 "EHLO
	mail-3-bnl.tiscali.it") by vger.kernel.org with ESMTP
	id S266319AbUIWQDw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:03:52 -0400
Date: Thu, 23 Sep 2004 18:03:23 +0200
Message-ID: <4152E6450000003B@mail-3-bnl.tiscali.it>
In-Reply-To: <20040922214304.GS16153@parcelfarce.linux.theplanet.co.uk>
From: "Joel Soete" <soete.joel@tiscali.be>
Subject: RE: [parisc-linux] [PATCH] Sort generic PCI fixups after specific ones
To: "Matthew Wilcox" <matthew@wil.cx>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@zip.com.au>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       parisc-linux@parisc-linux.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -- Original Message --
> Date: Wed, 22 Sep 2004 22:43:04 +0100
> From: Matthew Wilcox <matthew@wil.cx>
> To: Linus Torvalds <torvalds@osdl.org>,
> 	Andrew Morton <akpm@zip.com.au>
> Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
> 	parisc-linux@parisc-linux.org
> Subject: [parisc-linux] [PATCH] Sort generic PCI fixups after specific
ones
> 
> 
> 
> The recent change that allowed PCI fixups to be declared everywhere
> broke IDE on PA-RISC by making the generic IDE fixup be applied before
> the PA-RISC specific one.  This patch fixes that by sorting generic fixups
> after the specific ones.  It also obeys the 80-column limit and reduces
> the amount of grotty macro code.
> 
> I'd like to thank Joel Soete for his work tracking down the source of
> this problem.
>
Thanks (but too much honor)

That said, I apply your patch against 2.6.9-rc2-pa7 and it boot fine :)

Thanks a lot for great job,
Joel


---------------------------------------------------------------------------
Tiscali ADSL GO, 29,50 Euro/mois pendant toute une année, profitez-en...
http://reg.tiscali.be/adsl/welcome.asp?lg=FR




