Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUE1LkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUE1LkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 07:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUE1LkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 07:40:22 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:41092 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261628AbUE1LkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:40:18 -0400
Date: Fri, 28 May 2004 13:40:17 +0200
From: Martin Mares <mj@ucw.cz>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] pciutils/linux: Support for the HyperTransport capability
Message-ID: <20040528114017.GA3708@ucw.cz>
References: <Pine.LNX.4.55.0404201720290.28193@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0404201720290.28193@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>  Here's a patch for initial support for the HyperTransport capability for
> pciutils.  I've developed full dumping code for the sub-capabilities I was
> able to test (plus for the Revision ID one, for it being so trivial) with
> my hardware.  Others are reported by their names only, without any details
> -- for a few of them it's probably most we can do anyway.

I've applied it, but I tried to simplify the code, because it seemed
unnecessarily hairy to me.  I hope I didn't break anything.

I'll release 2.1.99-test4 in a hour, so please check it once again.

>  The changes for lib/header.h are probably applicable to <linux/pci.h> as 
> well -- they apply cleanly to 2.4, but require a manual intervention for 
> 2.6 due to context changes.  I'll rediff if this patch is accepted for 
> Linux.

I would vote for keeping it in pciutils and copying it to <linux/pci.h>
when it will be needed by any kernel drivers.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Anything is good and useful if it's made of chocolate.
