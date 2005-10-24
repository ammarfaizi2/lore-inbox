Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbVJXVJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVJXVJP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 17:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVJXVJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 17:09:15 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:1668 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1751293AbVJXVJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 17:09:14 -0400
Date: Tue, 25 Oct 2005 01:09:01 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Jesse Barnes <jbarnes@virtuousgeek.org>, bcollins@debian.org,
       Greg KH <greg@kroah.com>, scjody@steamballoon.com, gregkh@suse.de
Subject: Re: new PCI quirk for Toshiba Satellite?
Message-ID: <20051025010901.B1661@jurassic.park.msu.ru>
References: <20051015185502.GA9940@plato.virtuousgeek.org> <200510211138.57847.jbarnes@virtuousgeek.org> <43594BD3.9070103@s5r6.in-berlin.de> <200510241045.08494.jbarnes@virtuousgeek.org> <435D2612.5070701@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <435D2612.5070701@s5r6.in-berlin.de>; from stefanr@s5r6.in-berlin.de on Mon, Oct 24, 2005 at 08:21:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 08:21:06PM +0200, Stefan Richter wrote:
> Once the workaround is in pci/quirks.c, a single #ifdef would suffice
> (if it is still of any benefit there).

Such an obviously i386-specific quirk should go into
arch/i386/pci/fixup.c.

Ivan.
