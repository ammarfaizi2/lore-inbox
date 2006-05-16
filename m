Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWEPNsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWEPNsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 09:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWEPNsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 09:48:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48289 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751086AbWEPNsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 09:48:25 -0400
Date: Tue, 16 May 2006 15:47:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Lenz <lenz@cs.wisc.edu>
Cc: Richard Purdie <rpurdie@rpsys.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: MMC drivers for 2.6 collie
Message-ID: <20060516134728.GE5439@elf.ucw.cz>
References: <20060514145325.GA3205@elf.ucw.cz> <1147619440.5531.167.camel@localhost.localdomain> <20060514162410.GG2438@elf.ucw.cz> <1147657069.5525.12.camel@hydra.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147657069.5525.12.camel@hydra.domain.actdsltmp>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 14-05-06 20:37:49, John Lenz wrote:
> On Sun, 2006-05-14 at 18:24 +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > > I've tried searching sharp patches for MMC support, but could not find
> > > > it. Or should MMC_ARMMMCI work on collie?
> > > 
> > > Sharp's 2.4 MMC/SD drivers were binary only for all Zaurus models. Since
> > > we have documentation on the PXA, a 2.6 driver exists and works for all
> > > PXA models as we could guess the power controls and GPIOs. Collie
> > > (SA1100 based) used some kind of SPI interface through the LOCOMO chip
> > > (as far as I know) which we have no documentation on.
> > 
> > I thought we had completely open-source version at one point?
> 
> No, not for the MMC on collie.  At least, the patch to the 2.4 kernel
> which I based my 2.6 code on did not have any MMC parts, and the
> openzaurus distro at the time still included the binary module in the
> rom.  
> 
> IIRC, Chris Larson signed a NDA and got the specs for the MMC device on
> collie to develop it for 2.6, but I don't think anything ever came of
> it.  I also might be remembering he signed a NDA for some other
> component, but I think it was the MMC device.  Also, the poodle and
> collie used different device controllers, so the work will not transfer
> over.  :(

Bad... I need CF slot for bluetooth card, and 14MB is not really
enough memory. I guess there's no reasonable way to "split" CF slot in
two?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
