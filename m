Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293375AbSCAWgd>; Fri, 1 Mar 2002 17:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310141AbSCAWgQ>; Fri, 1 Mar 2002 17:36:16 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:41991 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S293375AbSCAWfy>;
	Fri, 1 Mar 2002 17:35:54 -0500
Date: Wed, 20 Feb 2002 12:33:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre9-mjc2
Message-ID: <20020220113324.GA102@elf.ucw.cz>
In-Reply-To: <20020219092222.GA10247@atrey.karlin.mff.cuni.cz> <E16d6rj-0008Pn-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16d6rj-0008Pn-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > computer" messages vanished about the time of the IBM/AT. You instructed
> > > it to erase critical internal data, so it did.
> > 
> > I asked it to read temperature sensors *then* it commited suicide.
> 
> No. You load lm_sensors, it does a bus scan and that trashes your eeprom.
> Its an lm_sensors problem (but rather hard to avoid when poking around
> randomly inside a laptop without a clue what its doing)

Okay, so what about adding dmi _white_list to lm_sensors? That should
address your concerns... [It would also be possible to autosetup
temperature offsets/divisors etc.]
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
