Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269405AbUINPZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269405AbUINPZU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269404AbUINPZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:25:08 -0400
Received: from gprs40-135.eurotel.cz ([160.218.40.135]:18025 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269081AbUINPYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:24:23 -0400
Date: Tue, 14 Sep 2004 17:24:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: seife@suse.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: HP/Compaq (Winbond) SD/MMC reader supported
Message-ID: <20040914152406.GA9581@elf.ucw.cz>
References: <41383D02.5060709@drzeus.cx> <20040913223827.GA28524@elf.ucw.cz> <41467216.6070508@drzeus.cx> <20040914150013.GB27621@elf.ucw.cz> <41470B5A.2010005@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41470B5A.2010005@drzeus.cx>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Hmm, if I disable the check (and make id 0xf00 valid), it will freeze
> >my machine during boot :-(. Where did you get documentation for this
> >beast?
> >
> Is the 0xf00 id the only one you get? If it is a SuperIO chip then 

How can I (try to) get other id's? Yes, it seems to be stable across reboots.

> resetting it will probably cause all sorts of funky problems.
> Do you know what SuperIO is used in the machine? And have you tried 
> confirming that the card reader is indeed winbond? The easiest way to do 
> that is to see if the Windows driver is wbsd.sys.

Stefan, could you take a look? I rm -rf'ed my copy of windows :-(.

SuperIO is behind ISA bridge so it can not be deduced from lspci? Or I
may be completely off mark; there's Unknown mass storage controller:
Texas Instruments PCI7420 Flash Media Controller.... Hmm, that seems
like flash.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
