Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVAPRG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVAPRG7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 12:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVAPRG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 12:06:58 -0500
Received: from aun.it.uu.se ([130.238.12.36]:1713 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262545AbVAPRG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 12:06:57 -0500
Date: Sun, 16 Jan 2005 17:59:22 +0100 (MET)
Message-Id: <200501161659.j0GGxM1P001817@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: hch@lst.de
Subject: Re: [PATCH] fix CONFIG_AGP depencies
Cc: bunk@stusta.de, davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jan 2005 16:47:23 +0100, Christoph Hellwig wrote:
> On Sun, Jan 16, 2005 at 04:37:32PM +0100, Mikael Pettersson wrote:
> > You're preventing the ppc64 kernel for Apple PowerMac G5s
> > from including AGP support via CONFIG_AGP_UNINORTH. I doubt
> > that's correct.
> 
> It is correct.  In mainline AGP for the G5 isn't supported at all.
> On linuxppc64-dev there's a patch to support it on ppc32, but more
> work is required to make it work with ppc64.  Once that's done
> the depency can be updated.  Currently agp doesn't even compile
> on ppc64 due to a lacking <asm/agp.h> as I mentioned in the first
> mail.

Ok, in that case I have no objection to your patch.
