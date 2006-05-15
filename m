Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWEOBhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWEOBhY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 21:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWEOBhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 21:37:24 -0400
Received: from outbound1.mail.tds.net ([216.170.230.91]:60095 "EHLO
	outbound1.mail.tds.net") by vger.kernel.org with ESMTP
	id S1751307AbWEOBhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 21:37:23 -0400
Subject: Re: MMC drivers for 2.6 collie
From: John Lenz <lenz@cs.wisc.edu>
To: Pavel Machek <pavel@suse.cz>
Cc: Richard Purdie <rpurdie@rpsys.net>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060514162410.GG2438@elf.ucw.cz>
References: <20060514145325.GA3205@elf.ucw.cz>
	 <1147619440.5531.167.camel@localhost.localdomain>
	 <20060514162410.GG2438@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 14 May 2006 20:37:49 -0500
Message-Id: <1147657069.5525.12.camel@hydra.domain.actdsltmp>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-14 at 18:24 +0200, Pavel Machek wrote:
> Hi!
> 
> > > I've tried searching sharp patches for MMC support, but could not find
> > > it. Or should MMC_ARMMMCI work on collie?
> > 
> > Sharp's 2.4 MMC/SD drivers were binary only for all Zaurus models. Since
> > we have documentation on the PXA, a 2.6 driver exists and works for all
> > PXA models as we could guess the power controls and GPIOs. Collie
> > (SA1100 based) used some kind of SPI interface through the LOCOMO chip
> > (as far as I know) which we have no documentation on.
> 
> I thought we had completely open-source version at one point?

No, not for the MMC on collie.  At least, the patch to the 2.4 kernel
which I based my 2.6 code on did not have any MMC parts, and the
openzaurus distro at the time still included the binary module in the
rom.  

IIRC, Chris Larson signed a NDA and got the specs for the MMC device on
collie to develop it for 2.6, but I don't think anything ever came of
it.  I also might be remembering he signed a NDA for some other
component, but I think it was the MMC device.  Also, the poodle and
collie used different device controllers, so the work will not transfer
over.  :(

John

