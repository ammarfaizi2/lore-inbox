Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbTHZWaQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 18:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbTHZWaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 18:30:16 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:8596 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262969AbTHZW3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 18:29:45 -0400
Date: Wed, 27 Aug 2003 00:29:41 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.22 released
Message-ID: <20030826222941.GB27422@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200308251148.h7PBmU8B027700@hera.kernel.org> <20030825132358.GC14108@merlin.emma.line.org> <1061818535.1175.27.camel@debian> <20030825211307.GA3346@werewolf.able.es> <20030825222215.GX7038@fs.tum.de> <1061857293.15168.3.camel@debian> <20030826234901.1726adec.aradorlinux@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030826234901.1726adec.aradorlinux@yahoo.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003, Diego Calleja García wrote:

> El Tue, 26 Aug 2003 02:21:34 +0200 Ramón Rey Vicente____ <retes_simbad@yahoo.es> escribió:
> 
> > I think merging ALSA in 2.4 series bring some of the advantages of the
> > 2.6 series to the stable kernel, just new drivers with improvements over
> > OSS... but I dont think that will help in the switching to 2.6.
> 
> 
> I agree with Ramon; OSS doesn't provide drivers for some cards (or they
> have really low quality, like the one for my card...). It's not just easing
> the migration.
> 
> Reasons to include ALSA in 2.4.23:
> 
> - Lots of people need it.
> - 99.9 % of kernels from vendors have it (they need to include them to
>   give good hardware support), which means they have been tested a lot.
> - Lots of non-vendor kernels have it (even more testing).
> - Some drivers have better quality.
> - Low impact: they don't break anything; they're just configurable drivers.
> - They're stable.
> - They're cool.
> 
> Reasons against:
> <write here your opinion>

Hum "stable"? Well, sorta. I have some machines that only work with OSS
(CMI8330 only works with OSS Windows Sound System driver, not in sound
blaster emu and not with Alsa in spite of the driver).

The killer argument is it's easy to install separately.
./configure --with-cards=YOURS && make && make install - et voilà.

-- 
Matthias Andree
