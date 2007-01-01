Return-Path: <linux-kernel-owner+w=401wt.eu-S1753102AbXAATBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbXAATBX (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbXAATBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:01:23 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47017 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753580AbXAATBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:01:22 -0500
Date: Mon, 1 Jan 2007 20:01:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, maxk@qualcomm.com,
       bluez-devel@lists.sourceforge.net
Subject: Re: bluetooth memory corruption (was Re: ext3-related crash in 2.6.20-rc1)
Message-ID: <20070101190112.GB4593@elf.ucw.cz>
References: <20061223234305.GA1809@elf.ucw.cz> <20061223235501.GA1740@elf.ucw.cz> <1166971163.15485.21.camel@violet> <20061224233647.GB1761@elf.ucw.cz> <20061230215250.GF20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061230215250.GF20714@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Okay, I spoke too soon. bluetooth & suspend memory corruption was
> > > > _way_ harder to reproduce than expected. Took me 5-or-so-suspend
> > > > cycles... so it is probably unrelated to the previous crash.
> > > 
> > > can you try to reproduce this with 2.6.20-rc2 as well.
> > 
> > Yep, here it is, reproduced on 6-th-or-so suspend.
> > 
> > bluetooth may need to be actively used in order for this to trigger;
> > connecting to the net over my cellphone seems to work okay.
> > 
> > (Full logs in attachment).
> 
> Is this issue also present in 2.6.19 or is it a regression?

Not sure... but I know there were some bluetooth & suspend problems
before.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
