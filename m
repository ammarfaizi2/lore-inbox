Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272650AbTHELRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 07:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272651AbTHELRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 07:17:16 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:33993 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272650AbTHELRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 07:17:15 -0400
Date: Tue, 5 Aug 2003 13:16:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Wes Felter <wesley@felter.org>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HELP: cpufreq on HT and/or SMP systems
Message-ID: <20030805111647.GB329@elf.ucw.cz>
References: <200307312353.54735.gallir@uib.es> <pan.2003.08.01.22.36.19.940443@felter.org> <1059778307.1537.173.camel@bip.parateam.prv> <1059778865.23307.42.camel@arlx248.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059778865.23307.42.camel@arlx248.austin.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > AFAIK no SMP systems have voltage/frequency scaling (SpeedStep/PowerNow).
> > > I've heard that ACPI P-states works on SMP, but if it's not doing
> > > voltage/frequency scaling then I don't know what it's doing.
> > 
> > I've got an ABit VP6 (VIA686, dual P3), and the processors speed and
> > voltage can be set in the BIOS. Does it count ?
> 
> I meant dynamic voltage/frequency scaling, so that doesn't count.

If his bios can change voltage/frequency, kernel can probably do the
same. So his hardware probably can be supported by cpufreq.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
