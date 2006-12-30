Return-Path: <linux-kernel-owner+w=401wt.eu-S1030346AbWL3Vws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWL3Vws (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 16:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWL3Vws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 16:52:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1244 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030346AbWL3Vwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 16:52:47 -0500
Date: Sat, 30 Dec 2006 22:52:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, maxk@qualcomm.com,
       bluez-devel@lists.sourceforge.net
Subject: Re: bluetooth memory corruption (was Re: ext3-related crash in 2.6.20-rc1)
Message-ID: <20061230215250.GF20714@stusta.de>
References: <20061223234305.GA1809@elf.ucw.cz> <20061223235501.GA1740@elf.ucw.cz> <1166971163.15485.21.camel@violet> <20061224233647.GB1761@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061224233647.GB1761@elf.ucw.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 25, 2006 at 12:36:47AM +0100, Pavel Machek wrote:
> On Sun 2006-12-24 15:39:23, Marcel Holtmann wrote:
> > Hi Pavel,
> > 
> > > > I got this nasty oops while playing with debugger. Not sure if that is
> > > > related; it also might be something with bluetooth; I already know it
> > > > corrupts memory during suspend, perhaps it corrupts memory in some
> > > > error path?
> > > 
> > > Okay, I spoke too soon. bluetooth & suspend memory corruption was
> > > _way_ harder to reproduce than expected. Took me 5-or-so-suspend
> > > cycles... so it is probably unrelated to the previous crash.
> > 
> > can you try to reproduce this with 2.6.20-rc2 as well.
> 
> Yep, here it is, reproduced on 6-th-or-so suspend.
> 
> bluetooth may need to be actively used in order for this to trigger;
> connecting to the net over my cellphone seems to work okay.
> 
> (Full logs in attachment).

Is this issue also present in 2.6.19 or is it a regression?

> 								Pavel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

