Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274922AbTHFI0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 04:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274923AbTHFI0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 04:26:30 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:54521 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S274922AbTHFI03
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 04:26:29 -0400
Date: Wed, 6 Aug 2003 10:10:46 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Wes Felter <wesley@felter.org>, Xavier Bestel <xavier.bestel@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HELP: cpufreq on HT and/or SMP systems
Message-ID: <20030806081046.GA1993@brodo.de>
References: <200307312353.54735.gallir@uib.es> <pan.2003.08.01.22.36.19.940443@felter.org> <1059778307.1537.173.camel@bip.parateam.prv> <1059778865.23307.42.camel@arlx248.austin.ibm.com> <20030805111647.GB329@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805111647.GB329@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 01:16:47PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > AFAIK no SMP systems have voltage/frequency scaling (SpeedStep/PowerNow).
> > > > I've heard that ACPI P-states works on SMP, but if it's not doing
> > > > voltage/frequency scaling then I don't know what it's doing.
> > > 
> > > I've got an ABit VP6 (VIA686, dual P3), and the processors speed and
> > > voltage can be set in the BIOS. Does it count ?
> > 
> > I meant dynamic voltage/frequency scaling, so that doesn't count.
> 
> If his bios can change voltage/frequency, kernel can probably do the
> same. So his hardware probably can be supported by cpufreq.

The cpufreq core supports SMP. But only a few SMP capable CPUs offer cpu
frequency and/or voltage scaling. Those who do (e.g. P4/Xeon, UltraSparc
variants, and some ARM processors, IIRC) are well supported by cpufreq.

	Dominik
